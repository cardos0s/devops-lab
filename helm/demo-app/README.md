# ⎈ Helm Chart — demo-app

O mesmo app multi-tier de [`../../multi-tier-app`](../../multi-tier-app), agora **empacotado e parametrizado** com Helm. Em vez de aplicar ~10 manifests à mão, é uma instalação só — versionável, configurável por ambiente e com rollback nativo.

## Por que Helm
- **Parametrização** — imagem, tag, réplicas, host e recursos saem do `values.yaml` (sem editar manifests).
- **Releases versionadas** — `helm upgrade`/`helm rollback` controlam o histórico.
- **Templating** — labels e config repetidos vêm de helpers (`_helpers.tpl`), sem copiar-colar.

## Estrutura
```
demo-app/
├── Chart.yaml            # metadados (versão do chart e do app)
├── values.yaml          # valores padrão (sobrescrevíveis)
└── templates/
    ├── _helpers.tpl      # labels comuns
    ├── namespace.yaml
    ├── secret.yaml       # exige db.password no deploy
    ├── db.yaml           # StatefulSet + Service headless
    ├── api.yaml          # ConfigMap + Deployment + Service
    ├── web.yaml          # Deployment + Service
    └── ingress.yaml      # condicional (ingress.enabled)
```

## Uso

```bash
# valida e renderiza os templates sem aplicar
helm lint .
helm template demo . --set db.password=teste

# instala (a senha é obrigatória — gere uma forte)
helm install demo . --set db.password=$(openssl rand -base64 24)

# atualiza imagem/réplicas
helm upgrade demo . --set api.tag=v1.2.0 --set api.replicas=4

# rollback pra release anterior
helm rollback demo

# remove tudo
helm uninstall demo
```

> 🔐 A senha do banco **não** está no `values.yaml` — o template `secret.yaml` falha de propósito se ela não for passada no deploy, evitando subir com senha vazia ou hardcoded.
