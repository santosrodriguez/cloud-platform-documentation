# Governance

Azure platform governance documentation.

## Documented Requirements

The [Resource Security Baseline](../security/resource-security-baseline.md) separates general public-access and minimum TLS requirements from resource-specific Key Vault purge protection, Storage Account soft delete, and disabled AKS local-account requirements. The [Public Access Exemption Process](../security/public-access-exemption-process.md) records the confirmed Cyber Defense approval and Cloud Platform Azure Policy exemption workflow for a resource that requires public access.

The applicable policy assignments, deletion-protection settings, retention periods, AKS authentication and administrative access model, request channel, approval criteria, exemption configuration, validation, lifecycle, and compliance reporting remain to be documented.

The [Azure Identity and Access Requirements](../security/identity-and-access-requirements.md) require MFA for Azure user access and designated administrative accounts when exercising elevated permissions. Definitions, account lifecycle, privileged-access workflow, enforcement, emergency access, exceptions, ownership, and compliance remain to be documented.

The [Zero Trust Policy](../security/zero-trust-policy.md) is confirmed by the user. Its authoritative internal policy reference, ownership, detailed control requirements, and exception process remain to be supplied.

## Intended Content

- Azure Policy
- Management groups
- Subscription governance
- Naming standards
- Tagging standards
- Resource standards
- Approved regions
- Cost management
- Governance exceptions
