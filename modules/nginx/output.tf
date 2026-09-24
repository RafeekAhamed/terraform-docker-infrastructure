output "application_url" {
  description = "Application URL through Nginx"
  value       = "http://localhost:8080"
}

output "container_name" {
  description = "Nginx container name"
  value       = docker_container.this.name
}