# ExpressRoute Connectivity

**Status:** User-confirmed connectivity. Detailed configuration and operational validation are pending.

**Source:** Platform description supplied by the user on 2026-08-31.

**Owner:** Not yet supplied.

## Confirmed Use

We use Azure ExpressRoute for access to our on-premises environment.

This confirms ExpressRoute is in use. It does not establish that it is the only connectivity path, which sites or destinations are reachable, or which application flows are permitted.

## Service Context

ExpressRoute provides private connectivity between on-premises networks and Microsoft's cloud. See [Microsoft's ExpressRoute overview](https://learn.microsoft.com/en-us/azure/expressroute/expressroute-introduction).

The service overview is reference context, not a description of our specific circuits, provider, gateway deployment, or availability design.

## Relationship to the Platform

The [Hub-and-Spoke Network](../architecture/hub-and-spoke-network.md) remains the documented network model: the hub provides transit for all spokes, and all workload VNet traffic is routed through and inspected by the Palo Alto firewall.

For the firewall and rule-management responsibility, see [Firewall Management](../architecture/hub-and-spoke-network.md#firewall-management). The ExpressRoute service owner remains unconfirmed.

The detailed path connecting workload VNets, the hub, Palo Alto, ExpressRoute, and on-premises destinations still needs to be documented. No gateway placement or hop sequence is inferred here.

See the [Zero Trust Policy](../security/zero-trust-policy.md) and [Resource Security Baseline](../security/resource-security-baseline.md) for the recorded security policy and requirements. Connectivity alone is not an access approval or evidence that security requirements are met.

## Implementation Details to Confirm

| Area | Information needed |
| --- | --- |
| Circuit inventory | Circuit count, resource locations, provider or connectivity model, peering locations, bandwidth, and SKU |
| Connection architecture | Azure connection and gateway resources, attachment to the hub-and-spoke topology, and on-premises sites and network devices |
| Routing and access | Peering configuration, advertised and accepted prefixes, route controls, allowed flows, and forward and return paths through Palo Alto |
| Transport protection | Encryption configuration and evidence of the protection provided for applicable traffic |
| Name resolution | DNS resolution paths and forwarding configuration; [private DNS zones are centrally managed](private-dns-zone-management.md) |
| Availability and recovery | Redundancy, any backup connectivity, failover behavior, and recovery validation |
| Operations | Named owners, monitoring, change requests, troubleshooting, and escalation procedures |

These details must come from platform records or owner confirmation. This page does not provide deployment commands or an executable runbook, and no Azure or on-premises configuration has been changed.

## Related Documentation

- [Networking](README.md)
- [Using Azure](../using-azure/README.md)
- [Networking FAQ](../faq/README.md#networking)
- [Troubleshooting](../troubleshooting/README.md)

[Home](../Home.md)
