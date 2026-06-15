# 🏗️ Multi-tier App no Kubernetes

Deploy completo do `demo-app` — **frontend + API + banco** — no cluster, mostrando uma arquitetura de 3 camadas de verdade com os recursos do K8s trabalhando juntos.

## Arquitetura

```
                    Ingress (demo.local)
                    /              \
                   /                \ /api
              ┌─────────┐       ┌─────────┐
              │   web   │──────▶│   api   │
              │ (nginx) │       │ (.NET)  │
              │ 2 réplicas      │ 2 réplicas
              └─────────┘       └────┬────┘
                                     │
                                ┌────▼────┐
                                │   db    │  StatefulSet + PVC
                                │(postgres)│  (estado persistente)
                                └─────────┘
```

| Camada | Recurso K8s | Por quê |
|---|---|---|
| **web** | Deployment + Service (ClusterIP) | Stateless, escalável horizontalmente |
| **api** | Deployment + Service + ConfigMap + Secret | Stateless; config via ConfigMap, senha via Secret |
| **db** | StatefulSet + Service headless + PVC | Tem estado — precisa de identidade e disco estáveis |
| **borda** | Ingress | Roteia `/` → web e `/api` → api |

## Deploy

```bash
# pré-requisitos: cluster Kind + ingress-nginx instalado
kubectl apply -f k8s/namespace.yaml
kubectl apply -f k8s/                     # aplica todo o resto

kubectl get all -n demo-app
kubectl rollout status deployment/api -n demo-app

# acesse (após mapear demo.local no /etc/hosts)
curl http://demo.local/api
```

> 🖼️ As imagens (`ghcr.io/cardos0s/demo-app-*`) são construídas a partir de [`../docker`](../docker) e publicadas pelo pipeline em [`../.github/workflows`](../.github/workflows).

> 🔐 O `db-secret.yaml` tem valor **fictício**. Gere o real com `kubectl create secret` ou use Sealed Secrets/SOPS.

## Versão Helm
O mesmo app, parametrizado e empacotado, está em [`../helm/demo-app`](../helm/demo-app) — uma instalação no lugar de aplicar ~10 manifests à mão.
