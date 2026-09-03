# Terraform Platform

**Status:** User-confirmed implementation baseline. Detailed configuration and operational validation are pending.

**Source:** Platform implementation details supplied by the user on 2026-08-31.

## Confirmed Toolchain

| Capability | Confirmed implementation |
| --- | --- |
| Terraform registry | Artifactory |
| Terraform state storage | Azure Storage Accounts |
| Workflow platform | GitHub Actions |

These facts identify the technologies in use. They do not establish endpoints, repository or account names, authentication methods, workflow inventories, or operating procedures.

## Confirmed Toolchain Relationship

```mermaid
flowchart TD
    source["Reviewed Terraform source"] --> workflows["GitHub Actions workflows"]
    workflows --> terraform["Terraform execution"]
    terraform -->|"Registry retrieval"| artifactory["Artifactory Terraform registry"]
    terraform -->|"Read and write state"| state["Azure Storage Account state"]
    terraform -->|"Planned and approved changes"| azure["Azure resources"]
```

The diagram shows how the confirmed technologies fit into the Terraform workflow. It does not define repository names, workflow triggers, runner placement, authentication, Artifactory contents, state layout, approval gates, or deployment permissions; those implementation details remain to be documented.

## Artifactory Terraform Registry

We use Artifactory as our Terraform registry.

The registry endpoint, repository structure, published content, module or provider scope, authentication, publication process, ownership, and availability design remain to be documented.

## Terraform State Storage

Terraform state files are stored in Azure Storage Accounts.

The subscriptions, resource groups, storage accounts, containers, state-key conventions, access controls, recovery settings, and operating procedures remain to be documented. State files, state contents, credentials, keys, and secrets must not be placed in this Wiki.

The storage resources are subject to the [Resource Security Baseline](../security/resource-security-baseline.md): public access must be disabled by default, TLS 1.2 or later is required, Storage Account soft delete must be enabled, and Storage Account container public access must be disabled. This records the requirements; it does not verify that any Storage Account complies or define the applicable soft-delete, retention, or anonymous-access settings.

## GitHub Actions Workflows

We use GitHub Actions for our workflows.

The repository and workflow inventory, runner type, workload identity, permissions, approvals, secrets handling, deployment environments, validation, and rollback procedures remain to be documented.

The [DevOps Engineering Team](../ci-cd/README.md#environment-responsibilities) is responsible for the GitHub environment. That responsibility does not by itself identify owners of individual repositories, workflows, application code, or deployed Azure resources.

## Implementation Details to Confirm

| Area | Details still needed |
| --- | --- |
| Artifactory configuration | Endpoint, repository names, published content, access model, publication process, and availability design |
| State backend configuration | Storage inventory, container and state-key conventions, access model, recovery controls, and environment separation |
| Workflow configuration | Repository and workflow inventory, triggers, reusable workflows, runners, deployment environments, validation, and rollback |
| Access and identity | Authentication methods, workload identities, permissions, credential handling, and access-review procedures |
| Security and compliance | Enforcement and evidence for the resource security baseline, workflow protections, and approved exceptions, if any |
| Ownership and operations | Component owners, support contacts, request paths, approval responsibilities, monitoring, and incident procedures |

The entries above identify information to collect. They do not describe configuration or procedures already in place, and this page does not change infrastructure or workflow settings.

## Related Documentation

- [Terraform Command Cheat Sheet](../command-cheat-sheets/terraform.md)
- [Infrastructure as Code](README.md)
- [CI/CD](../ci-cd/README.md)
- [Resource Security Baseline](../security/resource-security-baseline.md)
- [Standards and Guidelines](../standards-and-guidelines/README.md)
- [Terraform FAQ](../faq/README.md#terraform)

[Home](../Home.md)
