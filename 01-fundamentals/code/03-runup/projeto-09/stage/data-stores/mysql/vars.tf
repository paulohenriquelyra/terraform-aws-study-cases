# Input variable: DB password
variable "db_password" {
  description = "Password for the database. Should be passed via environment variable TF_VAR_db_password."
  type        = string
  sensitive   = true
}
