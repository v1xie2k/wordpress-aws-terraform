variable "AWS_REGION" {
  default = "us-west-2"
}

variable "AWS_VPC_CIDR" {
  default = "10.0.0.0/16"
}

variable "db_username" {
  description = "The database username"
  type        = string
  default = "admin"
}

variable "db_password" {
  description = "The database password"
  type        = string
  default = "adminWp123"
}

variable "db_name" {
  description = "The database name"
  type        = string
  default     = "wordpressdb"
}