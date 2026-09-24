variable "postgres_db" {
  description = "PostgreSQL database name"
  type        = string
  default     = "appdb"
}

variable "postgres_user" {
  description = "PostgreSQL application username"
  type        = string
  default     = "appuser"
}

variable "postgres_password" {
  description = "PostgreSQL application password"
  type        = string
  sensitive   = true
}