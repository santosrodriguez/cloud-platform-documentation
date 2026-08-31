# Private DNS Zone Management

**Status:** User-confirmed management model. Detailed implementation and operational validation are pending.

**Source:** Platform description supplied by the user on 2026-08-31.

**Owner:** Central management is confirmed; the named owning team and contact have not yet been supplied.

## Confirmed Management Model

All private DNS zones in our Azure platform are centrally managed.

Central management describes responsibility for the zones. It does not establish their subscription or resource group locations, virtual network links, or the DNS resolution paths used by clients. The management model for public DNS zones has not been supplied.

## Guidance for Consuming Teams

Use centrally managed private DNS zones as the documented management model when describing workload DNS integration. The processes for requesting zones, records, or network links, and any permissions delegated to consuming teams, remain to be documented.

## Details to Confirm

| Area | Information needed |
| --- | --- |
| Ownership | Named owning team, contacts, and operational responsibilities |
| Zone inventory | Zone names, subscriptions, resource groups, and supported uses |
| Access and changes | Access controls, any delegated permissions, and request and approval procedures |
| Records and integrations | Record lifecycle, registration settings, and any private endpoint DNS integration or automation in use |
| Name resolution | Virtual network links, DNS server settings, forwarding, any resolvers in use, and workload or hybrid resolution paths where applicable |
| Operations | Deployment tooling, validation evidence, monitoring, troubleshooting, and recovery procedures |

These are information gaps, not descriptions of deployed components or established procedures. Central zone management alone does not verify name resolution for a workload.

No Azure DNS configuration has been changed by recording this management model.

## Related Documentation

- [Networking](README.md)
- [Hub-and-Spoke Network](../architecture/hub-and-spoke-network.md)
- [Platform Services](../platform-services/README.md)
- [Using Azure](../using-azure/README.md)
- [DNS FAQ](../faq/README.md#dns)

[Home](../Home.md)
