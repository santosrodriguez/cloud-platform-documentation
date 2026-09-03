# Using Azure

This section is written for teams that consume the Azure platform.

Use it to answer common questions about how to deploy, connect, secure, monitor, and operate workloads in our Azure environment.

## Choose a Task

### Get Started and Submit a Request

| I need to... | Start here |
| --- | --- |
| Understand the platform and how to use this Wiki | [Getting Started](../getting-started/README.md) |
| Find the Firewall Request, Cloud Platform Request, or ICETA Request | [Requests and Forms](requests-and-forms.md) |
| Understand the DEV, INT, CRT, and PRD boundaries | [Environment Isolation](../architecture/environment-isolation.md) |

### Connect and Publish a Workload

| I need to... | Start here |
| --- | --- |
| Understand workload traffic routing and Palo Alto inspection | [Hub-and-Spoke Network](../architecture/hub-and-spoke-network.md) |
| Reach on-premises through ExpressRoute | [ExpressRoute Connectivity](../networking/expressroute-connectivity.md) |
| Connect privately to a supported Azure service | [Private Endpoints](../networking/private-endpoints.md) |
| Understand private DNS ownership and changes | [Private DNS Zone Management](../networking/private-dns-zone-management.md) |
| Publish an application through Fastly and Application Gateway | [Application Ingress](../platform-services/application-ingress.md) |

### Build and Deploy with Platform Services

| I need to... | Start here |
| --- | --- |
| Use AKS and understand its node-pool, ingress, and access requirements | [Azure Kubernetes Service](../platform-services/aks.md) |
| Publish or consume APIs through the platform API service | [Azure API Management](../platform-services/api-management.md) |
| Use reusable Terraform modules, state, and workflows | [Terraform Platform](../infrastructure-as-code/terraform-platform.md) |
| Understand GitHub, Azure DevOps, and deployment responsibilities | [CI/CD](../ci-cd/README.md) |

### Meet Security and Governance Requirements

| I need to... | Start here |
| --- | --- |
| Understand MFA and administrative-account requirements | [Azure Identity and Access Requirements](../security/identity-and-access-requirements.md) |
| Apply public-access, TLS, Key Vault, Storage Account, and AKS controls | [Resource Security Baseline](../security/resource-security-baseline.md) |
| Understand the platform security policy | [Zero Trust Policy](../security/zero-trust-policy.md) |
| Request public access for a specific resource | [Public Access Exemption Process](../security/public-access-exemption-process.md) |
| Prepare a production-impacting change | [Production Change Management](../governance/production-change-management.md) |

### Monitor, Troubleshoot, and Get Help

| I need to... | Start here |
| --- | --- |
| Understand Dynatrace, Azure-native monitoring, and AMPLS | [Monitoring and Observability](../monitoring-and-observability/README.md) |
| Diagnose a private connectivity, AKS, Terraform, or APIM problem | [Troubleshooting](../troubleshooting/README.md) |
| Follow a repeatable operational check | [Runbooks](../runbooks/README.md) |
| Find confirmed team responsibilities and environment references | [Reference](../reference/README.md) |

## Topics Still to Document

- End-to-end application onboarding
- Complete Azure resource and platform-service request journeys
- Customer-facing disaster recovery guidance
- Supported architecture-pattern selection guidance
- Confirmed support and incident-escalation channels

These are documentation gaps, not links to currently documented services or procedures.

## Documentation Goal

A reader should be able to determine:

1. What is supported.
2. Which pattern to use.
3. What requirements apply.
4. What the Cloud Platform team manages.
5. What the consuming team manages.
6. How to validate the solution.
7. Where to go for troubleshooting or escalation.
