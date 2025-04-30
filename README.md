# Port Service (Dockerized & Kubernetes-ready)

A simple microservice exposing port-based service info. Ready for use via Docker Compose and Minikube (Kubernetes).

---
## 🚀 Run via Docker Compose
```bash
bash: make dc
Or manually: docker-compose up --build```

## ☸️ Run Locally via Kubernetes (Minikube)
0. Optional if you have no image
make dck8s
1. Start Minikube
minikube start --driver=docker --cpus=2 --memory=2985m --disk-size=5g

2. Load your Docker image into Minikube
docker images | grep port-service
    port-service              latest    99aaffeefde0   47 minutes ago   17.5MB
minikube status
docker build -t port-service:latest .
minikube image load port-service:latest

3. Apply Kubernetes configs

kubectl config use-context minikube  # (if not already)
kubectl apply -f k8s/deployment.yaml
minikube service go-app
    |-----------|--------|-------------|---------------------------|
    | NAMESPACE |  NAME  | TARGET PORT |            URL            |
    |-----------|--------|-------------|---------------------------|
    | default   | go-app |          80 | http://192.168.49.2:30080 |
    |-----------|--------|-------------|---------------------------|
    🏃  Starting tunnel for service go-app.
    |-----------|--------|-------------|------------------------|
    | NAMESPACE |  NAME  | TARGET PORT |          URL           |
    |-----------|--------|-------------|------------------------|
    | default   | go-app |             | http://127.0.0.1:64080 |
    |-----------|--------|-------------|------------------------|
    🎉  Opening service default/go-app in default browser...
    ❗  Because you are using a Docker driver on darwin, the terminal needs to be open to run it.
    ^C✋  Stopping tunnel for service go-app.

## 🛠️ Useful Commands
kubectl get deployments
kubectl get pods
kubectl get services
kubectl config current-context
kubectl config get-contexts

Stop cluster
minikube stop

# Debug inside Minikube
minikube ssh
docker images | grep port-service

📂 Project Structure
Dockerfile – builds the Go-based service
docker-compose.yml – local multi-container setup
k8s/deployment.yaml – Kubernetes Deployment + Service

tree
.
├── Dockerfile
├── LICENSE
├── Makefile
├── README.md
├── app
├── cmd
│   └── port-service
│       └── main.go
├── docker-compose.yml
├── go.mod
├── go.sum
├── internal
│   ├── common
│   │   ├── errors
│   │   │   └── errors.go
│   │   └── server
│   │       ├── http_error.go
│   │       └── http_ok.go
│   ├── config
│   │   └── config.go
│   ├── domain
│   │   ├── errors.go
│   │   ├── port.go
│   │   └── port_test.go
│   ├── repository
│   │   └── inmem
│   │       ├── port.go
│   │       ├── port_store_inmem.go
│   │       ├── port_store_inmem_test.go
│   │       └── port_test.go
│   ├── services
│   │   └── service.go
│   └── transport
│       ├── http.go
│       ├── http_e2e_test.go
│       ├── model.go
│       ├── testfixtures
│       │   ├── ports_request.json
│       │   └── ports_response.json
│       └── utils.go
├── k8s
│   └── deployment.yaml
└── ports.json

15 directories, 29 files
