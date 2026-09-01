# Azure Services

Documentation for Azure services managed, governed, or commonly consumed through the Cloud Platform.

Each service page should explain purpose, architecture, dependencies, networking, identity, security, deployment, monitoring, operations, disaster recovery, troubleshooting, and known limitations where applicable.

## Documented Services

- [Azure Kubernetes Service (AKS)](../platform-services/aks.md): Application Gateway Ingress Controller is the confirmed ingress controller used for our AKS clusters; detailed architecture and operations remain pending.

## Cross-Service Requirements

The [Resource Security Baseline](../security/resource-security-baseline.md#mandatory-requirements) requires purge protection for Azure Key Vault and soft delete for Azure Storage Accounts. Detailed service configuration and compliance remain unverified.
