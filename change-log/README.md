# Change Log

Record meaningful changes to this documentation. Link entries to their pull request or decision record.

## 2026-09-03: Platform Operations, Troubleshooting, and Runbooks

[PR #30](https://github.com/santosrodriguez/cloud-platform-documentation/pull/30) documents [DEV, INT, CRT, and PRD environment isolation](../architecture/environment-isolation.md), the [Private Endpoint](../networking/private-endpoints.md) recommendation, [Azure Monitor Private Link Scope](../monitoring-and-observability/azure-monitor-private-link-scope.md), [Azure API Management](../platform-services/api-management.md), AKS system and user node-pool separation, and the Cloud Platform team's reusable Terraform module publishing responsibility. It also records the mandatory [ServiceNow and Change Board approval](../governance/production-change-management.md) for production-impacting changes and adds read-only troubleshooting guides and draft runbooks for private connectivity, AKS, Terraform, APIM, and production change preparation. Inventory, detailed implementation, request paths, ownership, support, enforcement, and current compliance remain unverified; no Azure, network, firewall, DNS, APIM, AKS, Terraform, ServiceNow, monitoring, or production configuration is changed.

## 2026-09-03: Storage Account Container Public Access

[PR #29](https://github.com/santosrodriguez/cloud-platform-documentation/pull/29) adds a mandatory [Storage Account container-public-access requirement](../security/resource-security-baseline.md#storage-container-public-access): container public access must be disabled on every Azure Storage Account, and blob containers must not permit anonymous public access. The baseline distinguishes this control from public network access and routes requests to enable it through the existing public-access exemption process. Current compliance, enforcement, exact settings, validation evidence, approval criteria, and whether such requests can be approved remain unverified; no Storage Account, Azure Policy, public-access, network, or Azure configuration is changed.

## 2026-09-03: AKS Azure RBAC Requirement

[PR #28](https://github.com/santosrodriguez/cloud-platform-documentation/pull/28) adds a mandatory [AKS Azure RBAC requirement](../platform-services/aks.md#mandatory-azure-rbac-requirement): Azure RBAC for Kubernetes Authorization must be enabled on every AKS cluster. The existing requirement to disable local accounts remains mandatory, and the Resource Security Baseline diagram and customer summaries now show both cumulative AKS access controls. Current compliance, Microsoft Entra integration, Azure role definitions, assignments and scopes, privileged-access workflow, any remaining Kubernetes RBAC usage, enforcement, exceptions, and validation evidence remain unverified; no AKS, identity, authorization, role-assignment, or Azure configuration is changed.

## 2026-09-03: Fastly and Application Gateway Ingress

[PR #27](https://github.com/santosrodriguez/cloud-platform-documentation/pull/27) adds the published [Application Ingress](../platform-services/application-ingress.md) architecture: Fastly fronts application environments and forwards traffic to Azure Application Gateway, which fronts the applications. It adds a focused Mermaid flow, updates the AKS ingress view without claiming every Fastly route targets AKS, and exposes the new page through customer navigation and the FAQ. Public or private exposure, DNS, TLS termination, WAF behavior, application mappings, ownership, support, and detailed network routing remain unverified; no Fastly, Application Gateway, AKS, Azure, network, security, DNS, or application configuration is changed.

## 2026-09-03: AT&T NetBond ExpressRoute Provider

[PR #26](https://github.com/santosrodriguez/cloud-platform-documentation/pull/26) records AT&T NetBond as the confirmed connectivity provider for our [ExpressRoute connections](../networking/expressroute-connectivity.md). The hub-and-spoke and ExpressRoute Mermaid diagrams show NetBond as a provider relationship rather than a packet hop, and the architecture, networking, FAQ, and source-only Azure Wiki assistant deployment summaries now use consistent wording. NetBond service configuration, ExpressRoute circuit mapping, contractual and support responsibilities, escalation, and resiliency remain unverified; no NetBond, Azure, network, firewall, or deployment configuration is changed.

## 2026-09-03: Virtual WAN and Hub VNet Topology

[PR #25](https://github.com/santosrodriguez/cloud-platform-documentation/pull/25) records the confirmed [Hub-and-Spoke Network](../architecture/hub-and-spoke-network.md): ExpressRoute connects to a virtual hub in Azure Virtual WAN; that vHub has a VNet connection to the hub VNet; the hub VNet contains the Palo Alto firewall and is VNet peered to all spokes; and all workload VNet traffic is routed through and inspected by Palo Alto. The architecture, ExpressRoute, networking, FAQ, and source-only Azure Wiki assistant deployment pages now use the same terminology and revised Mermaid diagrams. Circuit and gateway inventory, BGP, route tables, route propagation, addresses, resiliency, and complete forward and return paths remain unverified; no Azure, network, firewall, or deployment configuration is changed.

## 2026-09-03: Focused Mermaid Diagrams

[PR #24](https://github.com/santosrodriguez/cloud-platform-documentation/pull/24) adds seven published Mermaid diagrams covering ExpressRoute connectivity, Private DNS management, Azure user access, resource security requirements, AKS ingress, the Terraform platform, and the Terraform review workflow. It also adds two source-only diagrams to the Azure Wiki assistant deployment guide and reflows the existing workload-inspection and public-access exemption diagrams for normal Wiki width. Solid lines identify documented relationships and dashed lines identify pending implementation details; no Azure, network, firewall, DNS, identity, workflow, or security configuration is changed.

## 2026-09-03: Command Cheat Sheets

[PR #23](https://github.com/santosrodriguez/cloud-platform-documentation/pull/23) adds a published [Command Cheat Sheets](../command-cheat-sheets/README.md) section with separate Terraform, Bash, Azure CLI, and PowerShell references. The pages distinguish read-only, local, Azure, and Terraform state-changing actions; reinforce the documented admin-account, MFA, private-access, and no-secret requirements; and direct infrastructure changes to reviewed Terraform and GitHub Actions workflows unless an approved runbook authorizes another method. The examples are general references and do not establish organization-specific procedures, grant access, run commands, or change Azure resources.

## 2026-09-01: Wiki Right Sidebar Navigation

[PR #19](https://github.com/santosrodriguez/cloud-platform-documentation/pull/19) organizes the native right-side Wiki contents panel into Start Here, Architecture and Networking, Security and Governance, Engineering and Services, Operations and Reliability, and Reference and Maintenance. All 33 existing sidebar destinations are preserved; no documentation requirement, architecture statement, or Azure configuration is changed.

## 2026-09-01: Resource Security Requirement Scope

[PR #18](https://github.com/santosrodriguez/cloud-platform-documentation/pull/18) separates the Resource Security Baseline into [General Requirements](../security/resource-security-baseline.md#general-requirements) for public access and TLS and [Resource-Specific Requirements](../security/resource-security-baseline.md#resource-specific-requirements) for Azure Key Vault, Azure Storage Accounts, and AKS clusters. Resource-specific controls are explicitly additional to applicable general controls; no requirement or Azure configuration is added, removed, or changed.

## 2026-09-01: Azure Administrative Accounts and MFA

[PR #17](https://github.com/santosrodriguez/cloud-platform-documentation/pull/17) adds mandatory [Azure Identity and Access Requirements](../security/identity-and-access-requirements.md#mandatory-requirements): MFA must be used for Azure user access, elevated permissions must be exercised through designated administrative accounts, and regular user accounts must not be used for elevated permissions. Definitions, account lifecycle, MFA methods, enforcement, emergency access, exceptions, ownership, workload identities, and compliance remain undocumented; no Azure account, role assignment, MFA setting, identity policy, or privileged-access configuration is changed.

## 2026-09-01: AKS Local Accounts

[PR #16](https://github.com/santosrodriguez/cloud-platform-documentation/pull/16) adds a mandatory [AKS local-account requirement](../platform-services/aks.md#mandatory-local-account-requirement): local accounts must be disabled on every AKS cluster. Current compliance, enforcement, replacement authentication and authorization, administrative and break-glass access, exceptions, and validation remain undocumented; no AKS cluster, identity, access, policy, or authentication configuration is changed.

## 2026-09-01: Key Vault and Storage Deletion Protection

[PR #15](https://github.com/santosrodriguez/cloud-platform-documentation/pull/15) adds mandatory [resource-specific Resource Security Baseline](../security/resource-security-baseline.md#resource-specific-requirements) controls: purge protection enabled for every Azure Key Vault and soft delete enabled for every Azure Storage Account. Storage service and data-type scope, retention, recovery, enforcement, ownership, and compliance remain undocumented; no Key Vault, Storage Account, policy, retention, recovery, or access configuration is changed.

## 2026-08-31: Private DNS Management Ownership

[PR #14](https://github.com/santosrodriguez/cloud-platform-documentation/pull/14) identifies the **Cloud Platform Solutions and Services** team as the central manager of [all private DNS zones](../networking/private-dns-zone-management.md#confirmed-management-model). Team contacts, ownership boundaries, request and approval procedures, zone inventory, resolution architecture, and operations remain undocumented; no DNS resource, zone, record, link, access, or resolution configuration is changed.

## 2026-08-31: Monitoring Platform Standard

[PR #13](https://github.com/santosrodriguez/cloud-platform-documentation/pull/13) records [Dynatrace as the standard monitoring platform](../monitoring-and-observability/README.md#confirmed-platform-approach), with Azure-native monitoring solutions used as needed or where appropriate. Coverage, Azure-native service inventory, selection criteria, telemetry routing, integrations, alert ownership, retention, and operations remain undocumented; no monitoring, alerting, telemetry, Azure, or Dynatrace configuration is changed.

## 2026-08-31: AKS Ingress Controller

[PR #12](https://github.com/santosrodriguez/cloud-platform-documentation/pull/12) records [Application Gateway Ingress Controller (AGIC)](../platform-services/aks.md#confirmed-ingress-implementation) as the ingress controller used for our AKS clusters. The AKS service page applies the existing public-access and TLS requirements while leaving controller deployment mode, Application Gateway topology, ingress configuration, ownership, and operations unconfirmed; no AKS, Application Gateway, ingress, network, or security configuration is changed.

## 2026-08-31: Public Access Exemption Process

[PR #11](https://github.com/santosrodriguez/cloud-platform-documentation/pull/11) records the [Public Access Exemption Process](../security/public-access-exemption-process.md): the requester submits a resource-specific exemption request, the Cyber Defense team in Security reviews it, and, after approval, Cyber Defense sends it to the Cloud Platform team to create the Azure Policy exemption for that resource. Request mechanics, approval criteria, validation, lifecycle, and other decision paths remain undocumented; no exemption or Azure configuration is created or changed.

## 2026-08-31: Terraform Platform Implementation

[PR #10](https://github.com/santosrodriguez/cloud-platform-documentation/pull/10) records the confirmed [Terraform Platform](../infrastructure-as-code/terraform-platform.md): Artifactory is the Terraform registry, Azure Storage Accounts store Terraform state files, and GitHub Actions runs workflows. Detailed configuration, identities, component ownership, and operating procedures remain undocumented; no infrastructure, workflow, access, or repository settings are changed.

## 2026-08-31: DevOps Environment Responsibilities

[PR #9](https://github.com/santosrodriguez/cloud-platform-documentation/pull/9) records the **DevOps Engineering Team** as responsible for the [GitHub and Azure DevOps environments](../ci-cd/README.md#environment-responsibilities). The service-responsibility reference, FAQ, and consumer guidance reflect this scope. Detailed administrative boundaries, access and approval procedures, and support contacts remain undocumented; no access grants or environment settings are changed.

## 2026-08-31: Firewall Management Responsibility

[PR #8](https://github.com/santosrodriguez/cloud-platform-documentation/pull/8) records the **Cyber Defense Engineering** team's responsibility for [managing the Palo Alto firewall and its rules](../architecture/hub-and-spoke-network.md#firewall-management). Related guidance, the FAQ, and the service-responsibility reference link to this confirmed scope. Contacts and request, approval, and escalation procedures remain undocumented; no access grants or infrastructure settings are changed.

## 2026-08-31: Zero Trust and ExpressRoute

[PR #7](https://github.com/santosrodriguez/cloud-platform-documentation/pull/7) records the user-confirmed [Zero Trust Policy](../security/zero-trust-policy.md) and [ExpressRoute Connectivity](../networking/expressroute-connectivity.md) for on-premises access, with FAQs and related navigation. Reference definitions are distinguished from organization-specific facts. Detailed controls and connectivity configuration remain unconfirmed; no Azure, firewall, or on-premises settings are changed.

## 2026-08-31: Workload VNet Traffic Clarification

[PR #6](https://github.com/santosrodriguez/cloud-platform-documentation/pull/6) clarifies the [Hub-and-Spoke Network](../architecture/hub-and-spoke-network.md): all workload VNet traffic is routed through and inspected by the Palo Alto firewall. The network page, diagram, FAQ, and related summaries use the clarified wording. Detailed routing and inspection configuration remain unconfirmed; no Azure or firewall settings are changed.

## 2026-08-31: Centralized Private DNS Zone Management

[PR #5](https://github.com/santosrodriguez/cloud-platform-documentation/pull/5) records the user-confirmed [Private DNS Zone Management](../networking/private-dns-zone-management.md) model: all private DNS zones are centrally managed. DNS FAQs and related navigation link to the page. Zone locations, resolution paths, and operational procedures remain unconfirmed; no Azure DNS configuration is changed.

## 2026-08-31: Resource Security Baseline

[PR #4](https://github.com/santosrodriguez/cloud-platform-documentation/pull/4) records the user-confirmed [Resource Security Baseline](../security/resource-security-baseline.md): public access disabled by default for all resources and TLS 1.2 as the required minimum. Security FAQs and navigation link to the standard. Enforcement and compliance have not been verified; no Azure configuration is changed.

## 2026-08-31: Network Architecture Baseline

[PR #3](https://github.com/santosrodriguez/cloud-platform-documentation/pull/3) records the user-provided [Hub-and-Spoke Network](../architecture/hub-and-spoke-network.md) baseline, with logical diagrams, network FAQs, and navigation links. Detailed routing and firewall deployment information remain pending confirmation.

## Initial Setup

[PR #1](https://github.com/santosrodriguez/cloud-platform-documentation/pull/1) contains the initial section structure, consumer guidance and FAQ indexes, templates, navigation, and local Wiki build tooling.

These are documentation scaffolding changes. They do not indicate changes to the deployed Azure platform.

[Home](../Home.md)
