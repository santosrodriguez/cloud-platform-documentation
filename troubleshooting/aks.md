# Troubleshoot Azure Kubernetes Service

**Status:** Draft diagnostic guidance. Commands are read-only unless explicitly identified, and the procedure has not been tested against an organization-specific cluster inventory.

**Audience:** Application and platform engineers diagnosing AKS nodes, workloads, services, or Application Gateway Ingress Controller behavior.

**Owner:** Not yet supplied.

## Problem

An AKS workload is unavailable, unscheduled, unhealthy, or unreachable through the documented Application Gateway ingress path.

## Customer-Safe and Privileged Checks

| Access level | Checks |
| --- | --- |
| Customer-safe | Reproduce a documented non-mutating application or health request through the intended environment path; record status, timestamp, correlation identifier, and impact. |
| Privileged operator | Inspect AKS metadata, node pools, Kubernetes objects, events, logs, `kube-system`, AGIC, or Application Gateway. Use only authorized Kubernetes access and the designated administrative account with MFA when elevated Azure access is required. |

Do not run `kubectl`, retrieve logs, or inspect platform metadata unless the current identity is authorized for that scope.

## Platform Expectations

- The system node pool is separate from the user node pool.
- Local accounts are disabled.
- Azure RBAC for Kubernetes Authorization is enabled.
- Application Gateway Ingress Controller (AGIC) is used for AKS ingress.
- Public access is disabled by default, and Private Endpoints should be used where supported and applicable.
- DEV, INT, CRT, and PRD are not cross-connected.

These are required or confirmed outcomes, not proof that a particular cluster is healthy or compliant.

## Symptom Guide

| Symptom | First checks |
| --- | --- |
| `kubectl` authentication or authorization failure | Azure identity, MFA, designated admin account when elevated, current context, Azure RBAC assignment |
| Pod remains `Pending` | Events, resource requests, node readiness, selectors, taints, tolerations, and user-pool capacity |
| Pod is restarting | Pod status, previous logs, probes, configuration, dependencies, and resource limits |
| Service has no endpoints | Pod readiness and Service selector-to-Pod label match |
| Application Gateway returns `502` or `504` | Pod readiness, Service endpoints, Ingress, AGIC logs, backend health, DNS, and network path |
| Only one environment fails | Environment-specific cluster, DNS, endpoint, route, policy, or dependency configuration |

## Step 1: Confirm Azure and Kubernetes Context

```bash
az account show \
  --query '{Name:name, SubscriptionId:id, TenantId:tenantId}' \
  --output table

kubectl config current-context
kubectl cluster-info
```

Use Microsoft Entra authentication and an authorized access path. Do not use `az aks get-credentials --admin`; local accounts are required to be disabled. The supported credential-acquisition and break-glass procedures remain to be documented.

Check whether the current identity can perform the needed read operation:

```bash
kubectl auth can-i get pods --namespace '<namespace>'
```

## Step 2: Check Cluster and Node Pools

```bash
az aks show \
  --resource-group '<aks-resource-group>' \
  --name '<aks-cluster-name>' \
  --query '{ProvisioningState:provisioningState, PowerState:powerState.code, KubernetesVersion:kubernetesVersion, DisableLocalAccounts:disableLocalAccounts, EnableAzureRbac:aadProfile.enableAzureRbac}' \
  --output table
```

```bash
az aks nodepool list \
  --resource-group '<aks-resource-group>' \
  --cluster-name '<aks-cluster-name>' \
  --query '[].{Name:name, Mode:mode, ProvisioningState:provisioningState, PowerState:powerState.code, Count:count, Version:orchestratorVersion}' \
  --output table
```

Expected architecture includes separate `System` and `User` modes. Pool names, counts, zones, autoscaling, labels, taints, and workload-placement rules remain environment-specific details to verify.

```bash
kubectl get nodes \
  -L kubernetes.azure.com/mode
```

## Step 3: Check Workload Health

```bash
kubectl get pods \
  --namespace '<namespace>' \
  --output wide

kubectl get events \
  --namespace '<namespace>' \
  --sort-by=.lastTimestamp
```

Narrow the investigation further to the affected workload:

```bash
kubectl describe pod '<pod-name>' \
  --namespace '<namespace>'

kubectl logs '<pod-name>' \
  --namespace '<namespace>' \
  --tail=200
```

For a restarting container, inspect the previous instance when available:

```bash
kubectl logs '<pod-name>' \
  --namespace '<namespace>' \
  --previous \
  --tail=200
```

Treat logs and events as potentially sensitive. Do not collect Kubernetes Secrets or paste tokens, connection strings, customer data, or full environment exports into an incident.

## Step 4: Check Service and Ingress Objects

```bash
kubectl get ingress,service,endpoints \
  --namespace '<namespace>' \
  --output wide

kubectl describe ingress '<ingress-name>' \
  --namespace '<namespace>'

kubectl describe service '<service-name>' \
  --namespace '<namespace>'
```

Confirm that the Service selector matches ready Pods and that the expected endpoint addresses are present.

Inspect AGIC without changing its deployment:

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

The installed AGIC labels may differ. If the selector returns nothing, inspect the cluster documentation or list `kube-system` workloads rather than assuming AGIC is absent.

## Step 5: Separate the Failure Domain

Determine the last successful layer:

1. AKS control-plane access
2. node and node-pool health
3. Pod scheduling and readiness
4. Service endpoint selection
5. Ingress and AGIC reconciliation
6. Application Gateway backend health
7. DNS, TLS, and upstream access path
8. application response

Do not restart, scale, drain, delete, redeploy, edit an Ingress, or change Application Gateway as a diagnostic shortcut without an approved procedure and impact assessment.

## Validation

After an approved correction, verify that nodes are ready, the workload reaches its desired replica count, Pods are ready, the Service has the expected endpoints, AGIC reconciles without relevant errors, Application Gateway reports healthy backends, and a non-mutating application check succeeds through the intended environment path.

## Escalation Package

Provide the environment, cluster, namespace, workload, start time, impact, sanitized error, current context name, node-pool summary, Pod status, relevant events, Service endpoints, Ingress description, AGIC error excerpt, correlation identifier, and recent-change reference. Exclude secrets and sensitive payloads.

The AKS, AGIC, Application Gateway, and application escalation owners remain to be documented.

## Official References

- [Microsoft: System and user node pools in AKS](https://learn.microsoft.com/azure/aks/use-system-pools)
- [Microsoft: Troubleshoot Application Gateway Ingress Controller](https://learn.microsoft.com/troubleshoot/azure/application-gateway/ingress-controller-troubleshoot)
- [Kubernetes: Debug running Pods](https://kubernetes.io/docs/tasks/debug/debug-application/debug-running-pod/)

[Troubleshooting](README.md) | [Azure Kubernetes Service](../platform-services/aks.md) | [Home](../Home.md)
