output "application_url" {
  description = "Production application URL"
  value       = module.nginx.application_url
}

output "backend_url" {
  description = "Production backend URL"
  value       = module.backend.url
}

output "docker_network" {
  description = "Production Docker network"
  value       = module.network.network_name
}

output "postgres_container" {
  description = "Production PostgreSQL container"
  value       = module.database.container_name
}