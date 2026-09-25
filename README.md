# Terraform Docker Infrastructure

Production-style Infrastructure as Code (IaC) project using **Terraform and Docker** with reusable modules, isolated Dev/Prod environments, PostgreSQL, Flask, Nginx, and GitHub Actions CI validation.

## 🚀 Project Overview

This project demonstrates how Terraform can be used to provision and manage a multi-container application infrastructure locally using Docker.

### Key Features

- Reusable Terraform modules
- Separate Dev and Prod environments
- Docker network isolation
- Flask backend application
- PostgreSQL database
- Nginx reverse proxy
- Sensitive variable handling
- Terraform state protection
- GitHub Actions CI validation
- Infrastructure architecture documentation
- Zero cloud infrastructure cost

---

## 🏗️ Architecture

```text
                         GitHub Repository
                                │
                                ▼
                     GitHub Actions CI
                                │
                    Terraform Format / Validate
                                │
                                ▼
                         Terraform IaC
                                │
              ┌─────────────────┴─────────────────┐
              │                                   │
              ▼                                   ▼
        Development                         Production
        Environment                         Environment
              │                                   │
              ▼                                   ▼
    terraform-dev-network             terraform-prod-network
              │                                   │
       ┌──────┼──────┐                     ┌──────┼──────┐
       │      │      │                     │      │      │
       ▼      ▼      ▼                     ▼      ▼      ▼
     Nginx  Flask  PostgreSQL            Nginx  Flask  PostgreSQL
     :8081  :5001    :5432               :8082  :5002    :5432


### Request Flow

Browser
   │
   ▼
Nginx
   │
   ▼
Flask Backend
   │
   ▼
PostgreSQL


## 🧰 Tech Stack

| Technology     | Purpose                   |
| -------------- | ------------------------- |
| Terraform      | Infrastructure as Code    |
| Docker         | Container runtime         |
| Python / Flask | Backend API               |
| PostgreSQL     | Database                  |
| Nginx          | Reverse proxy             |
| Git            | Version control           |
| GitHub         | Source code repository    |
| GitHub Actions | CI validation             |
| PowerShell     | CLI / automation          |
| YAML           | CI pipeline configuration |


## 📁 Project Structure

terraform-docker-infrastructure/
│
├── .github/
│   └── workflows/
│       └── terraform-ci.yml
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
│   ├── backend/
│   ├── database/
│   ├── network/
│   └── nginx/
│
├── environments/
│   ├── dev/
│   └── prod/
│
├── docs/
│   └── architecture.md
│
├── .gitignore
├── README.md
└── versions.tf

## 🧩 Terraform Modules

### Network

Creates isolated Docker bridge networks for each environment.

### Database

Provisions PostgreSQL containers and configures database credentials.

### Backend

Builds and runs the Flask backend application and configures its PostgreSQL connection.

### Nginx

Runs Nginx as a reverse proxy in front of the Flask backend.

## 🌎 Environment Separation

### Development

- Network: `terraform-dev-network`
- Backend: `terraform-dev-backend`
- Backend Port: `5001`
- Nginx: `terraform-dev-nginx`
- Application: `http://localhost:8081`

### Production

- Network: `terraform-prod-network`
- Backend: `terraform-prod-backend`
- Backend Port: `5002`
- Nginx: `terraform-prod-nginx`
- Application: `http://localhost:8082`

Dev and Prod use separate Docker networks while sharing the same reusable Terraform modules.

## 🔐 Security and Secrets

Sensitive configuration is separated from Terraform source code.

The following files are excluded through `.gitignore`:

- `terraform.tfvars`
- `terraform.tfstate`
- `terraform.tfstate.backup`
- `.terraform/`

Safe example files are provided:

- `environments/dev/terraform.tfvars.example`
- `environments/prod/terraform.tfvars.example`

Sensitive Terraform variables are declared using:

```hcl
sensitive = true

Terraform state can contain sensitive values. Production implementations should use a secure remote backend with appropriate access controls and encryption.

---

## Getting Started

Add:

```markdown
# 🚀 Getting Started

## Prerequisites

- Docker Desktop
- Terraform >= 1.6
- Git
- PowerShell

Then commands:

terraform version
docker version
git --version


## Dev deployment

## Development Environment

### 1. Navigate to Dev

```powershell
cd environments/dev


## Create local variables

Copy-Item terraform.tfvars.example terraform.tfvars

Edit terraform.tfvars and configure your local PostgreSQL password.

## commands

```powershell

terraform init
terraform validate
terraform plan
terraform apply


---

## Testing

Add:

```markdown
## 🧪 Test Development Environment

Check containers:

```powershell
docker ps

## Application:

http://localhost:8081

## Backend:

http://localhost:5001

## Health endpoint:

http://localhost:8081/health

## Expected response:

## Json

{
  "status": "healthy",
  "database": "connected"
}


---------------------------------------------------------------------------------------------------------------------------------------------
## Prod deployment

Add:

```markdown
# 🚀 Production Environment

```powershell
cd environments/prod
Copy-Item terraform.tfvars.example terraform.tfvars
terraform init
terraform validate
terraform plan
terraform apply

## Application:

http://localhost:8082

## Backend:

http://localhost:5002

## Health endpoint:

http://localhost:8082/health


---------------------------------------------------------------------------------------------------------------------------------------------

## GitHub Actions

This is important for your **DevOps profile**.

Add:

```markdown
## 🔁 GitHub Actions CI

The project uses GitHub Actions to automatically validate Terraform configuration.

### CI Workflow

```text
Git Push / Pull Request
          │
          ▼
   GitHub Actions
          │
          ▼
 Terraform Format Check
          │
          ▼
     Terraform Init
          │
          ▼
   Terraform Validate
          │
          ▼
       CI Result

## Workflow:

.github/workflows/terraform-ci.yml

## The pipeline validates both:

* environments/dev
* environments/prod


---------------------------------------------------------------------------------------------------------------------------------------------

## Documentation

Add:

```markdown
## 📚 Documentation

Detailed architecture documentation is available in:

`docs/architecture.md`

It covers:

- High-level architecture
- Terraform module design
- Dev environment
- Prod environment
- Docker network isolation
- Request flow
- Infrastructure lifecycle
- CI validation

## 🎯 What This Project Demonstrates

- Infrastructure as Code
- Terraform
- Terraform modules
- Environment separation
- Docker
- Docker networking
- Flask
- PostgreSQL
- Nginx
- Terraform state management
- Secret handling
- Git and GitHub
- GitHub Actions
- CI validation
- DevOps automation
- Infrastructure documentation

## 🔮 Future Improvements

- Terraform remote state
- State locking
- Docker image version management
- Container health checks
- Terraform testing
- Trivy security scanning
- Terraform linting
- Prometheus and Grafana
- Azure deployment using Terraform

## 👨‍💻 Author

**Rafeek Ahamed M**

**DevOps Engineer | Azure Cloud Engineer**

### Focus Areas

Azure • Azure DevOps • Terraform • Docker • Kubernetes • CI/CD • Infrastructure as Code • Cloud Infrastructure • Release Management

GitHub:

https://github.com/RafeekAhamed