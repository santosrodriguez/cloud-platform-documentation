# Troubleshooting

**Status:** Draft diagnostic guidance. The published guides favor read-only evidence collection; organization-specific support and remediation procedures remain to be reviewed.

Use this section to identify the failing layer before changing infrastructure. Start with the narrowest, lowest-risk check and preserve the platform's security and environment boundaries.

## Choose a Guide

| Problem | Guide | Start with |
| --- | --- | --- |
| Azure service name does not resolve or a Private Endpoint is unreachable | [Private Connectivity](private-connectivity.md) | Source environment, DNS answer, endpoint state, port, and timestamp |
| AKS Pod, Service, Ingress, or AGIC issue | [Azure Kubernetes Service](aks.md) | Azure and Kubernetes context, node pools, Pod state, events, and Service endpoints |
| Terraform module, initialization, state, plan, or GitHub Actions issue | [Terraform Workflows](terraform.md) | Repository, environment, Terraform version, failure phase, and sanitized error |
| APIM gateway, API policy, or backend failure | [Azure API Management](api-management.md) | Request status, correlation identifier, DNS, gateway reachability, and backend evidence |

## First Five Minutes

1. Record the impact, start time in UTC, affected environment, resource or service, and a sanitized error.
2. Confirm the active Azure tenant, subscription, Kubernetes context, repository, or Terraform state scope before interpreting results.
3. Determine whether the issue affects one user, one workload, one environment, or the wider platform.
4. Identify the last known successful layer and the most recent relevant change.
5. Use a non-mutating check from the affected environment; do not compare by connecting environments.
6. Preserve correlation identifiers, timestamps, and narrowly scoped logs while removing secrets and sensitive data.

Each guide labels customer-safe checks separately from privileged operator actions. Stop and escalate when the next diagnostic step requires access that is not already authorized.

## Troubleshooting Guardrails

- Do not enable public access as a diagnostic shortcut. Public access is disabled by default, and private access should use Private Endpoints where supported and applicable.
- Do not create a connection between DEV, INT, CRT, and PRD to work around a dependency failure.
- Do not change centrally managed Private DNS zones without the approved process.
- Do not change Palo Alto firewall rules without Cyber Defense Engineering.
- Do not use AKS local accounts or admin credentials; local accounts are disabled and Azure RBAC is required.
- Do not force-unlock Terraform state, change a backend, bypass Artifactory, or run an unreviewed apply.
- Do not retrieve or share credentials, tokens, keys, Terraform state, sensitive plan output, Kubernetes Secrets, or private customer data.
- A production-impacting correction requires an approved ServiceNow change request before implementation.

## Build an Escalation Package

Include only what the receiving team needs:

- environment and precise affected scope
- customer and service impact
- UTC start time and test timestamps
- expected and observed behavior
- sanitized errors, status codes, and correlation identifiers
- identity and subscription context without tokens
- DNS, endpoint, node-pool, service, workflow, or activity evidence relevant to the failing layer
- recent change, pull request, workflow run, or ServiceNow change reference
- checks already completed and their results

Support channels, incident severities, response commitments, and service-specific escalation owners remain to be documented. Do not delay an established incident process merely because this Wiki does not yet record it.

## Related Runbooks

- [Validate a Private Endpoint](../runbooks/validate-private-endpoint.md)
- [Triage an AKS Workload](../runbooks/triage-aks-workload.md)
- [Validate a Terraform Change](../runbooks/validate-terraform-change.md)
- [Prepare a Production Change](../runbooks/prepare-production-change.md)

[Operations](../operations/README.md) | [Runbooks](../runbooks/README.md) | [Home](../Home.md)
