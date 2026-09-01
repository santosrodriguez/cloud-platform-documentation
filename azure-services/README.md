# Azure Services

Documentation for Azure services managed, governed, or commonly consumed through the Cloud Platform.

Each service page should explain purpose, architecture, dependencies, networking, identity, security, deployment, monitoring, operations, disaster recovery, troubleshooting, and known limitations where applicable.

## Documented Services

- [Azure Kubernetes Service (AKS)](../platform-services/aks.md): Application Gateway Ingress Controller is the confirmed ingress controller, and local accounts must be disabled on every AKS cluster; current compliance, detailed architecture, and operations remain pending.

## Cross-Service Requirements

The [Resource Security Baseline](../security/resource-security-baseline.md#mandatory-requirements) requires purge protection for Azure Key Vault, soft delete for Azure Storage Accounts, and disabled local accounts on AKS clusters. Detailed service configuration and compliance remain unverified.
