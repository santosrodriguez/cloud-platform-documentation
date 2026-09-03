# Requests and Forms

**Status:** User-confirmed directory of commonly used form names. Form links, complete purposes, ownership, approval paths, and service expectations have not been supplied.

**Source:** Common request-form names supplied by the user on 2026-09-03.

**Directory owner:** Not yet supplied.

## Customer Outcome

Use this page as the customer-facing directory for forms used to request Cloud Platform and related services.

The form names below are confirmed, but the forms are not yet actionable from this Wiki because their authoritative links and complete instructions have not been supplied. Continue to use the established internal location until this directory is completed.

## Request Form Directory

| Request form | When to use it | Authoritative form |
| --- | --- | --- |
| Firewall Request | A firewall-related request. The eligible firewall changes and request boundaries remain to be confirmed. | Link not yet supplied |
| Cloud Platform Request | A request for a Cloud Platform capability or service. The supported request catalog remains to be confirmed. | Link not yet supplied |
| ICETA Request | Use only when existing internal guidance identifies an ICETA Request as the correct form. | Link not yet supplied |

Do not infer the meaning of **ICETA** or use one form as a substitute for another until the form owners confirm the routing guidance.

## Before You Submit

The following is a practical preparation checklist, not a claim about mandatory fields in any form:

- Describe the business outcome and requested change.
- Identify the requesting team and a contact.
- Select the target environment: DEV, INT, CRT, or PRD.
- Identify the affected application, Azure service, subscription, resource, API, network path, or dependency as applicable.
- Record the current behavior, desired behavior, customer impact, requested timing, and relevant technical evidence.
- Include diagrams or reviewed source references when they materially clarify the request.
- Remove passwords, tokens, private keys, connection strings, customer data, Terraform state, and other secrets from the request.

Use the fields and instructions in the authoritative form when they differ from this preparation guidance.

## Requirements That Still Apply

- A form does not authorize a connection between DEV, INT, CRT, and PRD. The environments are not cross-connected.
- A resource that requires public access must follow the [Public Access Exemption Process](../security/public-access-exemption-process.md).
- A production-impacting change requires a [ServiceNow change request approved by the Change Board](../governance/production-change-management.md) before implementation.
- Cyber Defense Engineering manages the Palo Alto firewall and rules. Whether the Firewall Request is submitted to, reviewed by, or fulfilled by that team remains to be confirmed.
- The Cloud Platform Solutions and Services team centrally manages all private DNS zones. The request form used for DNS work has not been confirmed.

Submitting one of these forms does not replace a required security review, Azure Policy exemption, production change approval, source review, or technical validation.

## Directory Details to Complete

For each form, the responsible owner should supply:

| Information | What to document |
| --- | --- |
| Authoritative link | Direct form URL and the system that hosts it |
| Purpose and scope | Supported request types, exclusions, and examples |
| Requester prerequisites | Required access, information, designs, and prior approvals |
| Ownership | Form owner, approving groups, fulfillment team, and support contact |
| Workflow | Submission, review, revision, approval, fulfillment, validation, and closure |
| Service expectations | Priority handling, target times, status notifications, and escalation path if formally defined |
| Data handling | Information that may or must not be entered or attached |
| Lifecycle | Review date, replacement form, retirement process, and link validation owner |

No form is opened or submitted, and no request, approval, firewall rule, Azure resource, DNS change, policy exemption, or production change is created by this page.

## Related Documentation

- [Using Azure](README.md)
- [Firewall Management](../architecture/hub-and-spoke-network.md#firewall-management)
- [Private DNS Zone Management](../networking/private-dns-zone-management.md)
- [Public Access Exemption Process](../security/public-access-exemption-process.md)
- [Production Change Management](../governance/production-change-management.md)
- [Known Service Responsibilities](../reference/README.md#confirmed-service-responsibilities)

[Home](../Home.md)
