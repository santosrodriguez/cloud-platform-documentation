# Resource Security Baseline

**Status:** User-confirmed requirements. Enforcement and compliance have not been verified.

**Source:** Platform requirements supplied by the user on 2026-08-31.

**Owner:** Not yet supplied.

## Purpose and Scope

This standard records the shared public-access default and minimum TLS version for our Azure resources. It defines required behavior, not a claim that existing resources already comply.

All resources are in scope for the public-access default. The TLS requirement applies to endpoints and connections that use TLS.

## Mandatory Requirements

| Control | Requirement |
| --- | --- |
| Public access | Public access **MUST** be disabled by default for all resources. |
| Minimum TLS version | TLS 1.2 or later is **REQUIRED**. TLS versions earlier than 1.2 **MUST NOT** be permitted. |

TLS 1.2 is the minimum, not a requirement to use exactly that version. Disabling public access does not remove the minimum TLS requirement.

## Implementation and Validation to Document

| Area | Details still needed |
| --- | --- |
| Public-access configuration | Resource inventory, the controls that disable public access for each resource type, and the configured defaults |
| TLS configuration | Applicable endpoints and TLS termination points, service-specific settings, and any configuration limitations |
| Enforcement | How the requirements are enforced, including any Azure Policy assignments, infrastructure-as-code defaults, or deployment checks actually in use |
| Validation evidence | Evidence that public access is disabled by default and that applicable TLS endpoints reject versions below 1.2 |
| Existing resources | Current compliance findings, any remediation work, and responsible owners |
| Exceptions | Exception criteria, approval ownership, and any approved deviations; none have been supplied for this documentation |

The entries above identify information to collect, not controls or processes already deployed. Service limitations do not establish an exception, and this page does not authorize public access or a lower TLS minimum.

No Azure configuration has been changed by recording these requirements. Service-specific implementation instructions and operational validation remain pending.

## Related Documentation

- [Security](README.md)
- [Zero Trust Policy](zero-trust-policy.md)
- [Standards and Guidelines](../standards-and-guidelines/README.md)
- [Governance](../governance/README.md)
- [Networking](../networking/README.md)
- [Using Azure](../using-azure/README.md)
- [Security FAQ](../faq/README.md#security)

[Home](../Home.md)
