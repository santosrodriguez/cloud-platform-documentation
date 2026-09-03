# Runbook: Triage an AKS Workload

**Status:** Draft, read-only runbook. Organization-specific review and testing are pending.

**Owner:** Not yet supplied.

**Last tested:** Not yet tested.

## Purpose

Collect consistent evidence for an unavailable or unhealthy Azure Kubernetes Service (AKS) workload and identify the last healthy layer without changing cluster or application state.

## When to Use This Runbook

Use when Pods are pending or restarting, a Service has no endpoints, an Ingress is not routing, or Application Gateway reports an unhealthy backend.

## Prerequisites

- Target environment, cluster, namespace, workload, and approximate failure start time
- Existing authorized Kubernetes context using Microsoft Entra authentication
- Expected replica count, Service, Ingress, hostname, and non-mutating health check when documented
- Incident or work record for production impact when required by the operating process

## Required Permissions

- Read access to the AKS resource and node-pool metadata
- Kubernetes authorization to read nodes, Pods, events, Services, endpoints, Ingresses, and logs permitted by the data-handling process

Local AKS accounts are disabled. Do not use admin credentials or bypass Azure RBAC. Use the designated administrative account and MFA when elevated read permissions are required.

## Risk and Impact

The commands are read-only. Log retrieval and API queries can add minor load and expose sensitive metadata. Limit scope, avoid repeated broad queries, and do not retrieve Secrets or sensitive payloads.

## Procedure

### 1. Confirm Context

```bash
az account show \
  --query '{Name:name, SubscriptionId:id, TenantId:tenantId}' \
  --output table

kubectl config current-context
kubectl auth can-i get pods --namespace '<namespace>'
```

Stop if the environment, subscription, cluster context, or permission scope is not the intended one.

### 2. Check Cluster and Node-Pool Health

```bash
az aks show \
  --resource-group '<aks-resource-group>' \
  --name '<aks-cluster-name>' \
  --query '{ProvisioningState:provisioningState, PowerState:powerState.code, DisableLocalAccounts:disableLocalAccounts, EnableAzureRbac:aadProfile.enableAzureRbac}' \
  --output table

az aks nodepool list \
  --resource-group '<aks-resource-group>' \
  --cluster-name '<aks-cluster-name>' \
  --query '[].{Name:name, Mode:mode, ProvisioningState:provisioningState, PowerState:powerState.code, Count:count}' \
  --output table

kubectl get nodes \
  -L kubernetes.azure.com/mode
```

Confirm that the documented separate system and user pools are visible and that relevant nodes are ready. Do not scale, start, upgrade, cordon, drain, or delete nodes from this runbook.

### 3. Inspect Workload State

```bash
kubectl get pods \
  --namespace '<namespace>' \
  --output wide

kubectl describe pod '<pod-name>' \
  --namespace '<namespace>'

kubectl get events \
  --namespace '<namespace>' \
  --sort-by=.lastTimestamp
```

Identify scheduling failures, image errors, probe failures, resource pressure, restarts, and dependency errors.

### 4. Inspect Sanitized Logs

```bash
kubectl logs '<pod-name>' \
  --namespace '<namespace>' \
  --tail=200
```

For a restarted container:

```bash
kubectl logs '<pod-name>' \
  --namespace '<namespace>' \
  --previous \
  --tail=200
```

Do not attach raw logs until secrets, tokens, connection strings, customer data, and sensitive environment details have been removed.

### 5. Inspect Service and Ingress

```bash
kubectl get service,endpoints,ingress \
  --namespace '<namespace>' \
  --output wide

kubectl describe service '<service-name>' \
  --namespace '<namespace>'

kubectl describe ingress '<ingress-name>' \
  --namespace '<namespace>'
```

Confirm that ready Pods match the Service selector and appear as endpoints.

### 6. Inspect AGIC Evidence

```bash
kubectl get pods \
  --namespace kube-system \
  --selector app=ingress-appgw \
  --output wide

kubectl logs \
  --namespace kube-system \
  --selector app=ingress-appgw \
  --tail=200
```

If the selector returns no objects, confirm the installed AGIC labels before collecting broader `kube-system` output.

### 7. Identify the Last Healthy Layer

Classify the failure as cluster access, node pool, scheduling, container, Service selection, Ingress or AGIC, Application Gateway, private connectivity, or application behavior. Record evidence and stop without making a corrective change.

## Validation

This triage runbook is complete when the context is confirmed, system and user node pools are visible, affected workload state and events are captured, Service endpoints and Ingress are checked, AGIC evidence is collected when relevant, and the last healthy layer is identified.

## Expected Results

The result is a bounded failure domain and a sanitized evidence package, not an automatic remediation.

## Rollback

No infrastructure rollback is required because the procedure is read-only. Remove any temporary local log copies according to the approved data-handling process.

## Troubleshooting

Use [Troubleshoot Azure Kubernetes Service](../troubleshooting/aks.md) for interpretation. Do not restart or delete Pods, scale workloads or pools, edit Kubernetes objects, or change Application Gateway without an approved change procedure.

## Escalation

Provide the environment, cluster, namespace, workload, impact, failure start, current context, node-pool summary, Pod status, relevant events, sanitized logs, Service endpoints, Ingress and AGIC evidence, and recent-change reference. Service ownership and escalation paths remain to be documented.

## References

- [Azure Kubernetes Service](../platform-services/aks.md)
- [Application Ingress](../platform-services/application-ingress.md)
- [Microsoft: Troubleshoot Application Gateway Ingress Controller](https://learn.microsoft.com/troubleshoot/azure/application-gateway/ingress-controller-troubleshoot)

[Runbooks](README.md) | [Home](../Home.md)
