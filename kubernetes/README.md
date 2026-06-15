# ☸️ Kubernetes DevOps Lab — Kind + Nginx + GitHub 🧠

Este repositório documenta toda a minha jornada prática de **DevOps com Kubernetes**, incluindo desde a criação de clusters locais com **Kind (Kubernetes in Docker)** até o deploy de aplicações reais, rede, DNS interno e versionamento com GitHub — tudo **feito 100% pelo terminal** ⚡

---

## 🧩 Visão Geral

- **Cluster:** Kind (rodando localmente via Docker)
- **Gerenciador:** kubectl
- **CNI:** Kindnet
- **DNS interno:** CoreDNS
- **Aplicação:** Nginx
- **Service:** NodePort / Port-Forward
- **Infraestrutura como código:** YAML
- **Versionamento:** Git + GitHub CLI (gh)

---

## 🧠 Conceitos que aprendi

### 🐳 Docker
- Entendi que o Docker é o **ambiente de contêinerização** usado como base para o Kind.
- Ele cria os “nós” do cluster Kubernetes como containers.
- Gerencia imagens e isolamento de processos.

### ☸️ Kubernetes
- O Kubernetes é o **orquestrador de containers**.
- Ele gerencia pods, faz escalonamento automático, monitora falhas e garante disponibilidade contínua.

### ⚙️ Kind (Kubernetes in Docker)
- Kind cria clusters Kubernetes **dentro do Docker**, ideal para testes locais.
- Permite múltiplos nós (control-plane + workers) via um simples `config.yaml`.

**Exemplo de cluster:**
```yaml
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
  - role: control-plane
  - role: worker
  - role: worker
```
### 🧩 Pod

**🧠 Conceito:**  
A menor unidade executável do Kubernetes.

**📘 Aprendizado:**  
Um **Pod** pode conter **um ou mais containers**.  
Criei pods individuais para testes iniciais.

```bash
kubectl apply -f pod.yaml
kubectl get pods
```
### 🚀 Deployment

**🧠 Conceito:**  
O cérebro que gerencia os pods e garante replicação e alta disponibilidade.

**⚙️ Implementação:**

```bash
kubectl create deployment nginx --image=nginx:latest --replicas=3
```

### 🔍 Mecanismo:
O Deployment cria um ReplicaSet, que, por sua vez, cria e mantém os Pods no estado desejado.
Durante os testes, aprendi a:

Atualizar imagens

Escalonar réplicas

Aplicar rolling updates (atualizações contínuas sem downtime)

### 🌐 Service

🧠 Conceito:
A ponte entre o mundo externo e os pods.

⚙️ Implementação:
Usei o tipo NodePort para expor a aplicação.

```bash
kubectl expose deployment nginx --port=80 --target-port=80 --type=NodePort
```
### 🌐 CoreDNS

**🧠 Conceito:**  
O servidor **DNS interno** do Kubernetes.

**📡 Função:**  
O **CoreDNS** traduz nomes de serviços em IPs internos (`cluster.local`), permitindo que os **pods** se comuniquem sem depender de IPs fixos.  
Ele é fundamental para que a comunicação entre serviços dentro do cluster aconteça de forma automática e dinâmica.

**🧩 Exemplo prático:**
- Um pod pode se comunicar com outro usando o nome do serviço, como:  
http://nginx.default.svc.cluster.local/
em vez de usar um IP estático.

---

### 🔌 Kindnet

**🧠 Conceito:**  
O **Kindnet** é o **plugin de rede (CNI)** padrão utilizado pelo Kind.

**📡 Função:**  
Ele cria e mantém toda a rede de comunicação entre os **pods** e **nós** do cluster.  
É responsável por garantir:
- **Roteamento interno** entre pods  
- **Isolamento de rede**  
- **Entrega de pacotes** entre containers e nós do cluster  

**⚙️ Observação:**  
Ao criar o cluster com o Kind, o Kindnet é instalado automaticamente — você pode visualizá-lo executando:

```bash
kubectl get pods -n kube-system

NAME                     READY   STATUS    RESTARTS   AGE
kindnet-abc123           1/1     Running   0          3m
```

###💬 Conclusão

“Dominar Kubernetes é entender como aplicações vivem, se comunicam e se curam sozinhas.
O poder do DevOps está em automatizar, versionar e manter tudo sob controle.” 💜


