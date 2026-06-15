<img width="100%" src="https://capsule-render.vercel.app/api?type=waving&color=0:326CE5,100:00D4FF&height=160&section=header&text=DevOps%20Lab&fontSize=48&fontColor=FFFFFF&fontAlignY=35&desc=Kubernetes%20%C2%B7%20Docker%20%C2%B7%20Infraestrutura%20como%20c%C3%B3digo&descSize=16&descAlignY=58&descColor=FFFFFF"/>

<p align="center">
  Laboratório prático de <b>DevOps e infraestrutura</b> — clusters, containers, orquestração e IaC,<br/>
  documentando o aprendizado feito 100% pelo terminal.
</p>

<p align="center">
  <img src="https://skillicons.dev/icons?i=kubernetes,docker,bash,git&perline=9" />
</p>

---

## 🧪 Áreas

| Área | Conteúdo | Stack |
|---|---|---|
| ☸️ [Kubernetes](./kubernetes) | Cluster local com Kind, Pods, Deployments, Services, CoreDNS e Kindnet | Kind · kubectl · Docker · YAML |

> 🌱 Repositório vivo — novas áreas de DevOps (CI/CD, Terraform, observabilidade) entram aqui conforme eu avanço.

---

## ☸️ Kubernetes — destaque

Jornada completa de **Kubernetes com Kind (Kubernetes in Docker)**: criação de cluster multi-nó, deploy de Nginx, rede interna (Kindnet/CoreDNS) e exposição de serviços — tudo como código.

```bash
# sobe um cluster local de 3 nós (1 control-plane + 2 workers)
kind create cluster --config kubernetes/config.yaml

# cria um pod e expõe
kubectl apply -f kubernetes/pod.yaml
kubectl get pods
```

📖 O passo a passo completo e os conceitos estão em **[`kubernetes/README.md`](./kubernetes/README.md)**.

---

<p align="center">
  <b>Feito por <a href="https://github.com/cardos0s">Julia Cardoso</a></b>
</p>
