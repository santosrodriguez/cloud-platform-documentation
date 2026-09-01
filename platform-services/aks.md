# Azure Kubernetes Service (AKS)

**Status:** User-confirmed ingress implementation and local-account security requirement. Cluster architecture, configuration, ownership, and operations remain to be documented.

**Source:** AKS requirements supplied by the user on 2026-08-31 and 2026-09-01.

**Service owner:** Not yet supplied.

## Confirmed Ingress Implementation

We use **Application Gateway Ingress Controller (AGIC)** for ingress to our AKS clusters.

| Capability | Confirmed implementation |
| --- | --- |
| Container platform | Azure Kubernetes Service (AKS) clusters |
| Ingress controller | Application Gateway Ingress Controller (AGIC) |

This confirms the ingress controller technology in use. It does not establish the AKS or Application Gateway inventory, controller deployment mode, topology, configuration, or operating model. It also does not establish whether every cluster is configured identically or whether other ingress controllers or ingress paths are in use.

## Mandatory Local-Account Requirement

Local accounts **MUST** be disabled on every AKS cluster.

This is a mandatory configuration requirement, not a claim that existing clusters currently comply. The replacement authentication and authorization model, implementation method, administrative access path, break-glass access, enforcement, exception process, and validation evidence remain to be documented.

## Security and Network Requirements

AKS and Application Gateway resources are subject to the [Resource Security Baseline](../security/resource-security-baseline.md): public access must be disabled by default, and TLS 1.2 or later is required for applicable TLS endpoints.

This page does not confirm whether any Application Gateway frontend is public. A resource that requires public access must follow the [Public Access Exemption Process](../security/public-access-exemption-process.md). That process applies only to public access and does not authorize AKS local accounts to be enabled.

TLS termination points, certificate sources, frontend and backend protocols, WAF configuration, network flows, DNS dependencies, and the interaction with the [Hub-and-Spoke Network](../architecture/hub-and-spoke-network.md) remain to be documented.

## Implementation Details to Document

| Area | Details still needed |
| --- | --- |
| AKS architecture | Cluster inventory, subscriptions, regions, versions, node pools, availability, API access, and network model |
| AGIC deployment | Add-on or Helm deployment, versions, release process, watched namespaces, ingress classes, and update strategy |
| Application Gateway topology | Gateway inventory, shared or dedicated model, SKU, WAF mode, frontend addresses, listeners, backend pools, and probes |
| Ingress configuration | Host and path routing, annotations, backend protocols, health checks, redirects, and supported application patterns |
| Identity and access | Configured local-account state, supported authentication and authorization model, controller identity, Azure and Kubernetes permissions, administrative access, credential handling, and break-glass access |
| TLS and certificates | Termination points, certificate source and renewal, supported protocols and cipher configuration, and validation evidence |
| Networking and DNS | Subnets, routes, security controls, private or public exposure, name resolution, and firewall dependencies |
| Security validation | Evidence that local accounts are disabled on every cluster and that the applicable public-access and TLS requirements are met |
| Operations | Monitoring, logging, alerting, upgrades, troubleshooting, backup, recovery, and failure handling |
| Ownership | Owners and support contacts for AKS, Application Gateway, AGIC, application ingress configuration, and incident escalation |

The entries above identify information to collect. They do not describe configuration or procedures already in place, and this page does not change any AKS, Application Gateway, identity, access, or ingress configuration.

## Related Documentation

- [Platform Services](README.md)
- [Azure Services](../azure-services/README.md)
- [Networking](../networking/README.md)
- [Resource Security Baseline](../security/resource-security-baseline.md)
- [Public Access Exemption Process](../security/public-access-exemption-process.md)
- [Using Azure](../using-azure/README.md)
- [AKS FAQ](../faq/README.md#aks)

[Home](../Home.md)
