output "application_url" {
  description = "Development application URL"
  value       = module.nginx.application_url
}

output "backend_url" {
  description = "Development backend URL"
  value       = module.backend.url
}

output "docker_network" {
  description = "Development Docker network"
  value       = module.network.network_name
}

output "postgres_container" {
  description = "Development PostgreSQL container"
  value       = module.database.container_name
}