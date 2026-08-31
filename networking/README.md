# Networking

Document the platform's connectivity, routing, DNS, and network security implementation.

## Documented Architecture

Start with the [Hub-and-Spoke Network](../architecture/hub-and-spoke-network.md) baseline. The hub provides transit for all spokes. All workload VNet traffic is routed through and inspected by the Palo Alto firewall.

[ExpressRoute Connectivity](expressroute-connectivity.md) documents our use of ExpressRoute for access to the on-premises environment. Circuit details, connection architecture, routing, and availability remain unconfirmed.

## Documented Management Model

The **Cyber Defense Engineering** team manages the Palo Alto firewall and its rules. See [Firewall Management](../architecture/hub-and-spoke-network.md#firewall-management) for the confirmed responsibility and remaining procedural details.

[Private DNS Zone Management](private-dns-zone-management.md) records central management of all private DNS zones. Zone inventory, access procedures, and resolution paths remain to be documented.

## Implementation Details to Document

- Hub and spoke inventory and connection mechanism
- Palo Alto deployment, inspection policies, availability, and failover
- ExpressRoute circuits, connection architecture, routing, and resilience
- Routing configuration, next-hop values, and subnet coverage
- Onward destination paths, return routing, and address translation
- IP addressing and network security controls
- Private connectivity and DNS resolution paths

Address ranges, DNS configuration, firewall rules, and routing implementation must come from verified platform records. The hub implementation has not yet been identified as a hub VNet, Virtual WAN, or another arrangement.

## Related Sections

- [Architecture](../architecture/README.md)
- [Zero Trust Policy](../security/zero-trust-policy.md)
- [Resource Security Baseline](../security/resource-security-baseline.md)
- [Design Patterns](../design-patterns/README.md)
- [Using Azure](../using-azure/README.md)
- [Troubleshooting](../troubleshooting/README.md)

[Home](../Home.md)
