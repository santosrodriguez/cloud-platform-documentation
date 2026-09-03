# Azure Wiki Prompt Versions

This directory stores released versions of the reusable prompt used to create and improve the Azure Cloud Platform Wiki. Prompt files are source-only authoring material and must not be included in the published GitHub Wiki.

## Current Version

| Version | Status | Release date | Prompt |
| --- | --- | --- | --- |
| 2.0 | Active | 2026-09-03 | [Azure Wiki prompt v2](azure-wiki-prompt-v2.md) |

`AGENTS.md` must identify the active prompt so documentation work consistently uses the current instructions.

## Version History

| Version | Status | Release date | Summary |
| --- | --- | --- | --- |
| 2.0 | Active | 2026-09-03 | Rebuilt the prompt around a customer-centered Wiki experience while retaining the Azure engineering documentation requirements. |
| 1.0 | Superseded | 2026-08-31 | Established the original Azure Cloud Platform GitHub Wiki authoring, structure, formatting, diagram, and quality instructions. |

## Change Notes

### Version 2.0

File: [azure-wiki-prompt-v2.md](azure-wiki-prompt-v2.md)

- Added explicit audience models and customer-experience principles.
- Added customer journey pages, a service catalog, page metadata, and status conventions.
- Strengthened Home page, sidebar, footer, navigation, and GitHub Wiki delivery requirements.
- Added visual design, accessibility, search, discoverability, support, and feedback guidance.
- Added content lifecycle, quality gate, and platform decision-boundary requirements.
- Retained the architecture, service, standards, runbook, troubleshooting, ADR, accuracy, evidence, and no-invention requirements from version 1.

### Version 1.0

File: [azure-wiki-prompt-v1.md](azure-wiki-prompt-v1.md)

- Imported the original prompt from the "Write Azure Wiki Prompt" task.
- Established the documentation role, objectives, information architecture, page types, Markdown rules, diagram rules, and writing behavior.

## Versioning Rules

1. Treat every released prompt file as immutable. Make improvements in a new file rather than overwriting an existing release.
2. Use the sequential filename `azure-wiki-prompt-v<major>.md` and matching `<major>.0` metadata inside the prompt.
3. Include the release date and a concise primary-focus statement near the beginning of every new prompt.
4. Add the new release to this register, list its material changes, and mark the previous release as superseded.
5. Update `AGENTS.md` to point to the new active prompt.
6. Make prompt changes through a branch and pull request.

## Release Checklist

- Confirm the new prompt is complete and can be used without reading an older version.
- Confirm organization-specific statements remain accurate and do not invent unverified standards, owners, configurations, or procedures.
- Check Markdown structure, code-fence balance, ASCII compatibility, and trailing whitespace.
- Run the Wiki build tests and build command.
- Confirm `wiki-pages.json` does not publish any file in this directory.
- Record the release date and change summary in this file before merging.
