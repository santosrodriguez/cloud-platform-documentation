# Standards and Guidelines

Use this section to find approved requirements and recommended engineering practices.

## Documented Requirements

- [Zero Trust Policy](../security/zero-trust-policy.md): the user-confirmed security policy; detailed policy requirements and enforcement remain to be documented.
- [Azure Identity and Access Requirements](../security/identity-and-access-requirements.md): mandatory MFA for Azure user access and administrative-account use for elevated permissions, as confirmed by the user.
- [Resource Security Baseline](../security/resource-security-baseline.md): general public-access and minimum TLS requirements separated from resource-specific Key Vault purge protection, Storage Account soft delete, disabled AKS local accounts, and enabled Azure RBAC for Kubernetes Authorization, as confirmed by the user.

## Documented Platform Standards

- [Monitoring and Observability](../monitoring-and-observability/README.md): Dynatrace is the standard monitoring platform; Azure-native monitoring solutions are used as needed or where appropriate. Selection criteria and implementation details remain to be documented.

## Planned Coverage

- Architecture and infrastructure standards
- Networking and security guidelines
- Availability and disaster recovery requirements
- Monitoring and logging standards
- Documentation standards

Keep each requirement in one authoritative page. Link to existing [Terraform guidance](../infrastructure-as-code/README.md), [governance requirements](../governance/README.md), and [security documentation](../security/README.md) rather than duplicating them.

Use MUST and MUST NOT for approved mandatory requirements, SHOULD for recommendations, and MAY for permitted options. Mark proposed standards as drafts until reviewed.

[Home](../Home.md)
