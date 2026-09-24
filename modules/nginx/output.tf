output "application_url" {
  description = "Application URL through Nginx"
  value       = "http://localhost:${var.host_port}"
}

output "container_name" {
  description = "Nginx container name"
  value       = docker_container.this.name
}