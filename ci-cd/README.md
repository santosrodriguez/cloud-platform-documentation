# CI/CD

Document how infrastructure and platform changes move from reviewed source code to deployment.

## Workflow Platform

We use [GitHub Actions](../infrastructure-as-code/terraform-platform.md#github-actions-workflows) for our workflows.

This confirms the workflow platform, not a repository or workflow inventory. Runner types, identities, permissions, triggers, approvals, secrets handling, deployment environments, validation, and rollback procedures remain to be documented.

## Environment Responsibilities

The **DevOps Engineering Team** is responsible for the **GitHub** and **Azure DevOps** environments.

**Source:** Responsibility supplied by the user on 2026-08-31.

The environment inventory, administrative boundaries, contact details, access-request channels, approval responsibilities, and support procedures remain to be documented. This responsibility does not by itself identify owners of individual repositories, application code, pipeline definitions, or deployed Azure resources.

## Deployment Guardrails

- The Azure platform environments are DEV, INT, CRT, and PRD, and they are not cross-connected. These Azure environment boundaries are distinct from the GitHub and Azure DevOps environments described above.
- Workflow configuration, state, variables, and resource references must preserve [Environment Isolation](../architecture/environment-isolation.md).
- The Cloud Platform team builds reusable Terraform modules and publishes them to the Artifactory Terraform registry.
- A production-impacting deployment **MUST NOT** begin until its ServiceNow change request is approved by the Change Board.

Repository-specific workflow gates, environment promotion, artifact controls, and the technical enforcement of Change Board approval remain to be documented.

## Planned Pages

- GitHub and Azure DevOps environment administration
- GitHub Actions workflow inventory and reusable workflow standards
- GitHub runners and network dependencies
- Workload identity and deployment permissions
- Environment strategy and promotion
- Secrets handling
- Deployment validation, rollback, and troubleshooting

Workflow names, identities, permissions, and approval requirements are pending confirmation.

## Related Sections

- [Infrastructure as Code](../infrastructure-as-code/README.md)
- [Terraform Platform](../infrastructure-as-code/terraform-platform.md)
- [Environment Isolation](../architecture/environment-isolation.md)
- [Production Change Management](../governance/production-change-management.md)
- [Security](../security/README.md)
- [Known Service Responsibilities](../reference/README.md#confirmed-service-responsibilities)
- [GitHub and Azure DevOps FAQ](../faq/README.md#github-and-azure-devops)
- [Runbooks](../runbooks/README.md)

[Home](../Home.md)
