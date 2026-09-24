resource "docker_image" "this" {
  name = "terraform-nginx:latest"

  build {
    context    = "${path.root}/nginx"
    dockerfile = "Dockerfile"
  }
}

resource "docker_container" "this" {
  name  = "terraform-nginx"
  image = docker_image.this.image_id

  networks_advanced {
    name = var.network_name
  }

  ports {
    internal = 80
    external = 8080
  }
}