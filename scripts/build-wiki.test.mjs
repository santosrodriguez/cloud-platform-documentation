import assert from "node:assert/strict";
import { access, mkdir, mkdtemp, readFile, readdir, rm, symlink, writeFile } from "node:fs/promises";
import { dirname, join, resolve } from "node:path";
import test from "node:test";
import { fileURLToPath } from "node:url";
import { buildWiki, createPageMap, rewriteLinks } from "./build-wiki.mjs";

const pages = createPageMap({ "Home.md": "Home.md", "networking/README.md": "Networking.md" });
const projectRoot = resolve(dirname(fileURLToPath(import.meta.url)), "..");

async function fixture(t) {
  const cache = join(projectRoot, ".cache");
  await mkdir(cache, { recursive: true });
  const root = await mkdtemp(join(cache, "wiki-test-"));
  t.after(() => rm(root, { recursive: true, force: true }));
  await writeFile(join(root, "wiki-pages.json"), JSON.stringify(Object.fromEntries(pages)));
  await mkdir(join(root, "networking"));
  await writeFile(join(root, "Home.md"), "# Home\n\n[Networking](networking/README.md)\n");
  await writeFile(join(root, "networking/README.md"), "# Networking\n\n[Home](../Home.md)\n");
  return root;
}

test("rejects filenames that collide in the Wiki or escape the project", () => {
  assert.throws(() => createPageMap({ "Home.md": "Home.md", "other.md": "home.md" }), /Duplicate/);
  assert.throws(() => createPageMap({ "Home.md": "Home.md", "../private.md": "Private.md" }), /Invalid source/);
  assert.throws(() => createPageMap({ "Home.md": "Home.md", "other.md": "../Other.md" }), /Invalid Wiki/);
  assert.throws(() => createPageMap({}), /Home.md/);
});

test("converts nested links, fragments, titles, and reference targets", () => {
  assert.equal(
    rewriteLinks('[Home](../Home.md#start "Start here")\n[guide]: <../Home.md> "Home"', "networking/README.md", pages),
    '[Home](Home#start "Start here")\n[guide]: <Home> "Home"',
  );
});

test("leaves code examples, external URLs, and same-page fragments unchanged", () => {
  const markdown = [
    "`[Example](missing.md)`",
    "```markdown", "[Example](missing.md)", "```",
    "~~~markdown", "[Example](missing.md)", "~~~",
    "    [Example](missing.md)",
    "[GitHub](https://github.com/example) [Section](#section)",
  ].join("\n");
  assert.equal(rewriteLinks(markdown, "Home.md", pages), markdown);
});

test("rejects links to unpublished source material and missing pages", () => {
  assert.throws(() => rewriteLinks("[Prompt](prompts/azure-wiki-prompt-v2.md)", "Home.md", pages), /unpublished or missing/);
  assert.throws(() => rewriteLinks("[Missing](missing.md)", "Home.md", pages), /unpublished or missing/);
});

test("exports only selected pages with native Wiki links", async (t) => {
  const root = await fixture(t);
  await writeFile(join(root, "private-notes.md"), "Not selected for publication.");
  const result = await buildWiki(root);
  assert.equal(result.pages, 2);
  assert.deepEqual((await readdir(result.outputDirectory)).sort(), ["Home.md", "Networking.md"]);
  assert.match(await readFile(join(result.outputDirectory, "Home.md"), "utf8"), /\[Networking\]\(Networking\)/);
  await buildWiki(root);
});

test("invalid links fail before generating partial output", async (t) => {
  const root = await fixture(t);
  await writeFile(join(root, "networking/README.md"), "[Missing](missing.md)");
  await assert.rejects(buildWiki(root), /unpublished or missing/);
  await assert.rejects(access(join(root, "build")), { code: "ENOENT" });
});

test("rejects sources that resolve outside the project", async (t) => {
  const root = await fixture(t);
  const outside = await mkdtemp(join(projectRoot, ".cache/wiki-outside-"));
  t.after(() => rm(outside, { recursive: true, force: true }));
  await writeFile(join(outside, "document.md"), "Outside the fixture project.");
  await writeFile(join(root, "wiki-pages.json"), JSON.stringify({ ...Object.fromEntries(pages), "outside.md": "Outside.md" }));
  await symlink(join(outside, "document.md"), join(root, "outside.md"));
  await assert.rejects(buildWiki(root), /outside the project/);
});

test("does not overwrite an unexpected file or follow an output symlink", async (t) => {
  const root = await fixture(t);
  const result = await buildWiki(root);
  await writeFile(join(result.outputDirectory, "unrelated.txt"), "Preserve me.");
  await assert.rejects(buildWiki(root), /Unexpected output entry/);
  assert.equal(await readFile(join(result.outputDirectory, "unrelated.txt"), "utf8"), "Preserve me.");

  const otherRoot = await fixture(t);
  await symlink(join(root, "build"), join(otherRoot, "build"));
  await assert.rejects(buildWiki(otherRoot), /symbolic link/);
});
