# Runbook: Validate a Terraform Change

**Status:** Draft, non-deploying runbook. Repository-specific workflow review and testing are pending.

**Owner:** Not yet supplied.

**Last tested:** Not yet tested.

## Purpose

Validate Terraform formatting, configuration, module sources, target environment, and plan evidence before an infrastructure change is eligible for implementation.

## When to Use This Runbook

Use for changes that consume reusable Cloud Platform modules from Artifactory and are planned through GitHub Actions against Azure Storage Account state.

This runbook stops before `terraform apply` and does not authorize deployment.

## Prerequisites

- Reviewed repository branch with the proposed Terraform change
- Repository-specific Terraform version and initialization instructions
- Intended environment: DEV, INT, CRT, or PRD
- Access to the required Artifactory modules and providers
- Repository GitHub Actions plan workflow
- Known backend and state key for the target environment

## Required Permissions

- Read access to the repository and module source
- Artifactory read access required for initialization
- Permission to run or review the repository's GitHub Actions plan workflow
- Azure and state read access only when the repository's plan workflow requires it

## Risk and Impact

Formatting checks and validation do not deploy infrastructure. Initialization creates local files and can retrieve modules and providers. A plan reads remote state and Azure resources and may take a state lock. Plan output can contain sensitive values even when marked sensitive; protect it accordingly.

## Procedure

### 1. Confirm Repository and Environment

```bash
git status --short --branch
terraform version
```

Confirm the intended environment and ensure the change does not reference or create connectivity to DEV, INT, CRT, or PRD from another environment.

### 2. Check Formatting Without Rewriting Files

```bash
terraform fmt -check -recursive
```

If formatting fails, update the source on the working branch and include that change in normal review. Do not format unrelated files without reviewing the resulting diff.

### 3. Initialize Without the Backend

```bash
terraform init -backend=false -input=false
```

This validates module and provider retrieval without connecting to the configured state backend. Confirm that reusable modules resolve from the Artifactory Terraform registry.

### 4. Validate Configuration

```bash
terraform validate
terraform providers
```

Resolve syntax, type, provider, and module errors in source control. Do not work around an unavailable published module by changing to an unreviewed source.

### 5. Inspect Module Sources

```bash
rg -n 'source[[:space:]]*=' \
  --glob '*.tf'
```

Verify source addresses and pinned versions against the modules published by the Cloud Platform team. The catalog, module-selection standard, and versioning policy remain to be documented.

### 6. Run the Approved Plan Workflow

Use the repository's GitHub Actions plan workflow with the intended protected environment. Workflow names, inputs, runner labels, and approval mechanics vary by repository and must be documented there.

Do not pass secrets as command-line arguments, commit `.tfvars` containing secrets, or publish plan files.

### 7. Review Plan Safety

Confirm all of the following:

- correct environment, subscription, backend, state key, and workspace
- expected module versions from Artifactory
- expected resource actions with no unexplained deletes or replacements
- public access disabled by default
- Private Endpoint use assessed against the recommendation to use them where supported and applicable
- TLS 1.2 minimum and resource-specific security controls preserved
- no cross-environment connectivity or dependency
- identity, role, DNS, route, firewall, data, monitoring, cost, and recovery impacts understood
- validation and rollback steps are specific to the proposed actions

### 8. Confirm Production Change Gate

If the change is production-impacting, record the ServiceNow change request and verify Change Board approval before implementation. A successful plan or pull-request approval does not satisfy this gate.

## Validation

The runbook passes when formatting and validation succeed, module sources match modules published by the Cloud Platform team, the plan targets only the intended environment and state, every action is understood, required reviewers approve the source, and any production change approval is verifiably complete.

## Expected Results

The output is a reviewed, non-expired plan and an evidence set that can be used by the repository's deployment workflow. It is not permission to apply outside that workflow.

## Rollback

Because this runbook does not deploy, rollback consists of revising or withdrawing the source change and generating a new plan. Do not apply a reverse change merely to compensate for an unimplemented plan.

## Troubleshooting

Use [Troubleshoot Terraform Workflows](../troubleshooting/terraform.md). Do not force-unlock state, change backends, bypass Artifactory, or run a local apply without a documented procedure.

## Escalation

Provide the repository, branch, commit, environment, root module, Terraform version, workflow run, sanitized error, module source and version, expected outcome, and plan summary. Exclude credentials, state, plan files, and sensitive values. Module, state, workflow, and deployment escalation owners remain to be documented.

## References

- [Terraform Platform](../infrastructure-as-code/terraform-platform.md)
- [Terraform Command Cheat Sheet](../command-cheat-sheets/terraform.md)
- [Environment Isolation](../architecture/environment-isolation.md)
- [Production Change Management](../governance/production-change-management.md)

[Runbooks](README.md) | [Home](../Home.md)
