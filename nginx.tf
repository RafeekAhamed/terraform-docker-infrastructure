module "nginx" {
  source = "./modules/nginx"

  network_name = module.network.network_name
}