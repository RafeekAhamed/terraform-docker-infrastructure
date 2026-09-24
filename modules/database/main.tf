resource "docker_image" "this" {
  name = "postgres:16-alpine"
}

resource "docker_container" "this" {
  name  = var.container_name
  image = docker_image.this.image_id

  env = [
    "POSTGRES_DB=${var.postgres_db}",
    "POSTGRES_USER=${var.postgres_user}",
    "POSTGRES_PASSWORD=${var.postgres_password}"
  ]

  networks_advanced {
    name = var.network_name
  }
}