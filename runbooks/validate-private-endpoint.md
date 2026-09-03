# Runbook: Validate a Private Endpoint

**Status:** Draft, read-only runbook. Organization-specific review and testing are pending.

**Owner:** Not yet supplied.

**Last tested:** Not yet tested.

## Purpose

Validate DNS resolution, Azure provisioning state, endpoint approval, TCP reachability, and basic TLS behavior for an existing Private Endpoint without changing Azure or network configuration.

## When to Use This Runbook

Use this runbook after Private Endpoint deployment, after an approved related change, or when a client cannot reach a supported Azure service privately.

Do not use it to create an endpoint, alter central DNS, change routes or firewall rules, enable public access, or connect environments.

## Prerequisites

- An authorized diagnostic source in the same environment as the affected client
- The target environment: DEV, INT, CRT, or PRD
- Expected service FQDN, port, Private Endpoint name, resource group, and subscription
- Expected Private Endpoint address from an authoritative deployment output or resource record
- An authorized Microsoft Entra sign-in if Azure inspection is required

## Required Permissions

- Network access from the authorized diagnostic source to the target private address and port
- Read access to the Private Endpoint and related Azure activity when those checks are performed
- Access to centrally managed DNS data only when already granted

Use a designated administrative account and MFA when the required read scope is elevated. Do not request broader access merely to complete this runbook.

## Risk and Impact

The procedure uses DNS lookups, read-only Azure queries, and a non-mutating connection test. It should not change Azure resources or application data. A service request can still generate access logs, and command output can expose internal names and addresses; handle the evidence accordingly.

## Procedure

### 1. Record Scope and Expected Result

Record the environment, source, service FQDN, expected private address, port, Private Endpoint, test time, and reason for validation. Confirm that the source and endpoint belong to the same environment boundary.

### 2. Confirm Azure Context

```bash
az account show \
  --query '{Name:name, SubscriptionId:id, TenantId:tenantId}' \
  --output table
```

Stop if the subscription is not the intended subscription. Do not inspect or change another environment as a comparison shortcut.

### 3. Resolve the Service Name

Run from the authorized source:

```bash
nslookup '<service-fqdn>'
```

If available:

```bash
dig +short '<service-fqdn>'
```

The answer must match the expected Private Endpoint address. A private-looking address that does not match is a failed result.

### 4. Inspect Endpoint State

```bash
az network private-endpoint show \
  --resource-group '<private-endpoint-resource-group>' \
  --name '<private-endpoint-name>' \
  --query '{ProvisioningState:provisioningState, Connections:privateLinkServiceConnections[].privateLinkServiceConnectionState.status, CustomDns:customDnsConfigs[].{Fqdn:fqdn, Addresses:ipAddresses}}' \
  --output jsonc
```

Confirm successful provisioning and an approved connection. If the summarized connection collection is empty, inspect the resource's full read-only details because connection representation can differ by service.

### 5. Test the Required Port

**PowerShell:**

```powershell
Test-NetConnection -ComputerName '<service-fqdn>' -Port 443
```

**Bash for an HTTPS endpoint:**

```bash
curl --head --silent --show-error \
  --connect-timeout 10 \
  'https://<service-fqdn>/'
```

Do not disable certificate validation. An expected authorization response can demonstrate successful DNS, TCP, and TLS without requiring a privileged operation.

### 6. Record the Result

Record pass or fail for DNS, endpoint provisioning, endpoint approval, TCP, TLS, and the non-mutating service response. Sanitize logs and retain evidence according to the approved process, which remains to be documented.

## Validation

The runbook passes when:

- the correct environment and Azure context were used
- DNS returns the expected Private Endpoint address
- endpoint provisioning is successful
- the endpoint connection is approved
- the required port is reachable
- TLS validation succeeds where applicable
- the service returns the expected non-mutating response for the test identity
- no public-access or cross-environment path was used

## Expected Results

Successful validation provides evidence that the client can reach the intended service through the existing private path. It does not prove application authorization, all service subresources, every client path, or continuous availability.

## Rollback

No infrastructure rollback is required because the procedure is read-only. Remove any temporary local evidence according to data-handling requirements; do not delete shared logs or audit records.

## Troubleshooting

Use [Troubleshoot Private Connectivity](../troubleshooting/private-connectivity.md) when a check fails. Do not enable public access, edit central DNS, alter routing, or change Palo Alto rules from this runbook.

## Escalation

Provide the environment, source, FQDN, expected and observed addresses, port, endpoint state, UTC timestamp, sanitized error, impact, and recent-change reference. The support channel and escalation owner remain to be documented.

## References

- [Private Endpoints](../networking/private-endpoints.md)
- [Private DNS Zone Management](../networking/private-dns-zone-management.md)
- [Resource Security Baseline](../security/resource-security-baseline.md)
- [Microsoft: Troubleshoot private endpoint connectivity failures](https://learn.microsoft.com/troubleshoot/azure/private-link/troubleshoot-private-endpoint-connectivity-failure)

[Runbooks](README.md) | [Home](../Home.md)
