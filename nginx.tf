resource "docker_image" "nginx" {
  name = "terraform-nginx:latest"

  build {
    context    = "${path.module}/nginx"
    dockerfile = "Dockerfile"
  }
}

resource "docker_container" "nginx" {
  name  = "terraform-nginx"
  image = docker_image.nginx.image_id

  networks_advanced {
    name = docker_network.app_network.name
  }

  ports {
    internal = 80
    external = 8080
  }
}