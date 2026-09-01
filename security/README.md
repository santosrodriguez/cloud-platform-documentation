# Security

Authoritative Azure platform security standards, requirements, and implementation guidance.

## Documented Requirements

- [Zero Trust Policy](zero-trust-policy.md): the platform's confirmed security policy, with detailed controls and enforcement still to be documented.
- [Azure Identity and Access Requirements](identity-and-access-requirements.md): MFA required for Azure user access and designated administrative accounts required when exercising elevated permissions.
- [Resource Security Baseline](resource-security-baseline.md): general public-access and minimum TLS requirements, plus resource-specific Key Vault purge protection, Storage Account soft delete, and disabled AKS local accounts.
- [Public Access Exemption Process](public-access-exemption-process.md): the Cyber Defense team in Security reviews resource-specific public-access exemption requests, and Cloud Platform creates the Azure Policy exemption after approval.

These requirements and the exemption workflow are confirmed by the user. Request mechanics, service-specific configuration, enforcement, exemption lifecycle, and compliance evidence remain to be documented.

## Firewall Management

The **Cyber Defense Engineering** team is responsible for managing the Palo Alto firewall and its rules. See [Firewall Management](../architecture/hub-and-spoke-network.md#firewall-management). Team contacts, request channels, and approval procedures remain to be documented.

## Intended Content

- Detailed identity and access implementation guidance
- RBAC and privileged access operating procedures
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
