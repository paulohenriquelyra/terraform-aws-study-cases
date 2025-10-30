# Input variable: S3 bucket name
variable "bucket_name" {
  description = "The name of the S3 bucket. Must be globally unique."
  default = "terraform-up-and-running-state-20251024"
}
