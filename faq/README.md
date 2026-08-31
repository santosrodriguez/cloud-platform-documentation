# Azure Platform FAQ

This section captures commonly asked questions from teams that consume or depend on the Azure platform.

FAQ answers should be concise and link to authoritative documentation rather than duplicating entire technical pages.

## Networking

### What does the hub network do?

The hub is the transit network for all spokes in our hub-and-spoke architecture. See [Hub-and-Spoke Network](../architecture/hub-and-spoke-network.md).

### How is workload VNet traffic routed and inspected?

All workload VNet traffic is routed through and inspected by the Palo Alto firewall. Detailed routing and inspection configuration still need to be documented.

See [Workload VNet Traffic Routing and Inspection](../architecture/hub-and-spoke-network.md#workload-vnet-traffic-routing-and-inspection).

### Who manages the Palo Alto firewall and its rules?

The **Cyber Defense Engineering** team manages the Palo Alto firewall and its rules. See [Firewall Management](../architecture/hub-and-spoke-network.md#firewall-management). Contact details and request procedures remain to be documented.

### How do we access the on-premises environment?

We use Azure ExpressRoute for on-premises access. Specific destinations, allowed flows, and routing configuration still need to be documented. See [ExpressRoute Connectivity](../networking/expressroute-connectivity.md).

## DNS

### How are private DNS zones managed?

All private DNS zones are centrally managed. The named owning team, zone locations, DNS resolution paths, and change request procedures have not yet been documented. See [Private DNS Zone Management](../networking/private-dns-zone-management.md).

## Security

### What security policy does the platform follow?

The platform follows a Zero Trust policy. Detailed control requirements, enforcement, and compliance remain unverified. See [Zero Trust Policy](../security/zero-trust-policy.md).

### Should public access be enabled by default?

No. Public access must be disabled by default for all resources. See the [Resource Security Baseline](../security/resource-security-baseline.md#mandatory-requirements).

### What is the minimum TLS version?

TLS 1.2 is the required minimum. Later versions meet this minimum; earlier versions must not be permitted. See the [Resource Security Baseline](../security/resource-security-baseline.md#mandatory-requirements).

## GitHub and Azure DevOps

### Who is responsible for the GitHub and Azure DevOps environments?

The **DevOps Engineering Team** is responsible for both environments. See [Environment Responsibilities](../ci-cd/README.md#environment-responsibilities). Contact details and access, approval, and support procedures remain to be documented.

## Categories

- Getting started
- Networking
- DNS
- Identity and access
- Security
- Private Endpoints
- Terraform
- GitHub Actions
- Azure DevOps
- AKS
- API Management
- Monitoring
- Disaster recovery

When the same question is asked repeatedly, treat it as a signal that this FAQ or the underlying documentation should be improved.
