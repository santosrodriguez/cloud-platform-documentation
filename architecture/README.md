# Architecture

Authoritative architecture documentation for the Azure platform.

## Documented Architecture

- [Hub-and-Spoke Network](hub-and-spoke-network.md): ExpressRoute connectivity through AT&T NetBond to a Virtual WAN vHub, the vHub's VNet connection to the hub VNet, VNet peering from the hub VNet to all spokes, and routing and inspection of all workload VNet traffic through Palo Alto in the hub VNet.
- [Environment Isolation](environment-isolation.md): the platform has DEV, INT, CRT, and PRD environments, and the environments are not cross-connected.
- [Application Ingress](../platform-services/application-ingress.md): Fastly fronts application environments and forwards traffic to Azure Application Gateway, which fronts the applications.

This baseline is based on the supplied platform description. Detailed configuration and operational validation remain pending.

## Intended Content

- Enterprise and landing zone architecture
- Management group and subscription architecture
- Regional architecture
- Network architecture
- Identity architecture
- Security architecture
- Shared services architecture
- Application connectivity
- Architecture diagrams
