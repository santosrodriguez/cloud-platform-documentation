# Using Azure

This section is written for teams that consume the Azure platform.

Use it to answer common questions about how to deploy, connect, secure, monitor, and operate workloads in our Azure environment.

## Common Topics

- Getting started in Azure
- Application onboarding
- Requesting Azure resources
- [Workload VNet traffic routing and inspection](../architecture/hub-and-spoke-network.md)
- [ExpressRoute access to on-premises](../networking/expressroute-connectivity.md)
- [DEV, INT, CRT, and PRD environment isolation](../architecture/environment-isolation.md)
- [Private Endpoints and private service access](../networking/private-endpoints.md)
- [Private DNS zone management by Cloud Platform Solutions and Services](../networking/private-dns-zone-management.md)
- [Application ingress through Fastly and Azure Application Gateway](../platform-services/application-ingress.md)
- [Azure identity and access: MFA and administrative-account requirements](../security/identity-and-access-requirements.md)
- [Certificates and Key Vault: purge protection requirement](../security/resource-security-baseline.md#resource-specific-requirements)
- [Monitoring and logging: Dynatrace, Azure-native solutions, and AMPLS](../monitoring-and-observability/README.md)
- [Terraform platform: reusable modules, registry, state, and workflows](../infrastructure-as-code/terraform-platform.md)
- [GitHub, Azure DevOps, and CI/CD](../ci-cd/README.md)
- [AKS node pools, ingress, local-account, and Azure RBAC requirements](../platform-services/aks.md)
- [Azure API Management](../platform-services/api-management.md)
- [Storage Accounts: soft-delete and container-public-access requirements](../security/resource-security-baseline.md#resource-specific-requirements)
- Disaster recovery
- [Security requirements: public access, TLS, deletion protection, Storage Account container public access, AKS local accounts, and Azure RBAC](../security/resource-security-baseline.md)
- [Requesting a public-access exemption](../security/public-access-exemption-process.md)
- [Production change approval](../governance/production-change-management.md)
- [Zero Trust policy](../security/zero-trust-policy.md)
- Supported architecture patterns
- [Known service responsibilities](../reference/README.md#confirmed-service-responsibilities)
- Getting help
- [Troubleshooting common platform issues](../troubleshooting/README.md)
- [Following operational runbooks](../runbooks/README.md)

## Documentation Goal

A reader should be able to determine:

1. What is supported.
2. Which pattern to use.
3. What requirements apply.
4. What the Cloud Platform team manages.
5. What the consuming team manages.
6. How to validate the solution.
7. Where to go for troubleshooting or escalation.
