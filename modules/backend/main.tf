resource "docker_image" "this" {
  name = "terraform-backend:latest"

  build {
    context    = "${path.root}/backend"
    dockerfile = "Dockerfile"
  }
}

resource "docker_container" "this" {
  name  = "terraform-backend"
  image = docker_image.this.image_id

  env = [
    "DB_HOST=${var.db_host}",
    "DB_NAME=${var.db_name}",
    "DB_USER=${var.db_user}",
    "DB_PASSWORD=${var.db_password}"
  ]

  networks_advanced {
    name = var.network_name
  }

  ports {
    internal = 5000
    external = 5000
  }
}