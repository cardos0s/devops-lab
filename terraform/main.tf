# Provisiona, como código, o mesmo cluster que o kubernetes/config.yaml cria —
# só que reprodutível, versionável e destruível com um comando.

resource "kind_cluster" "this" {
  name           = var.cluster_name
  wait_for_ready = true

  kind_config {
    kind        = "Cluster"
    api_version = "kind.x-k8s.io/v1alpha4"

    # control-plane com mapeamento de portas para o ingress chegar do host
    node {
      role = "control-plane"

      kubeadm_config_patches = [
        "kind: InitConfiguration\nnodeRegistration:\n  kubeletExtraArgs:\n    node-labels: \"ingress-ready=true\"\n"
      ]

      extra_port_mappings {
        container_port = 80
        host_port      = 80
      }
      extra_port_mappings {
        container_port = 443
        host_port      = 443
      }
    }

    # workers (quantidade parametrizável)
    dynamic "node" {
      for_each = range(var.worker_count)
      content {
        role = "worker"
      }
    }
  }
}

# Provider Helm aponta para o kubeconfig gerado pelo cluster acima
provider "helm" {
  kubernetes {
    host                   = kind_cluster.this.endpoint
    client_certificate     = kind_cluster.this.client_certificate
    client_key             = kind_cluster.this.client_key
    cluster_ca_certificate = kind_cluster.this.cluster_ca_certificate
  }
}

# Ingress controller — necessário para os Ingress do lab funcionarem
resource "helm_release" "ingress_nginx" {
  count = var.install_ingress ? 1 : 0

  name             = "ingress-nginx"
  repository       = "https://kubernetes.github.io/ingress-nginx"
  chart            = "ingress-nginx"
  namespace        = "ingress-nginx"
  create_namespace = true

  # ajustes para rodar no Kind (hostPort + nodeSelector ingress-ready)
  set {
    name  = "controller.hostPort.enabled"
    value = "true"
  }
  set {
    name  = "controller.service.type"
    value = "NodePort"
  }
  set {
    name  = "controller.nodeSelector.ingress-ready"
    value = "true"
  }

  depends_on = [kind_cluster.this]
}
