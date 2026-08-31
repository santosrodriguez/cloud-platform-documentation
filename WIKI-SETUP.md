# GitHub Wiki Setup

## Current State

Last checked: 2026-08-31.

- Repository: [santosrodriguez/cloud-platform-documentation](https://github.com/santosrodriguez/cloud-platform-documentation).
- Visibility: private. Keep it private.
- Documentation source: `main`, after pull-request review.
- Initial setup: [PR #1](https://github.com/santosrodriguez/cloud-platform-documentation/pull/1), branch `docs/initial-wiki-structure`.
- This project folder is now a standalone checkout of that repository.
- GitHub's native Wiki feature is enabled, verified through `has_wiki: true` after the account owner enabled it.
- The Wiki repository is initialized and accessible. Its default branch is `master`, independently of the source repository's `main` branch.
- The local Wiki checkout is `.wiki-checkout/`, inside this project directory and excluded from the source repository.
- Live destination: [Cloud Platform Wiki](https://github.com/santosrodriguez/cloud-platform-documentation/wiki). Its page history records publications; a local build alone does not publish anything.

GitHub permits wikis on public repositories with GitHub Free. A private repository owned by a personal account requires GitHub Pro; organization repositories require a suitable paid organization plan. See [GitHub's Wiki availability rules](https://docs.github.com/en/communities/documenting-your-project-with-wikis/about-wikis).

Do not change repository visibility to work around the plan requirement. The Markdown source remains usable in the private repository without the native Wiki feature.

## Initialize the Wiki Repository

Initialization is complete for this repository. When setting up another Wiki, the first page must be created on GitHub:

1. Open the repository's [Wiki tab](https://github.com/santosrodriguez/cloud-platform-documentation/wiki) while signed in.
2. If GitHub displays **Create the first page**, create a page titled **Home** with a neutral notice that reviewed documentation is being prepared, then save it.
3. Verify that `git ls-remote https://github.com/santosrodriguez/cloud-platform-documentation.wiki.git` returns a branch reference. If a page already exists but this command still fails, check Git authentication and repository access rather than replacing existing content.

GitHub requires an initial page before the Wiki repository can be cloned. See [adding or editing Wiki pages](https://docs.github.com/en/communities/documenting-your-project-with-wikis/adding-or-editing-wiki-pages).

## Prepare Reviewed Content

Review and merge PR #1 before publishing its contents. Keep all work, including build output and the Wiki checkout, inside this project directory.

From this directory, with a clean working tree:

```sh
git switch main
git pull --ff-only origin main
node --test scripts/build-wiki.test.mjs
node scripts/build-wiki.mjs
```

The builder uses `wiki-pages.json` to give section indexes unique Wiki filenames. It rewrites local Markdown page links while leaving the source tree browsable in the ordinary repository.

Only mapped Markdown pages are exported. Prompts, agent instructions, this setup document, original source documents, and assets are not exported. If a future page needs an image or another asset, extend the export process deliberately before publication.

The link check covers local page destinations, not heading anchors or the availability of external websites. The converter handles inline and reference-style Markdown links; keep links out of raw HTML and keep code examples in standard fenced blocks.

## First Publication

Once the Wiki is enabled and its initial Home page exists:

```sh
git clone https://github.com/santosrodriguez/cloud-platform-documentation.wiki.git .wiki-checkout
rsync -av build/wiki/ .wiki-checkout/
git -C .wiki-checkout diff --stat
git -C .wiki-checkout diff
```

Review the changes before committing. If existing Wiki pages contain useful content, reconcile them with the source repository before overwriting them. The copy command does not delete unrelated Wiki files.

After review:

```sh
git -C .wiki-checkout add -- '*.md'
git -C .wiki-checkout diff --cached --stat
git -C .wiki-checkout commit -m "Publish reviewed Cloud Platform documentation"
git -C .wiki-checkout push
```

The clone tracks the Wiki's existing default branch; do not assume it matches the source repository's `main` branch. For later publications, update the existing Wiki checkout instead of cloning over it. Do not force-push.

GitHub recognizes `_Sidebar.md` and `_Footer.md` as navigation files. See [Wiki sidebar and footer documentation](https://docs.github.com/en/communities/documenting-your-project-with-wikis/creating-a-footer-or-sidebar-for-your-wiki).

## Verify Publication

- Open the Wiki Home page and check every sidebar section.
- Confirm that pages have distinct titles rather than repeated README titles.
- Confirm that prompts and original source material were not published.
- Confirm that the repository and Wiki remain private.
- Update this setup status after activation and publication.

No automatic publishing workflow is installed. Publishing from a reviewed `main` branch is a separate action until an authenticated, reviewed automation is configured.
