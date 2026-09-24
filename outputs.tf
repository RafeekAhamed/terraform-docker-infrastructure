output "application_url" {
  description = "Application URL through Nginx"
  value       = "http://localhost:8080"
}

output "backend_url" {
  description = "Backend API URL"
  value       = "http://localhost:5000"
}

output "postgres_container" {
  description = "PostgreSQL container name"
  value       = docker_container.postgres.name
}

output "docker_network" {
  description = "Docker network used by the application"
  value       = docker_network.app_network.name
}