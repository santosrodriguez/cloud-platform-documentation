# Resource Security Baseline

**Status:** User-confirmed requirements and public-access exemption workflow. Enforcement and compliance have not been verified.

**Source:** Platform requirements supplied by the user on 2026-08-31.

**Owner:** Not yet supplied.

## Purpose and Scope

This standard records the shared public-access default, its approved exemption path, and the minimum TLS version for our Azure resources. It defines required behavior, not a claim that existing resources already comply.

All resources are in scope for the public-access default. The TLS requirement applies to endpoints and connections that use TLS.

## Mandatory Requirements

| Control | Requirement |
| --- | --- |
| Public access | Public access **MUST** be disabled by default for all resources. |
| Minimum TLS version | TLS 1.2 or later is **REQUIRED**. TLS versions earlier than 1.2 **MUST NOT** be permitted. |

TLS 1.2 is the minimum, not a requirement to use exactly that version. Disabling public access does not remove the minimum TLS requirement.

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
| Enforcement | How the requirements are enforced, including any Azure Policy assignments, infrastructure-as-code defaults, or deployment checks actually in use |
| Validation evidence | Evidence that public access is disabled by default and that applicable TLS endpoints reject versions below 1.2 |
| Existing resources | Current compliance findings, any remediation work, and responsible owners |
| Exceptions | Request channel, approval criteria, required evidence, implementation validation, expiration, renewal, revocation, and exception inventory |

The entries above identify information to collect, not controls or processes already deployed. Service limitations do not establish an exception, and this page does not authorize public access or a lower TLS minimum.

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

[Home](../Home.md)
