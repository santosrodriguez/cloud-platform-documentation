# PowerShell Command Cheat Sheet

**Status:** General inspection reference. Organization-specific Azure PowerShell change procedures are pending review.

**Audience:** Engineers who use PowerShell and the Az modules to inspect or troubleshoot Azure resources.

**Owner:** To be confirmed.

**Last reviewed:** 2026-09-03.

This page intentionally emphasizes read-only discovery. Azure infrastructure changes should use reviewed Terraform and GitHub Actions workflows unless an approved runbook explicitly authorizes a direct PowerShell change.

## Before You Begin

- Use PowerShell 7 where supported by the approved workstation standard.
- Use the supported Az module version for the target environment.
- Connect from an approved workstation or runner with the required private-network access.
- Use the designated administrative account when the task needs elevated permissions.
- Complete MFA for human authentication.
- Treat command output and exported objects as potentially sensitive.

## Inspect the Installation

**Read-only**

```powershell
$PSVersionTable
Get-Module -Name Az* -ListAvailable |
    Sort-Object Name, Version |
    Select-Object Name, Version, Path
Get-Help Connect-AzAccount -Full
```

Install or upgrade PowerShell and Az modules only through the approved workstation or runner-management process.

## Sign In Interactively

**Authentication context change**

```powershell
$TenantId = '<tenant-id>'
Connect-AzAccount -Tenant $TenantId
```

If a browser cannot be opened:

```powershell
Connect-AzAccount -Tenant $TenantId -UseDeviceAuthentication
```

Do not use a human username and password in scripts. Use an approved workload identity for automation.

## Confirm and Select a Subscription

**Read-only**

```powershell
Get-AzContext | Format-List Account, Tenant, Subscription, Environment

Get-AzSubscription |
    Select-Object Name, Id, State, TenantId |
    Format-Table
```

**Authentication context change**

```powershell
$SubscriptionId = '<subscription-id>'
Set-AzContext -Subscription $SubscriptionId
Get-AzContext | Format-List Account, Tenant, Subscription, Environment
```

Always confirm the context before a state-changing operation. Verify that an elevated task is using the designated administrative account.

## Inspect Resource Groups

**Read-only**

```powershell
Get-AzResourceGroup |
    Select-Object ResourceGroupName, Location |
    Sort-Object ResourceGroupName |
    Format-Table

Get-AzResourceGroup -Name '<resource-group>' | Format-List
```

## Find Resources

**Read-only**

```powershell
Get-AzResource -ResourceGroupName '<resource-group>' |
    Select-Object Name, ResourceType, Location, ResourceId |
    Sort-Object ResourceType, Name |
    Format-Table

Get-AzResource -ResourceId '<resource-id>' | Format-List
```

## Inspect Role Assignments

**Read-only:** Role-assignment output may reveal sensitive identity and access information.

```powershell
Get-AzRoleAssignment -Scope '<resource-id>' |
    Select-Object DisplayName, SignInName, RoleDefinitionName, Scope |
    Sort-Object RoleDefinitionName, DisplayName |
    Format-Table
```

Use the narrowest relevant scope. Do not create or remove role assignments without the approved access procedure.

## Inspect Existing Networking

**Read-only**

```powershell
$VNet = Get-AzVirtualNetwork `
    -ResourceGroupName '<resource-group>' `
    -Name '<vnet-name>'

$VNet | Select-Object Name, Location, ResourceGroupName, Id

Get-AzVirtualNetworkSubnetConfig `
    -VirtualNetwork $VNet `
    -Name '<subnet-name>' |
    Format-List

Get-AzPrivateEndpoint -ResourceGroupName '<resource-group>' |
    Select-Object Name, Location, ResourceGroupName, Id |
    Format-Table
```

The hub, ExpressRoute, routes, Palo Alto firewall, and Private DNS zones are existing shared dependencies. Do not change firewall rules or centrally managed Private DNS zones from this cheat sheet.

## Filter and Select Output

```powershell
Get-AzResource |
    Where-Object ResourceType -eq 'Microsoft.Storage/storageAccounts' |
    Select-Object Name, ResourceGroupName, Location |
    Sort-Object ResourceGroupName, Name |
    Format-Table
```

Use `Format-Table` and `Format-List` for display only. Keep objects unformatted when passing them to another command.

## Export Data Carefully

**Local change:** Inspect the selected properties before writing them to disk.

```powershell
Get-AzResource -ResourceGroupName '<resource-group>' |
    Select-Object Name, ResourceType, Location, ResourceId |
    Export-Csv -Path '<output-file>.csv' -NoTypeInformation

Get-AzResource -ResourceId '<resource-id>' |
    ConvertTo-Json -Depth 10 |
    Set-Content -Path '<output-file>.json'
```

Do not export secrets, tokens, access keys, connection strings, state, or unreviewed sensitive configuration.

## Safer Script Starting Point

```powershell
Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

try {
    $Context = Get-AzContext
    if ($null -eq $Context) {
        throw 'No Azure context is available.'
    }

    $Context | Format-List Account, Tenant, Subscription
}
catch {
    Write-Error $_
    exit 1
}
```

Strict mode and terminating errors reduce common scripting mistakes but do not replace validation, idempotency, or rollback design.

## Disconnect and Clear the Process Context

**Authentication context change**

```powershell
Disconnect-AzAccount
Clear-AzContext -Scope Process -Force
```

## Commands Requiring a Runbook

Direct cmdlets that create, update, delete, move, expose, or grant access to Azure resources are intentionally omitted. Do not assume `-WhatIf` is supported by every Az cmdlet or that a successful preview captures every dependency.

A runbook for a state-changing action must define the exact scope, required role and approval, expected impact, validation, rollback, security-baseline checks, evidence requirements, responsible team, and escalation path.

## Official References

- [Azure PowerShell documentation](https://learn.microsoft.com/powershell/azure/)
- [Sign in interactively with Azure PowerShell](https://learn.microsoft.com/powershell/azure/authenticate-interactive)
- [`Connect-AzAccount`](https://learn.microsoft.com/powershell/module/az.accounts/connect-azaccount)
- [`Get-AzContext`](https://learn.microsoft.com/powershell/module/az.accounts/get-azcontext)
- [`Set-AzContext`](https://learn.microsoft.com/powershell/module/az.accounts/set-azcontext)
- [`Get-AzResource`](https://learn.microsoft.com/powershell/module/az.resources/get-azresource)
- [`Get-AzRoleAssignment`](https://learn.microsoft.com/powershell/module/az.resources/get-azroleassignment)

[Command Cheat Sheets](README.md) | [Azure Identity and Access Requirements](../security/identity-and-access-requirements.md) | [Home](../Home.md)
