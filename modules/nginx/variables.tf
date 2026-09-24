variable "network_name" {
  description = "Docker network name"
  type        = string
}

variable "container_name" {
  description = "Nginx container name"
  type        = string
}

variable "host_port" {
  description = "Nginx host port"
  type        = number
}