# 📊 Monitoramento — Prometheus + Grafana

Observabilidade do cluster e do `demo-app` usando o **kube-prometheus-stack** (Prometheus + Grafana + Alertmanager + exporters), instalado via Helm.

## Instalação

```bash
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update

helm install monitoring prometheus-community/kube-prometheus-stack \
  --namespace monitoring --create-namespace \
  -f values.yaml

# scrape da API + regras de alerta do lab
kubectl apply -f servicemonitor.yaml
kubectl apply -f prometheus-rule.yaml
kubectl apply -f grafana-dashboard.yaml
```

## Acessando

```bash
# Grafana (user padrão: admin / senha no values.yaml)
kubectl port-forward -n monitoring svc/monitoring-grafana 3000:80
# http://localhost:3000

# Prometheus
kubectl port-forward -n monitoring svc/monitoring-kube-prometheus-prometheus 9090:9090
# http://localhost:9090
```

## O que está configurado

| Arquivo | Papel |
|---|---|
| `values.yaml` | Customiza o stack (retenção, recursos, senha do Grafana, sidecar de dashboards) |
| `servicemonitor.yaml` | Diz ao Prometheus para coletar `/metrics` da API (`demo-app`) |
| `prometheus-rule.yaml` | Alertas: API fora do ar e alta latência |
| `grafana-dashboard.yaml` | Dashboard do demo-app, auto-carregado pelo sidecar do Grafana |

## Pré-requisito na aplicação
A API expõe métricas Prometheus em `/metrics` via **prometheus-net** (ver [`../docker/api/Program.cs`](../docker/api/Program.cs)). O `ServiceMonitor` casa com o label `app: api` e coleta na porta 8080.

## Conceitos demonstrados
- **Pull-based monitoring** — o Prometheus raspa `/metrics` dos targets
- **ServiceMonitor** — descoberta de targets via CRD do Operator
- **Alerting** — `PrometheusRule` dispara alertas por expressão PromQL
- **Dashboards como código** — JSON versionado, carregado automaticamente
- **Os 4 sinais de ouro** — latência, tráfego, erros e saturação
