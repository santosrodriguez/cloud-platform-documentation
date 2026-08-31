# CI/CD

Document how infrastructure and platform changes move from reviewed source code to deployment.

## Workflow Platform

We use [GitHub Actions](../infrastructure-as-code/terraform-platform.md#github-actions-workflows) for our workflows.

This confirms the workflow platform, not a repository or workflow inventory. Runner types, identities, permissions, triggers, approvals, secrets handling, deployment environments, validation, and rollback procedures remain to be documented.

## Environment Responsibilities

The **DevOps Engineering Team** is responsible for the **GitHub** and **Azure DevOps** environments.

**Source:** Responsibility supplied by the user on 2026-08-31.

The environment inventory, administrative boundaries, contact details, access-request channels, approval responsibilities, and support procedures remain to be documented. This responsibility does not by itself identify owners of individual repositories, application code, pipeline definitions, or deployed Azure resources.

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
- [Security](../security/README.md)
- [Known Service Responsibilities](../reference/README.md#confirmed-service-responsibilities)
- [GitHub and Azure DevOps FAQ](../faq/README.md#github-and-azure-devops)
- [Runbooks](../runbooks/README.md)

[Home](../Home.md)
