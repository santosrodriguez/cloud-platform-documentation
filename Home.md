# Cloud Platform Wiki

Welcome to the Cloud Platform Engineering knowledge base.

This knowledge base brings together Azure platform architecture, standards, shared services, operational procedures, design decisions, troubleshooting guidance, and self-service information for teams that consume Azure.

> **Status: documentation in progress.** Recorded architecture and requirements are identified on individual pages. Many sections still describe planned coverage, and detailed configuration, ownership, and operational procedures remain pending.

## Start Here

| I need to... | Start here |
| --- | --- |
| Understand the platform and this knowledge base | [Getting Started](getting-started/README.md) |
| Onboard a workload or request a platform capability | [Using Azure](using-azure/README.md) |
| Find a common request form | [Requests and Forms](using-azure/requests-and-forms.md) |
| Find an answer to a recurring question | [FAQ](faq/README.md) |
| Follow an operational procedure | [Runbooks](runbooks/README.md) |
| Diagnose a problem | [Troubleshooting](troubleshooting/README.md) |
| Prepare a production-impacting change | [Production Change Management](governance/production-change-management.md) |
| Find a common Terraform, Bash, Azure CLI, or PowerShell command | [Command Cheat Sheets](command-cheat-sheets/README.md) |
| Find ownership and environment reference information | [Reference](reference/README.md) |

## Architecture and Services

- [Architecture](architecture/README.md)
- [Hub-and-Spoke Network](architecture/hub-and-spoke-network.md)
- [Environment Isolation](architecture/environment-isolation.md)
- [Azure Services](azure-services/README.md)
- [Networking](networking/README.md)
- [Private Endpoints](networking/private-endpoints.md)
- [ExpressRoute Connectivity](networking/expressroute-connectivity.md)
- [Private DNS Zone Management](networking/private-dns-zone-management.md)
- [Platform Services](platform-services/README.md)
- [Application Ingress](platform-services/application-ingress.md)
- [Azure Kubernetes Service (AKS)](platform-services/aks.md)
- [Azure API Management](platform-services/api-management.md)
- [Design Patterns](design-patterns/README.md)
- [Architecture Decisions](adr/README.md)

## Engineering and Governance

- [Infrastructure as Code](infrastructure-as-code/README.md)
- [Terraform Platform](infrastructure-as-code/terraform-platform.md)
- [CI/CD](ci-cd/README.md)
- [Security](security/README.md)
- [Zero Trust Policy](security/zero-trust-policy.md)
- [Azure Identity and Access Requirements](security/identity-and-access-requirements.md)
- [Resource Security Baseline](security/resource-security-baseline.md)
- [Public Access Exemption Process](security/public-access-exemption-process.md)
- [Governance](governance/README.md)
- [Production Change Management](governance/production-change-management.md)
- [Standards and Guidelines](standards-and-guidelines/README.md)

## Operations and Reliability

- [Operations](operations/README.md)
- [Monitoring and Observability](monitoring-and-observability/README.md)
- [Azure Monitor Private Link Scope](monitoring-and-observability/azure-monitor-private-link-scope.md)
- [Disaster Recovery](disaster-recovery/README.md)
- [Runbooks](runbooks/README.md)
- [Troubleshooting](troubleshooting/README.md)

## Command Cheat Sheets

- [Terraform](command-cheat-sheets/terraform.md)
- [Bash](command-cheat-sheets/bash.md)
- [Azure CLI](command-cheat-sheets/azure-cli.md)
- [PowerShell](command-cheat-sheets/powershell.md)

## Maintain This Knowledge Base

- [Contributing](Contributing.md)
- [Page Templates](templates/README.md)
- [Change Log](change-log/README.md)

## For Application and Platform Consumers

Start with [Using Azure](using-azure/README.md) for common questions, supported patterns, onboarding guidance, and service consumption information.

## For Cloud Platform Engineers

Use the architecture, security, governance, infrastructure-as-code, operations, runbooks, and ADR sections for authoritative engineering documentation.

> **Documentation principle**
> External documentation explains how Azure works. This Wiki explains how Azure works in our organization.
