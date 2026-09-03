# Troubleshoot Terraform Workflows

**Status:** Draft diagnostic guidance. Local inspection commands are non-deploying, and organization-specific workflow recovery procedures remain to be reviewed.

**Audience:** Engineers diagnosing Terraform module retrieval, initialization, validation, planning, state access, or GitHub Actions failures.

**Owner:** Not yet supplied.

## Platform Context

- The Cloud Platform team builds reusable Terraform modules and publishes them to the Artifactory Terraform registry.
- Azure Storage Accounts hold Terraform state files.
- GitHub Actions runs Terraform workflows.
- DEV, INT, CRT, and PRD are separate and not cross-connected.
- Production-impacting changes require an approved ServiceNow change request before implementation.

## Customer-Safe and Privileged Checks

| Access level | Checks |
| --- | --- |
| Customer-safe | Inspect repository status and versions and run non-deploying formatting checks on an authorized working copy. Initialization and validation are appropriate only when the contributor already has normal module and provider access. |
| Privileged operator | Inspect protected workflows, Azure identities, backend access, state-lock metadata, Azure Storage, Private Endpoints, or network configuration. Use the designated administrative account and MFA when elevated Azure access is required. |

Do not retrieve state contents, broaden access, or run a local apply as part of customer-safe troubleshooting.

## Symptom Guide

| Symptom | Likely causes to investigate |
| --- | --- |
| Module download returns `401` or `403` | Missing, expired, or unauthorized Artifactory authentication |
| Module or version cannot be found | Incorrect source, unpublished version, typographical error, or registry availability |
| Backend initialization fails | Private DNS or network path, Azure identity, RBAC, backend address, or Storage Account availability |
| State lock is held | Another active workflow, interrupted operation, or stale lock requiring an approved recovery decision |
| `terraform validate` fails | Invalid syntax, inconsistent types, missing module initialization, or incompatible provider/module version |
| Plan targets the wrong resources | Wrong environment inputs, backend, workspace, subscription, branch, or state key |
| GitHub Actions authentication fails | OIDC subject, protected environment, workflow permission, federated credential, or Azure role assignment |
| Plan introduces a cross-environment dependency | Incorrect module input or resource reference; do not connect environments to resolve it |

## Step 1: Establish Scope

Record the repository, branch, root module, intended environment, workflow run, and expected state key without recording credentials or state contents.

```bash
terraform version
git status --short --branch
```

Confirm that the selected environment is exactly one of DEV, INT, CRT, or PRD and that configuration does not reference resources in another environment.

## Step 2: Run Local Static Checks

The following checks do not apply infrastructure changes:

```bash
terraform fmt -check -recursive

terraform init -backend=false -input=false

terraform validate

terraform providers
```

`terraform init -backend=false` can still download modules and providers and therefore requires the expected Artifactory and provider access. It creates local working files but does not initialize or read the configured remote state backend.

Inspect module sources without printing variable values:

```bash
rg -n 'source[[:space:]]*=' \
  --glob '*.tf'
```

Verify that reusable module sources and requested versions match modules published by the Cloud Platform team. The Artifactory naming convention, module catalog, and versioning policy remain to be documented.

## Step 3: Classify Initialization Failures

| Failure area | Safe evidence to collect |
| --- | --- |
| Artifactory | HTTP status, module source, requested version, timestamp, and sanitized Terraform error |
| Provider installation | Provider address, locked version, platform, and sanitized checksum or availability error |
| Azure Storage backend | Environment, backend resource identifiers, DNS result, Azure context, HTTP status, and sanitized error |
| Private connectivity | Expected hostname and Private Endpoint evidence from the [private connectivity guide](private-connectivity.md) |

Do not paste Artifactory tokens, Azure tokens, backend keys, `.tfstate`, plan files, environment-variable dumps, or CLI configuration containing credentials into tickets or the Wiki.

## Step 4: Diagnose State Locking Safely

1. Determine whether another GitHub Actions run or authorized operator is active against the same state.
2. Record the lock identifier, owner, operation, creation time, and state scope from the error without exposing state data.
3. Wait for an active operation to finish.
4. If the operation is no longer active, use the approved state-lock recovery process. That process and its owner remain to be documented.

Do not run `terraform force-unlock` or delete a lock as an unreviewed troubleshooting step.

## Step 5: Review the Plan in the Approved Workflow

Use the repository's reviewed GitHub Actions plan workflow. Before any apply, verify:

- the target is the intended environment and state
- there are no unexpected creates, updates, replacements, or deletes
- module versions match modules published by the Cloud Platform team to the Artifactory Terraform registry
- public access remains disabled by default
- Private Endpoint use has been assessed against the recommendation to use them where supported and applicable
- TLS and resource-specific security controls remain satisfied
- no dependency or network path cross-connects environments
- identities, role assignments, routes, DNS, and firewall effects are understood
- rollback or recovery is credible

A local plan may not reproduce the protected runner's identity, network path, environment controls, or backend access. The workflow result is the review artifact unless the approved process states otherwise.

## Production Stop Condition

Do not apply a production-impacting change until its ServiceNow change request is approved by the Change Board. Approval of a pull request or Terraform plan is not a substitute for that change approval.

## Validation

A resolved workflow should initialize from the intended sources, pass formatting and validation, access only the intended environment state, produce a reviewed plan with expected actions, and complete through the repository's GitHub Actions identity and intended network path.

## Escalation Package

Provide the repository, branch, commit, root module, environment, workflow run URL, Terraform version, module source and version, failure phase, UTC timestamp, sanitized error, expected outcome, and recent changes. Exclude credentials, state, plan files, secret values, and sensitive outputs.

Ownership for module support, Artifactory access, state recovery, individual workflows, and deployed resources remains to be documented. DevOps Engineering is responsible for the GitHub environment; that does not establish ownership of each workflow or Terraform module.

## Official References

- [HashiCorp: Initialize Terraform configuration](https://developer.hashicorp.com/terraform/cli/commands/init)
- [HashiCorp: Validate configuration](https://developer.hashicorp.com/terraform/cli/commands/validate)
- [HashiCorp: Create a Terraform plan](https://developer.hashicorp.com/terraform/cli/commands/plan)

[Troubleshooting](README.md) | [Terraform Platform](../infrastructure-as-code/terraform-platform.md) | [Home](../Home.md)
