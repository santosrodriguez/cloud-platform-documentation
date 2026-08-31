# Contributing

This repository is the documentation source. Propose changes through a branch and pull request so platform owners can review them before publication.

## Add or Update a Page

1. Search the existing sections for an answer before creating a new page.
2. Identify the audience: platform consumer, platform engineer, operator, or reviewer.
3. Choose the appropriate section and [page template](templates/README.md).
4. Explain the purpose, rationale, organization-specific implementation, and operation where applicable.
5. State the document status, owner, review date, prerequisites, and evidence. Leave unknown details explicitly unconfirmed.
6. Use relative Markdown links and link back to the section index. Keep FAQ answers short and link to detailed pages.
7. Add the page to its section index and register its unique Wiki filename in `wiki-pages.json`.
8. Run the validation commands documented in the repository README and open a pull request.

## Review Expectations

- Confirm technical claims against source material and the relevant service owner.
- Distinguish approved requirements from proposals and examples.
- Verify permissions, impact, validation, rollback, and escalation for operational procedures.
- Never include passwords, tokens, private keys, or secrets in documentation or examples.
- Keep source documents and authoring prompts out of the published pages.
- Use [Architecture Decision Records](adr/README.md) for significant design decisions.

## Publish

Publish only content that has been reviewed and merged into `main`. GitHub's native Wiki has separate Git storage; pushing documentation to this repository does not publish it there automatically.

The repository's `WIKI-SETUP.md` records activation requirements and the publication procedure.

[Home](Home.md)
