\# Terraform Docker Infrastructure



Infrastructure-as-Code project using \*\*Terraform\*\* and \*\*Docker\*\* to provision isolated Dev and Prod application environments with reusable Terraform modules.



\## Architecture



The project provisions two independent environments:



\* \*\*Dev Environment\*\*



&#x20; \* Nginx → Backend → PostgreSQL

&#x20; \* Network: `terraform-dev-network`

&#x20; \* Backend: `localhost:5001`

&#x20; \* Nginx: `localhost:8081`



\* \*\*Prod Environment\*\*



&#x20; \* Nginx → Backend → PostgreSQL

&#x20; \* Network: `terraform-prod-network`

&#x20; \* Backend: `localhost:5002`

&#x20; \* Nginx: `localhost:8082`



Each environment uses its own Docker network to provide environment-level isolation.



\## Technologies



\* Terraform

\* Docker

\* Docker Provider

\* Nginx

\* Python / Flask

\* PostgreSQL

\* HCL

\* Git / GitHub

\* PowerShell



\## Project Structure



```text

terraform-docker-infrastructure/

│

├── environments/

│   ├── dev/

│   │   ├── main.tf

│   │   ├── variables.tf

│   │   ├── outputs.tf

│   │   └── terraform.tfstate

│   │

│   └── prod/

│       ├── main.tf

│       ├── variables.tf

│       ├── outputs.tf

│       └── terraform.tfstate

│

├── modules/

│   ├── network/

│   ├── backend/

│   ├── database/

│   └── nginx/

│

└── README.md

```



\## Terraform Modules



\### Network



Creates an isolated Docker bridge network for each environment.



```text

Dev  → terraform-dev-network

Prod → terraform-prod-network

```



\### Backend



Provisions the Python/Flask backend container and exposes the application on port `5000` inside the Docker network.



Host mappings:



```text

Dev  → localhost:5001

Prod → localhost:5002

```



\### Database



Provisions PostgreSQL 16 using the Alpine image.



PostgreSQL is accessible internally by the backend container and is not directly exposed to the host.



\### Nginx



Provisions the Nginx reverse-proxy container.



Host mappings:



```text

Dev  → localhost:8081

Prod → localhost:8082

```



\## Environment Isolation



Dev and Prod use separate Docker networks:



```text

terraform-dev-network

172.20.0.0/16



terraform-prod-network

172.21.0.0/16

```



This prevents accidental network-level communication between the two environments.



Example:



```text

DEV

Nginx

&#x20; │

&#x20; ▼

Backend

&#x20; │

&#x20; ▼

PostgreSQL



Network: terraform-dev-network





PROD

Nginx

&#x20; │

&#x20; ▼

Backend

&#x20; │

&#x20; ▼

PostgreSQL



Network: terraform-prod-network

```



\## Deployment



\### Dev



```powershell

cd environments/dev



terraform init

terraform validate

terraform plan

terraform apply

```



\### Prod



```powershell

cd environments/prod



terraform init

terraform validate

terraform plan

terraform apply

```



\## Verification



Check running containers:



```powershell

docker ps

```



Check Docker networks:



```powershell

docker network ls

```



Check Dev application:



```powershell

curl.exe -i http://localhost:8081

```



Check Prod application:



```powershell

curl.exe -i http://localhost:8082

```



Direct backend verification:



```powershell

curl.exe -i http://localhost:5001

curl.exe -i http://localhost:5002

```



Expected response:



```json

{

&#x20; "message": "Terraform Docker Backend is running"

}

```



\## Terraform Validation



Both environments have been validated using:



```powershell

terraform validate

```



Terraform plan verification:



```text

No changes. Your infrastructure matches the configuration.

```



This confirms that the deployed Docker infrastructure matches the Terraform configuration.



\## Key DevOps Concepts Demonstrated



\* Infrastructure as Code with Terraform

\* Reusable Terraform modules

\* Environment separation

\* Dev/Prod infrastructure isolation

\* Docker networking

\* Containerized application deployment

\* Reverse proxy with Nginx

\* Backend and database connectivity

\* Terraform state management

\* Infrastructure validation with `terraform validate`

\* Infrastructure drift detection with `terraform plan`

\* Git-based infrastructure version control



\## Future Improvements



Potential extensions to this project include:



\* GitHub Actions CI/CD

\* Terraform formatting and validation checks

\* Remote Terraform state

\* Terraform variables and environment-specific configuration

\* Secrets management

\* Container image versioning

\* Automated deployment workflows

\* Azure-based infrastructure migration



\## Author



\*\*Rafeek Ahamed M\*\*



DevOps Engineer | Azure Cloud Engineer



GitHub: https://github.com/RafeekAhamed

LinkedIn: https://linkedin.com/in/rafeek-ahamed-devops



