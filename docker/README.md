# 🐳 Docker

Imagens do `demo-app` e o stack local via Docker Compose. Estas mesmas imagens são deployadas no Kubernetes ([`../multi-tier-app`](../multi-tier-app)) e empacotadas no Helm ([`../helm`](../helm)).

## Componentes

| Pasta | Imagem | Base | Técnica |
|---|---|---|---|
| [`api/`](./api) | API .NET (minimal API) | `dotnet/aspnet:9.0` | **Build multi-stage** (SDK → runtime enxuto), usuário não-root |
| [`web/`](./web) | Frontend nginx | `nginx:1.27-alpine` | Estático + proxy reverso para a API |

## Rodando o stack completo
```bash
# da pasta docker/
DB_PASSWORD=umaSenhaForte docker compose up --build

# acesse:
#   http://localhost:8000       -> frontend
#   http://localhost:8000/api   -> API via proxy do nginx
```

## Buildando as imagens individualmente
```bash
docker build -t demo-app-api ./api
docker build -t demo-app-web ./web

docker run -p 8080:8080 -e APP_ENV=local demo-app-api
```

## Boas práticas aplicadas aqui
- **Multi-stage build** — a imagem final não carrega o SDK nem o código-fonte (menor e mais segura).
- **Cache de layers** — copiar o `.csproj` e fazer `restore` antes do resto aproveita o cache quando só o código muda.
- **Usuário não-root** — o container roda sem privilégios de root.
- **Imagens `alpine`/slim** — superfície de ataque e tamanho menores.
- **Segredos por variável de ambiente** — nada de senha hardcoded (`${DB_PASSWORD}`).
- **Healthcheck** — o compose espera o Postgres ficar pronto antes de subir a API.
