module "database" {
  source = "./modules/database"

  postgres_db       = var.postgres_db
  postgres_user     = var.postgres_user
  postgres_password = var.postgres_password
  network_name      = module.network.network_name
}