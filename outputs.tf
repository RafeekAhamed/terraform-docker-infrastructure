output "application_url" {
  description = "Application URL through Nginx"
  value       = module.nginx.application_url
}

output "backend_url" {
  description = "Backend API URL"
  value       = module.backend.url
}

output "postgres_container" {
  description = "PostgreSQL container name"
  value       = module.database.container_name
}

output "docker_network" {
  description = "Docker network used by the application"
  value       = module.network.network_name
}