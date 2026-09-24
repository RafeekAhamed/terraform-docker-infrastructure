module "network" {
  source = "../../modules/network"

  network_name = "terraform-dev-network"
}

module "database" {
  source = "../../modules/database"

  postgres_db       = var.postgres_db
  postgres_user     = var.postgres_user
  postgres_password = var.postgres_password
  network_name      = module.network.network_name
  container_name    = "terraform-dev-postgres"
}

module "backend" {
  source = "../../modules/backend"

  db_host      = module.database.container_name
  db_name      = var.postgres_db
  db_user      = var.postgres_user
  db_password  = var.postgres_password
  network_name = module.network.network_name

  container_name = "terraform-dev-backend"
  host_port      = 5001
}

module "nginx" {
  source = "../../modules/nginx"

  network_name   = module.network.network_name
  container_name = "terraform-dev-nginx"
  host_port      = 8081
}