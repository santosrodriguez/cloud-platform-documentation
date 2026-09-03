# Azure Services

Documentation for Azure services managed, governed, or commonly consumed through the Cloud Platform.

Each service page should explain purpose, architecture, dependencies, networking, identity, security, deployment, monitoring, operations, disaster recovery, troubleshooting, and known limitations where applicable.

## Documented Services

- [Application Ingress](../platform-services/application-ingress.md): Fastly fronts our application environments and forwards traffic to Azure Application Gateway, which fronts the applications; detailed configuration, ownership, and operations remain pending.
- [Azure Kubernetes Service (AKS)](../platform-services/aks.md): Application Gateway Ingress Controller is the confirmed ingress controller; local accounts must be disabled and Azure RBAC for Kubernetes Authorization must be enabled on every AKS cluster; current compliance, detailed architecture, and operations remain pending.

## Cross-Service Requirements

The [resource-specific Resource Security Baseline requirements](../security/resource-security-baseline.md#resource-specific-requirements) require purge protection for Azure Key Vault, soft delete and disabled container public access for Azure Storage Accounts, disabled local accounts on AKS clusters, and enabled Azure RBAC for Kubernetes Authorization on AKS clusters. Detailed service configuration and compliance remain unverified.
