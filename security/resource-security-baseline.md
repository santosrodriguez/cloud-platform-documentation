# Resource Security Baseline

**Status:** User-confirmed security and deletion-protection requirements, plus the public-access exemption workflow. Enforcement and compliance have not been verified.

**Source:** Platform requirements supplied by the user on 2026-08-31 and 2026-09-01.

**Owner:** Not yet supplied.

## Purpose and Scope

This standard records the shared public-access default, its approved exemption path, the minimum TLS version, and service-specific deletion-protection requirements for our Azure resources. It defines required behavior, not a claim that existing resources already comply.

All resources are in scope for the public-access default. The TLS requirement applies to endpoints and connections that use TLS. The purge-protection requirement applies to Azure Key Vault resources, and the soft-delete requirement applies to Azure Storage Accounts.

## Mandatory Requirements

| Control | Requirement |
| --- | --- |
| Public access | Public access **MUST** be disabled by default for all resources. |
| Minimum TLS version | TLS 1.2 or later is **REQUIRED**. TLS versions earlier than 1.2 **MUST NOT** be permitted. |
| Key Vault purge protection | Purge protection **MUST** be enabled for every Azure Key Vault. |
| Storage Account soft delete | Soft delete **MUST** be enabled for every Azure Storage Account. |

TLS 1.2 is the minimum, not a requirement to use exactly that version. Disabling public access does not remove the minimum TLS requirement.

## Service-Specific Deletion Protection

Azure Key Vault purge protection and Azure Storage Account soft delete are mandatory controls. They are requirements, not claims that existing resources currently comply.

The Storage Account requirement is confirmed at the account level. The applicable storage services and data types, required soft-delete settings, retention periods, recovery procedures, and permanent-deletion procedures remain to be documented.

The [Public Access Exemption Process](public-access-exemption-process.md) applies only to public access. It does not authorize an exception from Key Vault purge protection, Storage Account soft delete, the minimum TLS version, or any other control.

## Public Access Exemptions

A requester that requires a specific resource to have public access **MUST** follow the [Public Access Exemption Process](public-access-exemption-process.md):

1. Submit a public-access exemption request for the resource.
2. Obtain review and approval from the Cyber Defense team in Security.
3. Cyber Defense sends the approved request to the Cloud Platform team.
4. The Cloud Platform team creates the Azure Policy exemption for that resource.

The resource **MUST NOT** be treated as exempt from the public-access default until the Cloud Platform team has created the resource-specific Azure Policy exemption. The request channel, approval criteria, implementation details, validation, and exemption lifecycle remain to be documented.

## Implementation and Validation to Document

| Area | Details still needed |
| --- | --- |
| Public-access configuration | Resource inventory, the controls that disable public access for each resource type, and the configured defaults |
| TLS configuration | Applicable endpoints and TLS termination points, service-specific settings, and any configuration limitations |
| Key Vault purge protection | Key Vault inventory, configured purge-protection state, retention configuration, recovery and purge procedures, and validation evidence |
| Storage Account soft delete | Storage Account inventory, applicable services and data types, configured soft-delete settings, retention periods, recovery procedures, and validation evidence |
| Enforcement | How the requirements are enforced, including any Azure Policy assignments, infrastructure-as-code defaults, or deployment checks actually in use |
| Validation evidence | Evidence that public access is disabled by default, applicable TLS endpoints reject versions below 1.2, Key Vault purge protection is enabled, and Storage Account soft delete is enabled |
| Existing resources | Current compliance findings, any remediation work, and responsible owners |
| Exceptions | Request channel, approval criteria, required evidence, implementation validation, expiration, renewal, revocation, and exception inventory |
| Deletion-protection exceptions | Any approved exception criteria or process for Key Vault purge protection or Storage Account soft delete; none has been supplied for this documentation |

The entries above identify information to collect, not controls or processes already deployed. Service limitations do not establish an exception, and this page does not authorize public access, a lower TLS minimum, disabled Key Vault purge protection, or disabled Storage Account soft delete.

No Azure configuration has been changed by recording these requirements. Service-specific implementation instructions and operational validation remain pending.

## Related Documentation

- [Security](README.md)
- [Zero Trust Policy](zero-trust-policy.md)
- [Public Access Exemption Process](public-access-exemption-process.md)
- [Standards and Guidelines](../standards-and-guidelines/README.md)
- [Governance](../governance/README.md)
- [Networking](../networking/README.md)
- [Using Azure](../using-azure/README.md)
- [Security FAQ](../faq/README.md#security)
- [Key Vault and Storage FAQ](../faq/README.md#key-vault-and-storage)

[Home](../Home.md)
