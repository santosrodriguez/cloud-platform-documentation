# Command Cheat Sheets

**Status:** General reference. Organization-specific command workflows and ownership are pending review.

**Audience:** Azure platform consumers, platform engineers, and operators.

**Owner:** To be confirmed.

**Last reviewed:** 2026-09-03.

Use these pages as quick references for common command-line tasks. They do not replace an approved runbook, change record, pull-request review, or service-specific operating procedure.

## Available Cheat Sheets

| Tool | Use it for |
| --- | --- |
| [Terraform](terraform.md) | Format, validate, plan, apply, inspect, and troubleshoot Terraform configurations and state. |
| [Bash](bash.md) | Navigate files, search content, work with environment variables, and write safer shell scripts. |
| [Azure CLI](azure-cli.md) | Authenticate, select an Azure subscription, and inspect Azure resources from a command shell. |
| [PowerShell](powershell.md) | Work with PowerShell and the Az modules to inspect Azure contexts, resources, and access. |

## Safety Labels

Commands use the following labels where the effect may not be obvious.

| Label | Meaning |
| --- | --- |
| **Read-only** | Reads local or remote information without intentionally changing it. |
| **Local change** | Changes files, directories, environment variables, or local tool configuration. |
| **Azure change** | Can change resources, access, configuration, or data in Azure. |
| **Terraform state change** | Can change Terraform state or infrastructure represented by that state. |

Read-only commands can still expose sensitive names, identifiers, configuration, or state values in terminal output and logs. Review output before sharing it.

## Platform Guardrails

- Confirm the tenant, subscription, environment, and resource scope before running a command.
- Use the designated administrative account whenever elevated Azure permissions are required. Do not use a regular user account for elevated actions.
- Complete MFA when authenticating to Azure with a human identity.
- Use workload identity for automation instead of embedding a human username, password, access key, or client secret.
- Do not place secrets in command history, source files, Terraform variable files, plan files, logs, or Wiki examples.
- Use Terraform through the reviewed GitHub Actions workflow for infrastructure changes unless an approved procedure explicitly authorizes another method.
- Keep public access disabled by default and maintain TLS 1.2 or later. A public-access requirement must follow the [Public Access Exemption Process](../security/public-access-exemption-process.md).
- Do not change Palo Alto firewall rules or centrally managed Private DNS zones unless the responsible team has authorized the work.

## Placeholder Convention

Values enclosed in angle brackets are placeholders. Replace the complete placeholder, including the brackets, before running the command.

```text
<tenant-id>
<subscription-id>
<resource-group>
<resource-id>
<root-module>
```

Never replace a placeholder with a secret in a page, chat message, screenshot, issue, or pull request.

## Review Before Use

Command syntax and installed module behavior can change. Check the version installed in the target environment and consult the official reference linked from each page. Test changes in a non-production environment when one is available.

## Related Documentation

- [Infrastructure as Code](../infrastructure-as-code/README.md)
- [Terraform Platform](../infrastructure-as-code/terraform-platform.md)
- [CI/CD](../ci-cd/README.md)
- [Azure Identity and Access Requirements](../security/identity-and-access-requirements.md)
- [Resource Security Baseline](../security/resource-security-baseline.md)
- [Runbooks](../runbooks/README.md)

[Home](../Home.md)
