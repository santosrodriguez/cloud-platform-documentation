# Security

Authoritative Azure platform security standards, requirements, and implementation guidance.

## Documented Requirements

- [Zero Trust Policy](zero-trust-policy.md): the platform's confirmed security policy, with detailed controls and enforcement still to be documented.
- [Resource Security Baseline](resource-security-baseline.md): public access disabled by default for all resources, TLS 1.2 as the required minimum, Key Vault purge protection enabled, Storage Account soft delete enabled, and AKS local accounts disabled.
- [Public Access Exemption Process](public-access-exemption-process.md): the Cyber Defense team in Security reviews resource-specific public-access exemption requests, and Cloud Platform creates the Azure Policy exemption after approval.

These requirements and the exemption workflow are confirmed by the user. Request mechanics, service-specific configuration, enforcement, exemption lifecycle, and compliance evidence remain to be documented.

## Firewall Management

The **Cyber Defense Engineering** team is responsible for managing the Palo Alto firewall and its rules. See [Firewall Management](../architecture/hub-and-spoke-network.md#firewall-management). Team contacts, request channels, and approval procedures remain to be documented.

## Intended Content

- Identity and access management
- RBAC and privileged access
- Network security
- Private connectivity
- Service-specific public access controls
- Service-specific TLS and encryption configuration
- Additional Key Vault and secrets guidance
- Additional Storage Account protection guidance
- AKS identity and access guidance
- Defender for Cloud
- Security monitoring
- Additional security exceptions
