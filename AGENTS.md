# Project Scope

The directory containing this file (`github-wiki`) is the working root for this project.

- Keep all project files, imported material, wiki pages, diagrams, and generated assets within this directory.
- Run project commands from this directory and keep their outputs here.
- Do not modify files in the parent directory or sibling projects as part of this work.
- This directory has its own Git repository connected to `santosrodriguez/cloud-platform-documentation`. Do not use the parent repository for this project.

The original prompt imported from the "Write Azure Wiki Prompt" task is `azure-wiki-prompt.md`. The current authoring prompt is `azure-wiki-prompt-v2.md`.

## Documentation Workflow

- Read `azure-wiki-prompt-v2.md` before writing or restructuring wiki content.
- Keep reusable prompt instructions separate from the documentation pages.
- Use branches and pull requests for changes. `main` is the reviewed source of truth; do not publish unmerged documentation.
- Preserve the repository's private visibility. Do not change visibility or purchase a plan to enable a feature without the user's explicit instruction.
- Clearly identify planned content and unverified organization-specific details. Do not invent deployed configuration, owners, access procedures, or approved standards.
- Keep Markdown links relative so the source is browsable in GitHub.
- Register published pages in `wiki-pages.json`; `node scripts/build-wiki.mjs` converts source links to unique Wiki page names.
- Keep prompts, agent instructions, source documents, and repository setup material out of the published Wiki.
- Run `node --test scripts/build-wiki.test.mjs` and `node scripts/build-wiki.mjs` before proposing publication changes.
