# 🏗️ Terraform — Infraestrutura como Código

Provisiona o cluster do lab **declarativamente** com Terraform, em vez de comandos imperativos. O mesmo cluster Kind do [`../kubernetes/config.yaml`](../kubernetes/config.yaml) — porém versionado, reprodutível e destruível com um comando, já com o **ingress-nginx** instalado.

## O que cria
- 🟦 **Cluster Kind** (1 control-plane + N workers) com mapeamento de portas 80/443 pro host
- 🌐 **ingress-nginx** via Helm (provider `helm`), pronto pros Ingress do lab

## Arquivos
| Arquivo | Papel |
|---|---|
| `versions.tf` | Versões de Terraform e providers (`kind`, `helm`) |
| `variables.tf` | Parâmetros (nome do cluster, nº de workers, instalar ingress?) |
| `main.tf` | Cluster + ingress controller |
| `outputs.tf` | kubeconfig, endpoint, nome do cluster |

## Uso

```bash
terraform init                 # baixa os providers
terraform plan                 # mostra o que será criado
terraform apply                # cria o cluster + ingress

# parametrizando
terraform apply -var="worker_count=3" -var="cluster_name=meu-lab"

terraform destroy              # remove tudo
```

## Conceitos demonstrados
- **IaC declarativa** — descreve o estado desejado, o Terraform reconcilia
- **Providers** compondo recursos (Kind cria o cluster, Helm instala apps nele)
- **Variáveis e `dynamic` blocks** — workers parametrizáveis
- **Outputs** — expõe dados do recurso pra outros usos
- **State** — o Terraform rastreia o que existe e calcula o diff

> 💡 Requer Docker rodando (o Kind sobe os nós como containers). O `.terraform/`, `*.tfstate` e `*.tfvars` ficam fora do git (ver `.gitignore`).
