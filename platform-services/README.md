# Platform Services

Document shared platform services, including their confirmed implementation, ownership, dependencies, and operations.

## Documented Services

[Application Ingress](application-ingress.md) records the confirmed traffic path: Fastly fronts our application environments and forwards traffic to Azure Application Gateway, which fronts the applications. Exposure, DNS, TLS termination, WAF behavior, environment mappings, ownership, and operations remain to be documented.

[Azure Kubernetes Service (AKS)](aks.md) records Application Gateway Ingress Controller (AGIC) as the confirmed ingress controller, requires local accounts to be disabled, and requires Azure RBAC for Kubernetes Authorization to be enabled on every AKS cluster. Current compliance, cluster architecture, Application Gateway topology, configuration, ownership, and operations remain to be documented.

[Monitoring and Observability](../monitoring-and-observability/README.md) records Dynatrace as the standard monitoring platform, with Azure-native monitoring solutions used as needed or where appropriate. Detailed architecture, integrations, service inventory, ownership, and operations remain to be documented.

## Documented Resource Requirements

The [resource-specific Resource Security Baseline requirements](../security/resource-security-baseline.md#resource-specific-requirements) require purge protection for every Azure Key Vault, soft delete for every Azure Storage Account, disabled local accounts on every AKS cluster, and enabled Azure RBAC for Kubernetes Authorization on every AKS cluster. Service-specific settings, retention periods, recovery procedures, AKS access configuration, enforcement, ownership, and compliance remain to be documented.

## Documented Shared Management

[Private DNS Zone Management](../networking/private-dns-zone-management.md) records that the **Cloud Platform Solutions and Services** team centrally manages all private DNS zones. Team contacts, ownership boundaries, and consumer request procedures remain pending.

## Planned Pages

- Detailed AKS architecture, operations, and recovery guidance
- API Management
- Key Vault and Storage implementation guidance
- Detailed Dynatrace and Azure-native monitoring integrations
- Other shared platform services

Use the [service template](../templates/service.md) to document ownership, dependencies, access, deployment, operations, and recovery. List only confirmed services as available to consumers.

## Related Sections

- [Azure Services](../azure-services/README.md)
- [Using Azure](../using-azure/README.md)
- [Operations](../operations/README.md)

[Home](../Home.md)
