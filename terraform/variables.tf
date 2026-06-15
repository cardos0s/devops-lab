variable "cluster_name" {
  description = "Nome do cluster Kind"
  type        = string
  default     = "devops-lab"
}

variable "worker_count" {
  description = "Quantidade de nós worker"
  type        = number
  default     = 2
}

variable "install_ingress" {
  description = "Instalar o ingress-nginx controller via Helm"
  type        = bool
  default     = true
}
