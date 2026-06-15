// API mínima de exemplo para o DevOps Lab.
// Expõe um health check e um endpoint que lê configuração do ambiente —
// o suficiente para demonstrar build de imagem, deploy no K8s e CI/CD.

using Prometheus;

var builder = WebApplication.CreateBuilder(args);
var app = builder.Build();

var env = Environment.GetEnvironmentVariable("APP_ENV") ?? "unknown";
var message = Environment.GetEnvironmentVariable("WELCOME_MESSAGE") ?? "Hello from API";

// Coleta métricas HTTP (latência, contagem, em voo) e expõe /metrics para o Prometheus.
app.UseHttpMetrics();
app.MapMetrics();   // -> GET /metrics

// Health check — usado pelas probes do Kubernetes (readiness/liveness).
app.MapGet("/health", () => Results.Ok(new { status = "healthy" }));

app.MapGet("/api", () => Results.Ok(new
{
    message,
    environment = env,
    hostname = Environment.MachineName,
    time = DateTimeOffset.UtcNow
}));

app.Run();
