# Change Log

Record meaningful changes to this documentation. Link entries to their pull request or decision record.

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
