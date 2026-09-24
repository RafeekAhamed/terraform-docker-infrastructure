variable "db_host" {
  description = "PostgreSQL container hostname"
  type        = string
}

variable "db_name" {
  description = "PostgreSQL database name"
  type        = string
}

variable "db_user" {
  description = "PostgreSQL username"
  type        = string
}

variable "db_password" {
  description = "PostgreSQL password"
  type        = string
  sensitive   = true
}

variable "network_name" {
  description = "Docker network name"
  type        = string
}

variable "container_name" {
  description = "Backend container name"
  type        = string
}

variable "host_port" {
  description = "Backend host port"
  type        = number
}