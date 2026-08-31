# Monitoring and Observability

**Status:** User-confirmed platform standard. Selection criteria, implementation, coverage, and operations remain to be documented.

**Source:** Monitoring platform approach supplied by the user on 2026-08-31.

**Owner:** Not yet supplied.

## Confirmed Platform Approach

**Dynatrace is our standard monitoring platform.** Azure-native monitoring solutions are also used as needed or where they are appropriate.

| Role | Confirmed approach |
| --- | --- |
| Standard monitoring platform | Dynatrace |
| Complementary monitoring | Azure-native monitoring solutions, used as needed or where appropriate |

This identifies Dynatrace as the standard; it does not establish an exclusive single-tool requirement. It also does not confirm that every resource or workload is currently monitored by Dynatrace, identify which Azure-native monitoring services are deployed, or define when each option is selected.

## Implementation and Selection Details to Document

| Area | Details still needed |
| --- | --- |
| Monitoring scope | Resource, platform, workload, environment, and subscription coverage; onboarding status; and known gaps |
| Dynatrace architecture | Environment inventory, deployment components, agents or collectors, network paths, authentication, integrations, and availability design |
| Azure-native solutions | Services in use, workspace and resource inventory, data collection configuration, diagnostic settings, and service-specific purpose |
| Selection criteria | When Dynatrace is the default, when Azure-native capabilities are appropriate, how overlap is handled, and who makes the decision |
| Telemetry | Metrics, logs, traces, events, topology, collection sources, routing, normalization, and correlation |
| Dashboards and alerts | Dashboard standards, alert rules and thresholds, notification routing, ownership, suppression, and escalation |
| Data management | Retention, access, data residency, sensitive-data handling, archival, and cost controls |
| Operations | Platform ownership, support contacts, health monitoring, upgrades, incident response, troubleshooting, and recovery |
| Validation | Coverage checks, data-quality checks, alert testing, operational evidence, and periodic review |

The entries above identify information to collect. They do not describe deployed configuration, approved selection rules, or operating procedures.

## Planned Pages

- Dynatrace architecture, onboarding, and operations
- Confirmed Azure-native monitoring services and usage patterns
- Monitoring architecture and telemetry flows
- Dashboards
- Alerts, routing, and escalation
- Logging standards and retention

Service inventory, workspace locations, platform endpoints, alert thresholds, retention periods, integrations, and response ownership require verified environment information.

## Related Sections

- [Operations](../operations/README.md)
- [Platform Services](../platform-services/README.md)
- [Standards and Guidelines](../standards-and-guidelines/README.md)
- [Using Azure](../using-azure/README.md)
- [Troubleshooting](../troubleshooting/README.md)

[Home](../Home.md)
