# ☸️ Kubernetes — Recursos Fundamentais

Os primitivos do Kubernetes, um por arquivo, com comentários explicando cada campo. Aplique no cluster Kind criado a partir de [`../config.yaml`](../config.yaml).

## Ordem sugerida

```bash
# 1. cria o namespace que isola tudo
kubectl apply -f namespace.yaml

# 2. config e secret (consumidos pelos pods)
kubectl apply -f configmap.yaml
kubectl apply -f secret.yaml

# 3. a aplicação e como expô-la
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml
kubectl apply -f ingress.yaml      # requer um ingress controller

# verifica
kubectl get all -n lab
```

## Cola de referência

| Recurso | Para quê serve |
|---|---|
| **Namespace** | Isola recursos logicamente (nomes, quotas, RBAC) |
| **Pod** | Menor unidade executável — 1+ containers que compartilham rede/storage |
| **Deployment** | Mantém N réplicas, faz rolling update e rollback |
| **Service** | Endereço estável + load balancing entre pods (ClusterIP/NodePort/LoadBalancer) |
| **ConfigMap** | Configuração não sensível (env/arquivos) sem rebuildar imagem |
| **Secret** | Dados sensíveis (base64 — proteja em produção!) |
| **Ingress** | Roteamento HTTP por host/path para Services |

## Comandos do dia a dia

```bash
kubectl get pods -n lab -w                  # acompanha pods em tempo real
kubectl describe deployment nginx -n lab    # detalha eventos/estado
kubectl logs -l app=nginx -n lab            # logs de todos os pods do app
kubectl scale deployment nginx --replicas=5 -n lab
kubectl rollout undo deployment nginx -n lab  # rollback do último update
kubectl delete -f .                         # remove tudo desta pasta
```

> ⚠️ O `secret.yaml` aqui tem valores **fictícios** só para demonstração. Nunca versione segredos reais.
