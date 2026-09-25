# Terraform Docker Infrastructure

Production-style **Infrastructure as Code (IaC)** project using **Terraform and Docker** to provision isolated Development and Production environments with reusable Terraform modules.

The project demonstrates environment separation, Docker networking, containerized application deployment, reverse proxy configuration, database connectivity, and Terraform-based infrastructure management.

---

## 🚀 Project Overview

This project provisions a multi-container application infrastructure locally using Terraform and Docker.

Each environment contains:

* Nginx reverse proxy
* Python / Flask backend
* PostgreSQL database
* Dedicated Docker network
* Environment-specific host port mappings

Dev and Prod environments are completely separated at the Docker network level.

### Key Features

* Infrastructure as Code using Terraform
* Reusable Terraform modules
* Separate Dev and Prod environments
* Docker network isolation
* Flask backend application
* PostgreSQL database
* Nginx reverse proxy
* Environment-specific configuration
* Terraform validation and planning
* Git-based infrastructure version control
* Local infrastructure with zero cloud infrastructure cost

---

## 🏗️ Architecture

```text
                         Terraform
                             │
                             ▼
                  Infrastructure as Code
                             │
              ┌──────────────┴──────────────┐
              │                             │
              ▼                             ▼
       Development                    Production
       Environment                    Environment
              │                             │
              ▼                             ▼
  terraform-dev-network        terraform-prod-network
              │                             │
       ┌──────┼──────┐               ┌──────┼──────┐
       │      │      │               │      │      │
       ▼      ▼      ▼               ▼      ▼      ▼
     Nginx  Backend  PostgreSQL     Nginx  Backend  PostgreSQL
     :8081  :5001    :5432         :8082  :5002    :5432
```

### Request Flow

```text
Client
  │
  ▼
Nginx
  │
  ▼
Flask Backend
  │
  ▼
PostgreSQL
```

Nginx acts as the reverse proxy and forwards application requests to the Flask backend.

The backend communicates with PostgreSQL internally through the environment-specific Docker network.

---

## 🔀 Environment Isolation

Development and Production use separate Docker bridge networks.

### Development

```text
Network: terraform-dev-network
Subnet:  172.20.0.0/16

Nginx      → localhost:8081
Backend    → localhost:5001
PostgreSQL → Internal only
```

### Production

```text
Network: terraform-prod-network
Subnet:  172.21.0.0/16

Nginx      → localhost:8082
Backend    → localhost:5002
PostgreSQL → Internal only
```

The separate Docker networks provide environment-level network isolation and prevent accidental direct communication between Dev and Prod containers.

---

## 🧰 Technology Stack

| Technology          | Purpose                                       |
| ------------------- | --------------------------------------------- |
| **Terraform**       | Infrastructure as Code                        |
| **Docker**          | Container runtime                             |
| **Docker Provider** | Terraform-to-Docker infrastructure management |
| **Nginx**           | Reverse proxy                                 |
| **Python / Flask**  | Backend application                           |
| **PostgreSQL**      | Relational database                           |
| **HCL**             | Terraform configuration                       |
| **Git**             | Version control                               |
| **GitHub**          | Source code hosting                           |
| **PowerShell**      | CLI and automation                            |

---

## 📁 Project Structure

```text
terraform-docker-infrastructure/
│
├── backend/
│   ├── app.py
│   ├── Dockerfile
│   └── requirements.txt
│
├── nginx/
│   ├── Dockerfile
│   └── nginx.conf
│
├── modules/
│   ├── network/
│   ├── backend/
│   ├── database/
│   └── nginx/
│
├── environments/
│   ├── dev/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   │
│   └── prod/
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
│
├── .gitignore
├── README.md
└── versions.tf
```

> Terraform state files and local Terraform working directories should remain excluded from source control through `.gitignore`.

---

# 🧩 Terraform Modules

## Network Module

Creates a dedicated Docker bridge network for each environment.

```text
Dev  → terraform-dev-network
Prod → terraform-prod-network
```

The module allows the environments to maintain independent network boundaries.

---

## Backend Module

Provisions the Python / Flask backend container.

The Flask application listens on port `5000` inside the Docker network.

