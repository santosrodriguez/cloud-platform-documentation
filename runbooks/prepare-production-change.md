# Runbook: Prepare a Production Change

**Status:** Draft readiness runbook. The approved ServiceNow procedure, required fields, and Change Board operating process remain to be documented.

**Owner:** Not yet supplied.

**Last tested:** Not yet tested.

## Purpose

Prepare a production-impacting change for Change Board review and verify the mandatory approval gate before implementation begins.

## When to Use This Runbook

Use whenever a proposed change can affect production services, customers, data, security, connectivity, monitoring, shared dependencies, or recovery capability.

If production impact is uncertain, treat the classification as unresolved and obtain guidance through the approved change process before implementation. The classification owner remains to be documented.

## Prerequisites

- Reviewed technical change scope
- Identified production services and dependencies
- Implementation, validation, monitoring, rollback, and communication plans
- Test and Terraform plan evidence when applicable
- Related security, public-access, architecture, or access approvals when applicable

## Required Permissions

- Permission to create and view the required ServiceNow change request
- Access to attach or link approved evidence
- Repository and workflow access needed to prepare the technical change

The ServiceNow request path and role names have not been supplied.

## Risk and Impact

This runbook prepares and validates a change record; it does not implement the technical change. Incomplete impact analysis, approval ambiguity, or a mismatch between the approved record and implementation can create production risk.

## Procedure

### 1. Define the Change Boundary

Record:

- objective and reason
- production services, APIs, resources, customers, and data affected
- target environment, subscription, region, and resource scope
- dependencies, including DNS, Private Endpoints, routes, Palo Alto rules, identity, APIM, AKS, monitoring, and Terraform state
- what is explicitly out of scope

Confirm that the design does not introduce a connection between DEV, INT, CRT, and PRD.

### 2. Prepare Implementation and Stop Conditions

Write ordered steps with an accountable implementer, expected result, estimated duration, and a stop condition for each material phase. Use reviewed automation and Terraform rather than ad hoc production commands unless an approved runbook authorizes them.

### 3. Prepare Validation and Monitoring

Define checks for service health, customer outcome, telemetry, security controls, private connectivity, data integrity, and dependent systems. Identify how long the change will be observed before completion.

Dynatrace is the standard monitoring platform; Azure-native monitoring is used where needed or appropriate. The exact dashboards, alerts, and owners must be specific to the change.

### 4. Prepare Rollback or Recovery

Document:

- conditions that trigger rollback or recovery
- responsible decision maker and implementer
- ordered actions
- data and state implications
- validation after rollback
- point after which rollback is unsafe and recovery is required instead

Do not claim a rollback is tested unless evidence exists.

### 5. Assemble Review Evidence

Link or attach the reviewed source, pull request, approved Terraform plan, test results, architecture decision, security approval, public-access exemption, implementation plan, validation plan, and rollback evidence that apply.

Do not attach credentials, state files, plan files containing sensitive values, tokens, private keys, customer data, or unnecessary internal topology.

### 6. Create the ServiceNow Change Request

Use the approved ServiceNow change-request process and enter the required scope, risk, impact, schedule, implementation, validation, monitoring, rollback, communications, and evidence. The catalog item, template, mandatory fields, and lead times remain to be documented.

### 7. Obtain Change Board Approval

Submit the request for Change Board review. Address requested revisions through the change record.

The change **MUST NOT** be implemented until the Change Board approval is recorded and can be verified.

### 8. Verify the Pre-Implementation Gate

Immediately before handoff for implementation, confirm:

- change request identifier and approved status
- approved scope, environment, implementation window, and implementer
- current source commit and plan match the approved evidence
- required security and access approvals remain valid
- validation, monitoring, stop conditions, rollback, and communications are ready
- no conflicting or dependent change invalidates the plan

If any item is missing, changed, expired, or ambiguous, stop and return the request to the approved process.

## Validation

This preparation runbook passes only when a ServiceNow change request exists, the Change Board approval is recorded, approved scope and evidence match the implementation package, and all pre-implementation checks are complete.

## Expected Results

The result is a production change package eligible to enter its separately approved implementation procedure and window. This runbook does not authorize work outside the approved scope or window.

## Rollback

Before implementation, withdraw, revise, or reschedule the change through the approved ServiceNow process if scope or readiness changes. No infrastructure rollback is needed because this runbook performs no deployment.

## Troubleshooting

| Problem | Action |
| --- | --- |
| Scope changed after approval | Stop and return the updated scope to the approved change process. |
| Approval status is unclear | Stop until authoritative approval evidence is available. |
| Plan or source changed | Generate and review new evidence; determine whether reapproval is required through the approved process. |
| Rollback is not credible | Do not schedule implementation until recovery risk is accepted through the approved process. |
| Required owner is unavailable | Reschedule or use the documented escalation path; that path remains to be supplied. |

## Escalation

The Change Board handles the required approval. The ServiceNow support channel, process owner, emergency-change authority, failed-change path, and escalation contacts remain to be documented.

## References

- [Production Change Management](../governance/production-change-management.md)
- [Environment Isolation](../architecture/environment-isolation.md)
- [Terraform Platform](../infrastructure-as-code/terraform-platform.md)
- [Monitoring and Observability](../monitoring-and-observability/README.md)

[Runbooks](README.md) | [Home](../Home.md)
