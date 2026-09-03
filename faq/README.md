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

### Which Azure environments do we have, and can they connect to each other?

The platform has DEV, INT, CRT, and PRD environments. They are not cross-connected, so designs must not depend on direct network connectivity between environments. Full environment definitions, subscriptions, topology, and enforcement remain to be documented. See [Environment Isolation](../architecture/environment-isolation.md).

## Application Ingress

### What fronts our application environments?

Fastly fronts our application environments and forwards traffic to Azure Application Gateway. Application Gateway then fronts the applications. Public or private exposure, DNS, TLS termination, WAF behavior, environment mappings, ownership, and support procedures remain to be documented. See [Application Ingress](../platform-services/application-ingress.md).

## DNS

### How are private DNS zones managed?

The **Cloud Platform Solutions and Services** team centrally manages all private DNS zones. Team contacts, ownership boundaries, zone locations, DNS resolution paths, and change request procedures remain to be documented. See [Private DNS Zone Management](../networking/private-dns-zone-management.md).

### Should I use a Private Endpoint?

Yes, where the Azure service supports Private Link and private service access is applicable. Public access must remain disabled by default. Private Endpoint, DNS, routing, and service-specific configuration still require a documented design and validation. See [Private Endpoints](../networking/private-endpoints.md).

## Security

### What security policy does the platform follow?

The platform follows a Zero Trust policy. Detailed control requirements, enforcement, and compliance remain unverified. See [Zero Trust Policy](../security/zero-trust-policy.md).

### Is MFA required for Azure access?

