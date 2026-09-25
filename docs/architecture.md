# Architecture

## High-Level Architecture

```text
                         Git / GitHub
                              |
                              v
                    +-------------------+
                    |    Terraform CI   |
                    |   GitHub Actions   |
                    +---------+---------+
                              |
                              v
                    +-------------------+
                    |      Terraform    |
                    |  Reusable Modules |
                    +---------+---------+
                              |
              +---------------+---------------+
              |                               |
              v                               v
       +-------------+                 +-------------+
       |     DEV     |                 |    PROD     |
       | Environment |                 | Environment |
       +------+------+                 +------+------+
              |                               |
              v                               v
   +---------------------+          +---------------------+
   | terraform-dev-      |          | terraform-prod-     |
   | network             |          | network             |
   +----------+----------+          +----------+----------+
              |                               |
       +------+------+                  +------+------+
       |      |      |                  |      |      |
       v      v      v                  v      v      v
    Nginx  Backend PostgreSQL        Nginx  Backend PostgreSQL
    :8081   :5001     :5432          :8082   :5002     :5432

                         Docker Networking
```

## Module Design

The Terraform configuration is divided into reusable modules:

```text
modules/
├── network/
│   └── Creates Docker bridge network
│
├── database/
│   └── Creates PostgreSQL container
│
├── backend/
│   └── Builds and runs Flask application
│
└── nginx/
    └── Builds and runs Nginx reverse proxy
```

## Development Environment

```text
Browser
   |
   | http://localhost:8081
   v
Nginx
terraform-dev-nginx
   |
   | Docker network
   v
Backend
terraform-dev-backend
   |
   | PostgreSQL connection
   v
Database
terraform-dev-postgres
```

## Production Environment

```text
Browser
   |
   | http://localhost:8082
   v
Nginx
terraform-prod-nginx
   |
   | Docker network
   v
Backend
terraform-prod-backend
   |
   | PostgreSQL connection
   v
Database
terraform-prod-postgres
```

## Network Isolation

Development and production use separate Docker networks:

```text
terraform-dev-network
       |
       +-- terraform-dev-nginx
       +-- terraform-dev-backend
       +-- terraform-dev-postgres
```

```text
terraform-prod-network
       |
       +-- terraform-prod-nginx
       +-- terraform-prod-backend
       +-- terraform-prod-postgres
```

This provides environment-level network isolation between Development and Production.

## Request Flow

A request to the Development application follows:

```text
Client
  |
  v
localhost:8081
  |
  v
Nginx :80
  |
  v
Backend :5000
  |
  v
PostgreSQL :5432
```

The Production request flow is equivalent, using `localhost:8082` for the Nginx entry point.

## Infrastructure Lifecycle

```text
Terraform Configuration
        |
        v
terraform init
        |
        v
terraform validate
        |
        v
terraform plan
        |
        v
terraform apply
        |
        v
Docker Infrastructure
```

## CI Validation

GitHub Actions validates the Terraform configuration on repository changes.

```text
Git Push / Pull Request
          |
          v
     GitHub Actions
          |
          +--> terraform fmt -check
          |
          +--> terraform init
          |
          +--> terraform validate
          |
          v
       CI Result
```

The CI workflow is intended to catch Terraform formatting and configuration validation issues before infrastructure changes are merged.
