output "cluster_name" {
  description = "Nome do cluster criado"
  value       = kind_cluster.this.name
}

output "kubeconfig_path" {
  description = "Caminho do kubeconfig gerado"
  value       = kind_cluster.this.kubeconfig_path
}

output "endpoint" {
  description = "Endpoint da API do cluster"
  value       = kind_cluster.this.endpoint
}
