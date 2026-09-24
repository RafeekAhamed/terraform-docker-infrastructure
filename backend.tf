module "backend" {
  source = "./modules/backend"

  db_host      = module.database.container_name
  db_name      = var.postgres_db
  db_user      = var.postgres_user
  db_password  = var.postgres_password
  network_name = module.network.network_name
}