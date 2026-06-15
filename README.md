<img width="100%" src="https://capsule-render.vercel.app/api?type=waving&color=0:326CE5,100:00D4FF&height=160&section=header&text=DevOps%20Lab&fontSize=48&fontColor=FFFFFF&fontAlignY=35&desc=Kubernetes%20%C2%B7%20Docker%20%C2%B7%20Helm%20%C2%B7%20CI%2FCD%20%C2%B7%20IaC&descSize=16&descAlignY=58&descColor=FFFFFF"/>

<p align="center">
  Laboratório prático de <b>DevOps e infraestrutura</b> — do container ao deploy contínuo,<br/>
  tudo girando em torno de um app de exemplo real (<code>demo-app</code>: web + API + banco).
</p>

<p align="center">
  <img src="https://skillicons.dev/icons?i=kubernetes,docker,dotnet,githubactions,bash,git&perline=9" />
</p>

---

## 🧭 Trilha — do código ao cluster

O mesmo `demo-app` (frontend nginx + API .NET + Postgres) atravessa todas as seções, mostrando o ciclo de vida completo:

```
   docker/  ──build──▶  imagens  ──push──▶  GHCR
      │                                       │
      │                              .github/workflows (CI/CD)
      ▼                                       ▼
 docker-compose                       multi-tier-app/  ◀──equivale──▶  helm/
   (local)                              (manifests K8s)              (mesmo app, parametrizado)
```

## 📂 Seções

| Seção | O que tem | Stack |
|---|---|---|
| ☸️ [**kubernetes/**](./kubernetes) | Cluster Kind + [recursos fundamentais](./kubernetes/basics) (Pod, Deployment, Service, ConfigMap, Secret, Ingress) documentados | Kind · kubectl · YAML |
| 🐳 [**docker/**](./docker) | Imagens multi-stage (API .NET + web nginx) + stack local | Docker · Compose |
| 🏗️ [**multi-tier-app/**](./multi-tier-app) | O `demo-app` completo no cluster (3 camadas, StatefulSet, Ingress, **HPA**) | Kubernetes |
| ⎈ [**helm/**](./helm/demo-app) | O mesmo app empacotado e parametrizável (com HPA) | Helm |
| 🔄 [**.github/workflows/**](./.github/workflows) | Pipeline build → test → imagens → deploy | GitHub Actions · GHCR |
| 🟦 [**terraform/**](./terraform) | Provisiona o cluster + ingress como código (IaC) | Terraform |
| 📊 [**monitoring/**](./monitoring) | Prometheus + Grafana + alertas + dashboard | kube-prometheus-stack |

---

## 🚀 Começando

```bash
# 1. cluster local de 3 nós
kind create cluster --config kubernetes/config.yaml

# 2. fundamentos do K8s
kubectl apply -f kubernetes/basics/

# 3. app completo (ou via Helm)
kubectl apply -f multi-tier-app/k8s/
# helm install demo helm/demo-app --set db.password=$(openssl rand -base64 24)
```

## 💡 Conceitos cobertos
Containerização e build multi-stage · orquestração (Pods, Deployments, StatefulSets) · rede e service discovery (Service, Ingress, CoreDNS) · configuração e segredos · armazenamento persistente (PVC) · **autoescalonamento (HPA)** · empacotamento com Helm · entrega contínua (CI/CD) · **infraestrutura como código (Terraform)** · **observabilidade (Prometheus + Grafana)**.

> 🔐 Todos os Secrets neste repositório usam valores **fictícios/placeholders**. Senhas reais são injetadas em deploy (env, `--set`, ou um cofre).

---

<p align="center">
  <b>Feito por <a href="https://github.com/cardos0s">Julia Cardoso</a></b>
</p>
