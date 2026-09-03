# Cloud Platform Documentation

Authoritative source for Azure Cloud Platform architecture, standards, runbooks, FAQs, service documentation, and consumer guidance.

Documentation changes should be made through pull requests.

Start at [Home](Home.md) to browse the documentation, or read [Contributing](Contributing.md) to add a page.

## Setup Status

The initial documentation structure is tracked in [PR #1](https://github.com/santosrodriguez/cloud-platform-documentation/pull/1). The repository is private and GitHub's native Wiki feature is enabled. The source files can also be browsed directly in the repository.

See [Wiki Setup](WIKI-SETUP.md) for initialization requirements and publication status.

## Directory Structure

```text
github-wiki/
|-- AGENTS.md
|-- Home.md
|-- _Sidebar.md
|-- _Footer.md
|-- Contributing.md
|-- WIKI-SETUP.md
|-- getting-started/
|-- using-azure/
|-- faq/
|-- architecture/
|-- azure-services/
|-- networking/
|-- security/
|-- governance/
|-- infrastructure-as-code/
|-- ci-cd/
|-- platform-services/
|-- standards-and-guidelines/
|-- adr/
|-- design-patterns/
|-- operations/
|-- runbooks/
|-- troubleshooting/
|-- disaster-recovery/
|-- monitoring-and-observability/
|-- reference/
|-- change-log/
|-- templates/
|-- assets/
|   |-- diagrams/
|   `-- images/
|-- prompts/
|   |-- README.md
|   |-- azure-wiki-prompt-v1.md
|   `-- azure-wiki-prompt-v2.md
|-- sources/
|-- deployments/
|   |-- README.md
|   `-- azure-wiki-assistant/
|-- scripts/
`-- wiki-pages.json
```

Section indexes describe the intended coverage. They do not claim that a service, configuration, or procedure is already deployed or approved.

The [prompt version register](prompts/README.md) identifies the current authoring prompt and records what changed in each release. Versioned prompts and `AGENTS.md` guide authoring and are not published to the Wiki. Original source material belongs in `sources/`; diagram and image files belong in `assets/`. Only pages explicitly listed in `wiki-pages.json` are exported for the native Wiki.

Infrastructure templates are kept under `deployments/`. They are source-only project material and are not exported to the native Wiki.

## Validate and Build

With Node.js 20 or later, run these commands from this directory:

```sh
node --test scripts/build-wiki.test.mjs
node scripts/build-wiki.mjs
```

The build writes the selected Markdown pages to `build/wiki/`, using unique filenames and Wiki-compatible links. It does not enable the Wiki, publish content, or change GitHub settings.
