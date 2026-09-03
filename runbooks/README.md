# Runbooks

**Status:** Draft operational guidance. Each runbook states its own review and test status.

Operational runbooks for repeatable Cloud Platform checks and change preparation.

## Available Runbooks

| Runbook | Purpose | Change risk |
| --- | --- | --- |
| [Validate a Private Endpoint](validate-private-endpoint.md) | Verify DNS, endpoint approval, TCP, and TLS evidence | Read-only diagnostics |
| [Triage an AKS Workload](triage-aks-workload.md) | Bound an AKS, workload, Service, Ingress, or AGIC failure | Read-only diagnostics |
| [Validate a Terraform Change](validate-terraform-change.md) | Validate source and plan readiness before deployment | Local files and remote read/plan activity; no apply |
| [Prepare a Production Change](prepare-production-change.md) | Prepare and verify the ServiceNow and Change Board gate | Administrative preparation; no deployment |

> **Review status:** These runbooks are useful drafts, not claims of approved organization-specific procedures. Do not use a draft runbook to bypass an established operational, security, incident, or change-management process.

## Runbook Safety

- Confirm the environment and scope before running a command.
- Start with read-only actions and stop when the required permission or expected result is unclear.
- Use designated administrative accounts and MFA for elevated Azure access.
- Keep public access disabled and use Private Endpoints where supported and applicable.
- Preserve separation between DEV, INT, CRT, and PRD.
- Use reviewed Terraform and GitHub Actions for infrastructure changes.
- Obtain Change Board approval of the ServiceNow change request before a production-impacting implementation.
- Sanitize evidence and never record secrets, state files, tokens, keys, or sensitive customer data.

## Required Runbook Structure

Each runbook should include purpose, when to use it, prerequisites, required access, expected impact, procedure, validation, rollback, troubleshooting, escalation, and references.

[Troubleshooting](../troubleshooting/README.md) | [Operations](../operations/README.md) | [Home](../Home.md)
