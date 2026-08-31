import { lstat, mkdir, readFile, readdir, realpath, writeFile } from "node:fs/promises";
import { dirname, join, posix, relative, resolve, sep } from "node:path";
import { fileURLToPath } from "node:url";

const projectRoot = resolve(dirname(fileURLToPath(import.meta.url)), "..");

export function createPageMap(manifest) {
  if (!manifest || typeof manifest !== "object" || Array.isArray(manifest)) {
    throw new Error("wiki-pages.json must map source paths to Wiki filenames.");
  }

  const pages = new Map();
  const destinations = new Set();
  for (const [source, target] of Object.entries(manifest)) {
    if (!/^[A-Za-z0-9_-]+(?:\/[A-Za-z0-9_-]+)*\.md$/.test(source)) {
      throw new Error(`Invalid source path: ${source}`);
    }
    if (typeof target !== "string" || !/^(?:[A-Za-z0-9]+(?:-[A-Za-z0-9]+)*|_Sidebar|_Footer)\.md$/.test(target)) {
      throw new Error(`Invalid Wiki filename for ${source}: ${target}`);
    }
    if (destinations.has(target.toLowerCase())) {
      throw new Error(`Duplicate Wiki filename: ${target}`);
    }
    destinations.add(target.toLowerCase());
    pages.set(source, target);
  }
  if (pages.get("Home.md") !== "Home.md") {
    throw new Error("The manifest must publish Home.md as Home.md.");
  }
  return pages;
}

export function rewriteLinks(markdown, source, pages) {
  function rewriteTarget(raw) {
    const match = raw.match(/^(<[^>]+>|\S+)([\s\S]*)$/);
    if (!match) return raw;
    const angled = match[1].startsWith("<");
    const href = angled ? match[1].slice(1, -1) : match[1];
    if (/^(?:[a-z][a-z0-9+.-]*:|\/\/|#)/i.test(href)) return raw;

    const boundary = href.search(/[?#]/);
    const path = boundary < 0 ? href : href.slice(0, boundary);
    const suffix = boundary < 0 ? "" : href.slice(boundary);
    const resolvedSource = posix.normalize(posix.join(posix.dirname(source), decodeURIComponent(path)));
    const target = path.startsWith("/") ? undefined : pages.get(resolvedSource);
    if (!target) {
      throw new Error(`${source}: unpublished or missing local link: ${href}`);
    }
    const wikiLink = target.slice(0, -3) + suffix;
    return (angled ? `<${wikiLink}>` : wikiLink) + match[2];
  }

  let fence;
  return markdown.split("\n").map((line) => {
    const marker = line.match(/^ {0,3}(`{3,}|~{3,})(.*)$/);
    if (fence) {
      if (marker && marker[1][0] === fence[0] && marker[1].length >= fence.length && !marker[2].trim()) {
        fence = undefined;
      }
      return line;
    }
    if (marker) {
      fence = marker[1];
      return line;
    }

    // Preserve code examples while converting inline and reference-style links.
    if (/^(?: {4}|\t)/.test(line)) return line;
    const reference = line.match(/^( {0,3}\[(?!\^)[^\]]+\]:\s*)(.*)$/);
    if (reference) return reference[1] + rewriteTarget(reference[2]);
    return line.replace(/(`+).*?\1|(!?\[[^\]\n]*\])\(([^)\n]+)\)/g, (match, code, label, target) => {
      return code ? match : `${label}(${rewriteTarget(target.trim())})`;
    });
  }).join("\n");
}

export async function buildWiki(root = projectRoot) {
  const canonicalRoot = await realpath(root);
  const pages = createPageMap(JSON.parse(await readFile(join(canonicalRoot, "wiki-pages.json"), "utf8")));
  const rendered = new Map();

  // Validate every source and link before writing any output.
  for (const [source, target] of pages) {
    const file = await realpath(join(canonicalRoot, source));
    const fromRoot = relative(canonicalRoot, file);
    if (fromRoot === ".." || fromRoot.startsWith(`..${sep}`)) {
      throw new Error(`Source resolves outside the project: ${source}`);
    }
    const markdown = await readFile(file, "utf8");
    rendered.set(target, rewriteLinks(markdown, source, pages));
  }

  const buildDirectory = join(canonicalRoot, "build");
  const outputDirectory = join(buildDirectory, "wiki");
  for (const directory of [buildDirectory, outputDirectory]) {
    await mkdir(directory, { recursive: true });
    const info = await lstat(directory);
    if (!info.isDirectory() || info.isSymbolicLink()) {
      throw new Error(`Build directory must not be a symbolic link: ${directory}`);
    }
  }
  for (const entry of await readdir(outputDirectory, { withFileTypes: true })) {
    if (!rendered.has(entry.name) || !entry.isFile()) {
      throw new Error(`Unexpected output entry; review it before rebuilding: build/wiki/${entry.name}`);
    }
  }
  for (const [target, markdown] of rendered) {
    await writeFile(join(outputDirectory, target), markdown);
  }
  return { outputDirectory, pages: rendered.size };
}

if (process.argv[1] && resolve(process.argv[1]) === fileURLToPath(import.meta.url)) {
  try {
    const result = await buildWiki();
    console.log(`Built ${result.pages} Wiki files in ${result.outputDirectory}`);
    console.log("Local Markdown page links are valid. Nothing has been published.");
  } catch (error) {
    console.error(error.message);
    process.exitCode = 1;
  }
}
