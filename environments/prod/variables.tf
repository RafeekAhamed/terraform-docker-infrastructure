variable "postgres_db" {
  description = "Production PostgreSQL database name"
  type        = string
  default     = "appdb_prod"
}

variable "postgres_user" {
  description = "Production PostgreSQL application username"
  type        = string
  default     = "appuser"
}

variable "postgres_password" {
  description = "Production PostgreSQL application password"
  type        = string
  sensitive   = true
}