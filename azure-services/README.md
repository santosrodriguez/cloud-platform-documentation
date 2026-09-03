# Azure Services

Documentation for Azure services managed, governed, or commonly consumed through the Cloud Platform.

Each service page should explain purpose, architecture, dependencies, networking, identity, security, deployment, monitoring, operations, disaster recovery, troubleshooting, and known limitations where applicable.

## Documented Services

- [Application Ingress](../platform-services/application-ingress.md): Fastly fronts our application environments and forwards traffic to Azure Application Gateway, which fronts the applications; detailed configuration, ownership, and operations remain pending.
- [Azure Kubernetes Service (AKS)](../platform-services/aks.md): separate system and user node pools and Application Gateway Ingress Controller are confirmed; local accounts must be disabled and Azure RBAC for Kubernetes Authorization must be enabled; current compliance and remaining implementation details are pending.
- [Azure API Management](../platform-services/api-management.md): APIM is used for APIs; inventory, supported consumption, architecture, ownership, and operations remain pending.
- [Azure Monitor Private Link Scope](../monitoring-and-observability/azure-monitor-private-link-scope.md): AMPLS is used for private access to Azure Monitor resources; scope, topology, and access modes remain pending.

## Cross-Service Requirements

The [general Resource Security Baseline requirements](../security/resource-security-baseline.md#general-requirements) require public access to be disabled by default and TLS 1.2 or later for applicable connections. [Private Endpoints](../networking/private-endpoints.md) should be used where supported and applicable.

The [resource-specific Resource Security Baseline requirements](../security/resource-security-baseline.md#resource-specific-requirements) require purge protection for Azure Key Vault, soft delete and disabled container public access for Azure Storage Accounts, disabled local accounts on AKS clusters, and enabled Azure RBAC for Kubernetes Authorization on AKS clusters. Detailed service configuration and compliance remain unverified.