Yes. Multi-factor authentication (MFA) must be used for Azure user access. Approved MFA methods, authentication strength, covered access paths, session behavior, emergency access, enforcement, exceptions, and current compliance remain to be documented. See [Azure Identity and Access Requirements](../security/identity-and-access-requirements.md#mandatory-requirements).

### Which account must I use for elevated permissions in Azure?

Use your designated administrative account. A regular user account must not be used to exercise elevated permissions in Azure, and MFA is still required. The definition of elevated permissions, account provisioning and naming, privileged-access workflow, emergency access, exceptions, and current compliance remain to be documented. See [Azure Identity and Access Requirements](../security/identity-and-access-requirements.md#mandatory-requirements).

### Should public access be enabled by default?

No. Public access must be disabled by default for all resources, and Private Endpoints should be used where supported and applicable. A specific resource may receive public access only through the [Public Access Exemption Process](../security/public-access-exemption-process.md). See the [general Resource Security Baseline requirements](../security/resource-security-baseline.md#general-requirements).

### How do I request public access for a resource?

Submit a public-access exemption request for the resource. The Cyber Defense team in Security reviews the request. If Cyber Defense approves it, Cyber Defense sends the approved request to the Cloud Platform team, which creates the Azure Policy exemption for that resource. The request channel, required information, review criteria, validation, and exemption lifecycle remain to be documented. See the [Public Access Exemption Process](../security/public-access-exemption-process.md).

### What is the minimum TLS version?

TLS 1.2 is the required minimum. Later versions meet this minimum; earlier versions must not be permitted. See the [general Resource Security Baseline requirements](../security/resource-security-baseline.md#general-requirements).

## Key Vault and Storage

### Is purge protection required for Azure Key Vault?

Yes. Purge protection must be enabled for every Azure Key Vault. Current compliance, retention configuration, validation, and recovery and purge procedures remain to be documented. See the [resource-specific Resource Security Baseline requirements](../security/resource-security-baseline.md#resource-specific-requirements).

### Is soft delete required for Azure Storage Accounts?

Yes. Soft delete must be enabled for every Azure Storage Account. The applicable storage services and data types, required settings, retention periods, recovery procedures, and current compliance remain to be documented. See the [resource-specific Resource Security Baseline requirements](../security/resource-security-baseline.md#resource-specific-requirements).

### Can Storage Account containers allow public access?

No. Container public access must be disabled on every Azure Storage Account, and blob containers must not permit anonymous public access. This control is separate from public network access. A request to enable container public access must follow the [Public Access Exemption Process](../security/public-access-exemption-process.md); whether such a request can be approved remains to be documented. Current compliance, enforcement, exact settings, and validation evidence also remain unverified. See the [Storage Container Public Access requirement](../security/resource-security-baseline.md#storage-container-public-access).

## AKS

### Which ingress controller do our AKS clusters use?

We use Application Gateway Ingress Controller (AGIC) for ingress to our AKS clusters. Controller deployment mode, Application Gateway topology, ingress configuration, ownership, and operations remain to be documented. See [Azure Kubernetes Service (AKS)](../platform-services/aks.md).

### Are local accounts permitted on AKS clusters?

No. Local accounts must be disabled on every AKS cluster. Current compliance, enforcement, authentication configuration, administrative and break-glass access, exceptions, and validation evidence remain to be documented. See the [AKS local-account requirement](../platform-services/aks.md#mandatory-local-account-requirement) and [resource-specific Resource Security Baseline requirements](../security/resource-security-baseline.md#resource-specific-requirements).

### Must Azure RBAC be enabled on AKS clusters?

Yes. Azure RBAC for Kubernetes Authorization must be enabled on every AKS cluster. Current compliance, Microsoft Entra integration, Azure role definitions, assignments and scopes, privileged-access workflow, any remaining Kubernetes RBAC usage, enforcement, exceptions, and validation evidence remain to be documented. See the [mandatory Azure RBAC requirement](../platform-services/aks.md#mandatory-azure-rbac-requirement) and [resource-specific Resource Security Baseline requirements](../security/resource-security-baseline.md#resource-specific-requirements).

### How are AKS system and user node pools organized?

Our documented AKS design separates the system node pool from the user node pool. Pool sizing, scaling, zones, labels, taints, workload-placement controls, and current validation remain to be documented. See [Confirmed Node-Pool Separation](../platform-services/aks.md#confirmed-node-pool-separation).

## Terraform

### What tools make up our Terraform platform?

We use Artifactory as the Terraform registry, Azure Storage Accounts for Terraform state files, and GitHub Actions for workflows. The Cloud Platform team builds reusable Terraform modules and publishes them to Artifactory. The module catalog, versioning, support, detailed configuration, identities, and operating procedures remain to be documented. See [Terraform Platform](../infrastructure-as-code/terraform-platform.md).

## API Management

### What service do we use for APIs?

We use Azure API Management (APIM) for APIs. API inventory, gateway and backend paths, environments, policies, customer onboarding, ownership, and operations remain to be documented. See [Azure API Management](../platform-services/api-management.md).

## GitHub and Azure DevOps

### Who is responsible for the GitHub and Azure DevOps environments?

The **DevOps Engineering Team** is responsible for both environments. See [Environment Responsibilities](../ci-cd/README.md#environment-responsibilities). Contact details and access, approval, and support procedures remain to be documented.

## Monitoring and Observability

### What is our standard monitoring platform?

Dynatrace is our standard monitoring platform. Azure-native monitoring solutions are also used as needed or where appropriate. The Azure-native service inventory, selection criteria, coverage, integrations, alert routing, and operating ownership remain to be documented. See [Monitoring and Observability](../monitoring-and-observability/README.md).

### How do we privately access Azure Monitor resources?

We use Azure Monitor Private Link Scope (AMPLS). The AMPLS inventory, scoped resources, Private Endpoints, DNS, environment mapping, ingestion and query access modes, and support model remain to be documented. See [Azure Monitor Private Link Scope](../monitoring-and-observability/azure-monitor-private-link-scope.md).

## Changes and Support

### What approval is required for a production-impacting change?

A ServiceNow change request must be approved by the Change Board before implementation. Submission details, scope criteria, change types, lead times, and escalation remain to be documented. See [Production Change Management](../governance/production-change-management.md).

### Where should I start troubleshooting?

Use the [Troubleshooting](../troubleshooting/README.md) decision table for private connectivity, AKS, Terraform, and APIM issues. Its guides favor read-only checks and explain what evidence to collect before escalation.

## Categories

- Getting started
- Environments
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
- Production changes
- Troubleshooting
- Disaster recovery

When the same question is asked repeatedly, treat it as a signal that this FAQ or the underlying documentation should be improved.
