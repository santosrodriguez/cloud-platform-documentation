# Azure Identity and Access Requirements

**Status:** User-confirmed mandatory requirements. Implementation, enforcement, exceptions, ownership, and compliance have not been verified.

**Source:** Azure identity and access requirements supplied by the user on 2026-09-01.

**Owner:** Not yet supplied.

## Purpose and Scope

This standard records mandatory account-separation and multi-factor authentication requirements for people who access Azure. It defines required behavior, not a claim that identity controls are already configured or that existing access complies.

The requirements apply to Azure user access and to any person exercising elevated permissions in Azure. The Azure environments and access channels in scope, the definition of elevated permissions, and requirements for service principals, managed identities, and other non-human identities remain to be documented.

## Mandatory Requirements

| Control | Requirement |
| --- | --- |
| Multi-factor authentication | Multi-factor authentication (MFA) **MUST** be used for Azure user access. |
| Elevated permissions | Anyone exercising elevated permissions in Azure **MUST** use their designated administrative account. |
| Regular account restriction | A regular user account **MUST NOT** be used to exercise elevated permissions in Azure. |

These requirements are cumulative. When a person exercises elevated permissions in Azure, that person must use the designated administrative account and satisfy the MFA requirement. Completing MFA with a regular user account does not authorize that account to exercise elevated permissions.

## Interpretation Boundaries

- **Elevated permissions:** The roles, actions, scopes, and access states that qualify as elevated have not yet been defined in this documentation.
- **Administrative account:** Account provisioning, naming, permitted use, eligibility, activation, credential, and lifecycle requirements have not yet been supplied.
- **Regular user account:** The permitted Azure activities and access boundary for a regular account remain to be documented.
- **Azure user access:** The covered tenants, environments, interfaces, tools, and session types remain to be documented.
- **MFA:** Approved methods, authentication strength, registration, recovery, session, and reauthentication requirements remain to be documented.

This page does not establish identity requirements for workloads. It also does not authorize an administrative account to be used for purposes unrelated to elevated Azure permissions.

## Implementation and Validation to Document

| Area | Details still needed |
| --- | --- |
| Identity inventory | Administrative and regular account inventory, account ownership, and the Azure environments each account can access |
| Elevated-access scope | Roles, actions, resource scopes, and eligible, active, standing, or temporary access that qualify as elevated |
| Account lifecycle | Request, approval, provisioning, naming, credential, review, suspension, and removal procedures for administrative accounts |
| Privileged access workflow | How elevated access is requested, approved, activated, time-bounded, used, and removed |
| MFA configuration | Approved methods, authentication strength, registration and recovery, applicable access paths, session controls, and reauthentication behavior |
| Enforcement | Configured controls that require MFA and prevent regular accounts from exercising elevated permissions, including any identity policies or privileged-access tooling actually in use |
| Validation evidence | Evidence that Azure user access requires MFA and elevated permissions are exercised only through designated administrative accounts |
| Monitoring and review | Sign-in monitoring, privileged activity review, role and account access reviews, alerting, evidence retention, and remediation procedures |
| Emergency access | Emergency or break-glass account design, authorization, MFA behavior, monitoring, testing, and post-use review |
| Exceptions | Approval authority, criteria, compensating controls, duration, review, revocation, and exception inventory |
| Ownership | Accountable owner, implementation teams, review responsibilities, support contacts, and escalation path |

The entries above identify information to collect, not controls, products, or procedures already deployed.

## Exceptions and Related Processes

No exception process for these identity requirements has been supplied for this documentation. The [Public Access Exemption Process](public-access-exemption-process.md) applies only to resource public access and does not authorize an exception from MFA or the administrative-account requirement.

No Azure account, role assignment, MFA setting, identity policy, or privileged-access configuration has been changed by recording these requirements.

## Related Documentation

- [Security](README.md)
- [Zero Trust Policy](zero-trust-policy.md)
- [Resource Security Baseline](resource-security-baseline.md)
- [Governance](../governance/README.md)
- [Standards and Guidelines](../standards-and-guidelines/README.md)
- [Using Azure](../using-azure/README.md)
- [Security FAQ](../faq/README.md#security)

[Home](../Home.md)
