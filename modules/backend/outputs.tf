output "container_name" {
  description = "Backend container name"
  value       = docker_container.this.name
}

output "url" {
  description = "Backend API URL"
  value       = "http://localhost:${var.host_port}"
}