variable "postgres_db" {
  description = "PostgreSQL database name"
  type        = string
}

variable "postgres_user" {
  description = "PostgreSQL application username"
  type        = string
}

variable "postgres_password" {
  description = "PostgreSQL application password"
  type        = string
  sensitive   = true
}

variable "network_name" {
  description = "Docker network name for PostgreSQL"
  type        = string
}