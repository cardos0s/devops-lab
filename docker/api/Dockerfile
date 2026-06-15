# Multi-stage build — compila num SDK pesado e roda numa imagem runtime enxuta.
# Resultado: imagem final pequena, sem o SDK nem o código-fonte.

# ---- stage 1: build ----
FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /src

# Copia só o csproj primeiro para aproveitar o cache de restore
COPY api.csproj .
RUN dotnet restore

# Agora o resto do código e publica
COPY . .
RUN dotnet publish -c Release -o /app --no-restore

# ---- stage 2: runtime ----
FROM mcr.microsoft.com/dotnet/aspnet:9.0 AS final
WORKDIR /app
COPY --from=build /app .

# Roda como usuário não-root (boa prática de segurança)
USER $APP_UID

ENV ASPNETCORE_HTTP_PORTS=8080
EXPOSE 8080
ENTRYPOINT ["dotnet", "api.dll"]
