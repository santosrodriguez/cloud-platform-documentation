# Azure Platform FAQ

This section captures commonly asked questions from teams that consume or depend on the Azure platform.

FAQ answers should be concise and link to authoritative documentation rather than duplicating entire technical pages.

## Networking

### What does the hub network do?

The hub VNet is the transit network for all spokes. It contains the Palo Alto firewall and is VNet peered to every spoke. A separate Virtual WAN vHub connects to the hub VNet through a VNet connection. See [Hub-and-Spoke Network](../architecture/hub-and-spoke-network.md).

### How is workload VNet traffic routed and inspected?

All workload VNet traffic is routed through and inspected by the Palo Alto firewall. Detailed routing and inspection configuration still need to be documented.

See [Workload VNet Traffic Routing and Inspection](../architecture/hub-and-spoke-network.md#workload-vnet-traffic-routing-and-inspection).

### Who manages the Palo Alto firewall and its rules?

The **Cyber Defense Engineering** team manages the Palo Alto firewall and its rules. See [Firewall Management](../architecture/hub-and-spoke-network.md#firewall-management). Contact details and request procedures remain to be documented.

### How do we access the on-premises environment?

We use Azure ExpressRoute through AT&T NetBond for on-premises access. ExpressRoute connects to a vHub in our Virtual WAN, and the vHub has a VNet connection to the hub VNet. The hub VNet contains Palo Alto and is VNet peered to all spokes. NetBond service configuration, specific circuits, gateways, destinations, allowed flows, support procedures, and routing configuration still need to be documented. See [ExpressRoute Connectivity](../networking/expressroute-connectivity.md).

## Application Ingress

### What fronts our application environments?

Fastly fronts our application environments and forwards traffic to Azure Application Gateway. Application Gateway then fronts the applications. Public or private exposure, DNS, TLS termination, WAF behavior, environment mappings, ownership, and support procedures remain to be documented. See [Application Ingress](../platform-services/application-ingress.md).

## DNS

### How are private DNS zones managed?

The **Cloud Platform Solutions and Services** team centrally manages all private DNS zones. Team contacts, ownership boundaries, zone locations, DNS resolution paths, and change request procedures remain to be documented. See [Private DNS Zone Management](../networking/private-dns-zone-management.md).

## Security

### What security policy does the platform follow?

The platform follows a Zero Trust policy. Detailed control requirements, enforcement, and compliance remain unverified. See [Zero Trust Policy](../security/zero-trust-policy.md).

### Is MFA required for Azure access?

Yes. Multi-factor authentication (MFA) must be used for Azure user access. Approved MFA methods, authentication strength, covered access paths, session behavior, emergency access, enforcement, exceptions, and current compliance remain to be documented. See [Azure Identity and Access Requirements](../security/identity-and-access-requirements.md#mandatory-requirements).

### Which account must I use for elevated permissions in Azure?

Use your designated administrative account. A regular user account must not be used to exercise elevated permissions in Azure, and MFA is still required. The definition of elevated permissions, account provisioning and naming, privileged-access workflow, emergency access, exceptions, and current compliance remain to be documented. See [Azure Identity and Access Requirements](../security/identity-and-access-requirements.md#mandatory-requirements).

### Should public access be enabled by default?

No. Public access must be disabled by default for all resources. A specific resource may receive public access only through the [Public Access Exemption Process](../security/public-access-exemption-process.md). See the [general Resource Security Baseline requirements](../security/resource-security-baseline.md#general-requirements).

### How do I request public access for a resource?

Submit a public-access exemption request for the resource. The Cyber Defense team in Security reviews the request. If Cyber Defense approves it, Cyber Defense sends the approved request to the Cloud Platform team, which creates the Azure Policy exemption for that resource. The request channel, required information, review criteria, validation, and exemption lifecycle remain to be documented. See the [Public Access Exemption Process](../security/public-access-exemption-process.md).

### What is the minimum TLS version?

TLS 1.2 is the required minimum. Later versions meet this minimum; earlier versions must not be permitted. See the [general Resource Security Baseline requirements](../security/resource-security-baseline.md#general-requirements).

## Key Vault and Storage

### Is purge protection required for Azure Key Vault?

Yes. Purge protection must be enabled for every Azure Key Vault. Current compliance, retention configuration, validation, and recovery and purge procedures remain to be documented. See the [resource-specific Resource Security Baseline requirements](../security/resource-security-baseline.md#resource-specific-requirements).

### Is soft delete required for Azure Storage Accounts?

Yes. Soft delete must be enabled for every Azure Storage Account. The applicable storage services and data types, required settings, retention periods, recovery procedures, and current compliance remain to be documented. See the [resource-specific Resource Security Baseline requirements](../security/resource-security-baseline.md#resource-specific-requirements).

## AKS

### Which ingress controller do our AKS clusters use?

We use Application Gateway Ingress Controller (AGIC) for ingress to our AKS clusters. Controller deployment mode, Application Gateway topology, ingress configuration, ownership, and operations remain to be documented. See [Azure Kubernetes Service (AKS)](../platform-services/aks.md).

### Are local accounts permitted on AKS clusters?

No. Local accounts must be disabled on every AKS cluster. Current compliance, enforcement, the replacement authentication and authorization model, administrative and break-glass access, exceptions, and validation evidence remain to be documented. See the [AKS local-account requirement](../platform-services/aks.md#mandatory-local-account-requirement) and [resource-specific Resource Security Baseline requirements](../security/resource-security-baseline.md#resource-specific-requirements).

## Terraform

### What tools make up our Terraform platform?

We use Artifactory as the Terraform registry, Azure Storage Accounts for Terraform state files, and GitHub Actions for workflows. Detailed configuration, identities, ownership, and operating procedures remain to be documented. See [Terraform Platform](../infrastructure-as-code/terraform-platform.md).

## GitHub and Azure DevOps

### Who is responsible for the GitHub and Azure DevOps environments?

The **DevOps Engineering Team** is responsible for both environments. See [Environment Responsibilities](../ci-cd/README.md#environment-responsibilities). Contact details and access, approval, and support procedures remain to be documented.

## Monitoring and Observability

### What is our standard monitoring platform?

Dynatrace is our standard monitoring platform. Azure-native monitoring solutions are also used as needed or where appropriate. The Azure-native service inventory, selection criteria, coverage, integrations, alert routing, and operating ownership remain to be documented. See [Monitoring and Observability](../monitoring-and-observability/README.md).

## Categories

- Getting started
- Networking
- DNS
- Identity and access
- Security
- Private Endpoints
- Key Vault
- Storage
- Terraform
- GitHub Actions
- Azure DevOps
- AKS
- Application ingress
- API Management
- Monitoring
- Disaster recovery

When the same question is asked repeatedly, treat it as a signal that this FAQ or the underlying documentation should be improved.