Host mappings:

```text
Dev  → localhost:5001
Prod → localhost:5002
```

---

## Database Module

Provisions PostgreSQL 16 using the Alpine image.

PostgreSQL is accessible internally by the backend container and is not directly exposed to the host.

```text
Backend
   │
   ▼
PostgreSQL
```

---

## Nginx Module

Provisions the Nginx reverse-proxy container.

Host mappings:

```text
Dev  → localhost:8081
Prod → localhost:8082
```

Request flow:

```text
Client
  │
  ▼
Nginx
  │
  ▼
Flask Backend
```

---

# 🚀 Getting Started

## Prerequisites

Install the following tools:

* Docker Desktop
* Terraform
* Git
* PowerShell

Verify the installations:

```powershell
terraform version
docker version
git --version
```

---

# 🔵 Development Environment

Navigate to the Dev environment:

```powershell
cd environments/dev
```

Initialize Terraform:

```powershell
terraform init
```

Validate the configuration:

```powershell
terraform validate
```

Create an execution plan:

```powershell
terraform plan
```

Apply the infrastructure:

```powershell
terraform apply
```

---

# 🟢 Production Environment

Navigate to the Prod environment:

```powershell
cd environments/prod
```

Initialize Terraform:

```powershell
terraform init
```

Validate the configuration:

```powershell
terraform validate
```

Create an execution plan:

```powershell
terraform plan
```

Apply the infrastructure:

```powershell
terraform apply
```

---

# 🧪 Verification

## Check Running Containers

```powershell
docker ps
```

## Check Docker Networks

```powershell
docker network ls
```

## Test Development Application

```powershell
curl.exe -i http://localhost:8081
```

## Test Production Application

```powershell
curl.exe -i http://localhost:8082
```

## Test Development Backend

```powershell
curl.exe -i http://localhost:5001
```

## Test Production Backend

```powershell
curl.exe -i http://localhost:5002
```

Expected backend response:

```json
{
  "message": "Terraform Docker Backend is running"
}
```

---

# 🔍 Terraform Validation

Terraform configuration is validated using:

```powershell
terraform validate
```

A successful validation returns:

```text
Success! The configuration is valid.
```

Terraform plans can also be used to detect infrastructure drift and determine whether the deployed infrastructure matches the current Terraform configuration.

When the infrastructure is already synchronized with the configuration, Terraform reports:

```text
No changes. Your infrastructure matches the configuration.
```

---

# 🔐 Infrastructure and Security Considerations

This project demonstrates several infrastructure security principles:

* PostgreSQL is not directly exposed to the host.
* Dev and Prod use separate Docker networks.
* Terraform configuration is managed as code.
* Terraform state should not be committed to Git.
* Sensitive values should be supplied through variables or secure secret-management mechanisms.
* Production implementations should use a secure remote Terraform backend with appropriate access controls and encryption.

---

# 🎯 DevOps Concepts Demonstrated

This project demonstrates practical knowledge of:

* Infrastructure as Code
* Terraform
* Terraform providers
* Terraform modules
* HCL
* Environment separation
* Dev / Prod isolation
* Docker networking
* Containerized application deployment
* Nginx reverse proxy
* Flask application deployment
* PostgreSQL integration
* Terraform variables
* Terraform outputs
* Terraform state management
* Infrastructure validation
* Infrastructure drift detection
* Git-based infrastructure version control
* PowerShell automation

---

# 📈 Future Improvements

Potential extensions include:

* GitHub Actions CI/CD
* Terraform `fmt` validation
* Automated Terraform plan checks
* Remote Terraform state
* State locking
* Secret management
* Container image versioning
* Container health checks
* Trivy container security scanning
* Terraform linting
* Prometheus and Grafana monitoring
* Automated Dev/Prod deployment workflows
* Azure infrastructure migration using Terraform
* Azure Container Apps / AKS deployment
* Azure Container Registry integration

---

# 👨‍💻 Author

**Rafeek Ahamed M**

**DevOps Engineer | Azure Cloud Engineer**

GitHub: https://github.com/RafeekAhamed

LinkedIn: https://linkedin.com/in/rafeek-ahamed-devops
