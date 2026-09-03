# Networking

Document the platform's connectivity, routing, DNS, and network security implementation.

## Documented Architecture

Start with the [Hub-and-Spoke Network](../architecture/hub-and-spoke-network.md) baseline. Our ExpressRoute connections use AT&T NetBond and connect to a virtual hub (vHub) in Azure Virtual WAN. The vHub has a VNet connection to the hub virtual network (hub VNet), which contains the Palo Alto firewall and is VNet peered to all spokes. All workload VNet traffic is routed through and inspected by the firewall.

[ExpressRoute Connectivity](expressroute-connectivity.md) documents our use of AT&T NetBond for ExpressRoute access to the on-premises environment and its relationship to the Virtual WAN vHub and hub VNet. NetBond service configuration, circuit, gateway, peering, routing, and availability details remain unconfirmed.

The **Virtual WAN vHub** and **hub VNet** are separate components: the vHub is the confirmed ExpressRoute connection point, while the hub VNet contains the firewall and peers with the spokes.

[Application Ingress](../platform-services/application-ingress.md) documents the confirmed application traffic sequence from Fastly to Azure Application Gateway to the applications. The exposure model, DNS, TLS termination, detailed routing, and interaction with the Palo Alto inspection path remain unconfirmed.

## Private Service Access

[Private Endpoints](private-endpoints.md) records the mandatory public-access default and the recommendation to use Private Endpoints where supported and applicable. Service coverage, endpoint inventory, request procedures, routing, and compliance remain unverified.

## Documented Management Model

The **Cyber Defense Engineering** team manages the Palo Alto firewall and its rules. See [Firewall Management](../architecture/hub-and-spoke-network.md#firewall-management) for the confirmed responsibility and remaining procedural details.

The **Cloud Platform Solutions and Services** team centrally manages all private DNS zones. See [Private DNS Zone Management](private-dns-zone-management.md). Zone inventory, contacts, access procedures, ownership boundaries, and resolution paths remain to be documented.

## Implementation Details to Document

- Virtual WAN, vHub, hub VNet, spoke VNet, connection, and peering inventory
- Palo Alto deployment, inspection policies, availability, and failover
- AT&T NetBond service configuration, ExpressRoute circuit mapping, support ownership, and escalation
- ExpressRoute circuits, gateways, peerings, and resilience
- VNet and vHub route tables, route propagation, BGP configuration, next-hop values, and subnet coverage
- Onward destination paths, return routing, and address translation
- IP addressing and network security controls
- Private connectivity and DNS resolution paths
- Fastly-to-Application-Gateway connectivity, exposure, routing, and return paths

Address ranges, resource names, DNS configuration, firewall rules, routing implementation, and operational status must come from verified platform records. The documented topology does not by itself confirm those implementation details.

## Related Sections

- [Architecture](../architecture/README.md)
- [Private Endpoints](private-endpoints.md)
- [Zero Trust Policy](../security/zero-trust-policy.md)
- [Resource Security Baseline](../security/resource-security-baseline.md)
- [Design Patterns](../design-patterns/README.md)
- [Using Azure](../using-azure/README.md)
- [Troubleshooting](../troubleshooting/README.md)

[Home](../Home.md)
