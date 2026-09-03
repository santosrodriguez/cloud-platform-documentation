# Reference

Fast-reference information for the Azure environments.

For common tool commands, use the [Command Cheat Sheets](../command-cheat-sheets/README.md).

## Confirmed Service Responsibilities

The responsibilities below were supplied by the user on 2026-08-31 and 2026-09-03. This is a partial list; it does not assign responsibility for other services or policies.

| Responsibility | Team | Details |
| --- | --- | --- |
| Palo Alto firewall and rule management | Cyber Defense Engineering | [Firewall Management](../architecture/hub-and-spoke-network.md#firewall-management) |
| Central management of all private DNS zones | Cloud Platform Solutions and Services | [Private DNS Zone Management](../networking/private-dns-zone-management.md) |
| Public-access exemption review and approval | Cyber Defense team in Security | [Exemption Responsibilities](../security/public-access-exemption-process.md#responsibilities) |
| Approved resource-specific Azure Policy exemption creation | Cloud Platform team | [Exemption Responsibilities](../security/public-access-exemption-process.md#responsibilities) |
| GitHub environments | DevOps Engineering Team | [Environment Responsibilities](../ci-cd/README.md#environment-responsibilities) |
| Azure DevOps environments | DevOps Engineering Team | [Environment Responsibilities](../ci-cd/README.md#environment-responsibilities) |
| Build and publish reusable Terraform modules | Cloud Platform team | [Artifactory Terraform Registry](../infrastructure-as-code/terraform-platform.md#artifactory-terraform-registry) |
| Approve production-impacting change requests | Change Board | [Production Change Management](../governance/production-change-management.md) |

Contact details, request channels, detailed approval criteria, implementation validation, and escalation procedures remain to be supplied.

## Confirmed Azure Environments

| Environment code | Connectivity boundary |
| --- | --- |
| DEV | Not cross-connected to INT, CRT, or PRD |
| INT | Not cross-connected to DEV, CRT, or PRD |
| CRT | Not cross-connected to DEV, INT, or PRD |
| PRD | Not cross-connected to DEV, INT, or CRT |

See [Environment Isolation](../architecture/environment-isolation.md). Full environment names, purpose, subscriptions, regions, and ownership remain to be documented.

## Intended Content

- Azure regions
- Subscription directory
- Management group structure
- IP address ranges
- DNS zones and resolvers
- Ports and protocols
- Additional service ownership and contacts
- Naming standards
- Tagging requirements
- Approved Terraform modules
- External authoritative references

Do not place secrets, credentials, tokens, or sensitive security material directly in reference pages.
