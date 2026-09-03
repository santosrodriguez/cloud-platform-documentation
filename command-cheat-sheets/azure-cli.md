# Azure CLI Command Cheat Sheet

**Status:** General inspection reference. Organization-specific Azure CLI change procedures are pending review.

**Audience:** Engineers who inspect or troubleshoot Azure resources from Bash or another command shell.

**Owner:** To be confirmed.

**Last reviewed:** 2026-09-03.

This page intentionally emphasizes read-only discovery. Azure infrastructure changes should use reviewed Terraform and GitHub Actions workflows unless an approved runbook explicitly authorizes a direct CLI change.

## Before You Begin

- Connect from an approved workstation or runner with the required private-network access.
- Use the designated administrative account when the task needs elevated permissions.
- Complete MFA for human authentication.
- Know the intended tenant, subscription, and resource scope.
- Treat command output as potentially sensitive.

## Inspect the Installation

**Read-only**

```bash
az version
az --help
az find '<command or concept>'
```

## Sign In Interactively

**Authentication context change**

```bash
az login --tenant '<tenant-id>'
```

If a browser cannot be opened:

```bash
az login --tenant '<tenant-id>' --use-device-code
```

Do not use a human username and password in scripts. Use an approved workload identity for automation.

## Confirm and Select a Subscription

**Read-only**

```bash
az account list \
  --query '[].{Name:name, SubscriptionId:id, State:state}' \
  --output table

az account show \
  --query '{Name:name, SubscriptionId:id, TenantId:tenantId}' \
  --output table
```

**Authentication context change**

```bash
az account set --subscription '<subscription-id-or-name>'
```

Always run `az account show` after selecting a subscription and before a state-changing operation.

## Inspect the Signed-In User

**Read-only:** Microsoft Graph access may be required.

```bash
az ad signed-in-user show \
  --query '{DisplayName:displayName, UserPrincipalName:userPrincipalName, ObjectId:id}' \
  --output table
```

Confirm that an elevated task is using the designated administrative account rather than the regular user account.

## List Resource Groups

**Read-only**

```bash
az group list \
  --query '[].{Name:name, Location:location}' \
  --output table

az group show \
  --name '<resource-group>' \
  --output jsonc
```

## Find Resources

**Read-only**

```bash
az resource list \
  --resource-group '<resource-group>' \
  --query '[].{Name:name, Type:type, Location:location}' \
  --output table

az resource list \
  --tag '<tag-name>=<tag-value>' \
  --query '[].{Name:name, Group:resourceGroup, Type:type}' \
  --output table

az resource show \
  --ids '<resource-id>' \
  --output jsonc
```

## Inspect Role Assignments

**Read-only:** Role-assignment output may reveal sensitive identity and access information.

```bash
az role assignment list \
  --scope '<resource-id>' \
  --include-inherited \
  --query '[].{Principal:principalName, Role:roleDefinitionName, Scope:scope}' \
  --output table
```

Use the narrowest relevant scope. Do not create or remove role assignments without the approved access procedure.

## Inspect Existing Networking

**Read-only**

```bash
az network vnet show \
  --resource-group '<resource-group>' \
  --name '<vnet-name>' \
  --output jsonc

az network vnet subnet show \
  --resource-group '<resource-group>' \
  --vnet-name '<vnet-name>' \
  --name '<subnet-name>' \
  --output jsonc

az network private-endpoint list \
  --resource-group '<resource-group>' \
  --output table

az network route-table route list \
  --resource-group '<resource-group>' \
  --route-table-name '<route-table-name>' \
  --output table
```

The hub, ExpressRoute, routes, Palo Alto firewall, and Private DNS zones are existing shared dependencies. Do not change firewall rules or centrally managed Private DNS zones from this cheat sheet.

## Inspect Private DNS

**Read-only:** Access depends on the permissions granted by the team that centrally manages Private DNS.

```bash
az network private-dns zone list \
  --resource-group '<dns-resource-group>' \
  --output table

az network private-dns record-set list \
  --resource-group '<dns-resource-group>' \
  --zone-name '<private-dns-zone>' \
  --output table
```

## Inspect Recent Activity

**Read-only**

```bash
az monitor activity-log list \
  --resource-id '<resource-id>' \
  --offset 4h \
  --query '[].{Time:eventTimestamp, Operation:operationName.localizedValue, Status:status.localizedValue}' \
  --output table
```

## Control Output

```bash
az <command> --output table
az <command> --output jsonc
az <command> --query '<jmespath-expression>' --output tsv
az <command> --only-show-errors
```

Use `--output none` for an approved state-changing command when its normal output could expose sensitive values. Do not suppress errors needed for validation or audit evidence.

## Sign Out and Clear Cached Subscriptions

**Authentication context change**

```bash
az logout
az account clear
```

## Commands Requiring a Runbook

Direct commands that create, update, delete, move, expose, or grant access to Azure resources are intentionally omitted. A runbook for those actions must define:

- exact scope and prerequisites
- required role and approval
- expected impact and dependencies
- validation and rollback
- security-baseline checks
- logging and evidence requirements
- responsible team and escalation path

## Official References

- [Azure CLI command reference](https://learn.microsoft.com/cli/azure/reference-index)
- [Sign in interactively with Azure CLI](https://learn.microsoft.com/cli/azure/authenticate-azure-cli-interactively)
- [`az account`](https://learn.microsoft.com/cli/azure/account)
- [`az resource`](https://learn.microsoft.com/cli/azure/resource)
- [Azure CLI output formats](https://learn.microsoft.com/cli/azure/format-output-azure-cli)

[Command Cheat Sheets](README.md) | [Azure Identity and Access Requirements](../security/identity-and-access-requirements.md) | [Home](../Home.md)
