# Change Log

Record meaningful changes to this documentation. Link entries to their pull request or decision record.

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
