variable "region" {
  description = "AWS region"
  type        = string
  default     = "ap-southeast-1"
}

variable "num_count" {
  default = 3
}

variable "ami" {
  default = "ami-094bbd9e922dc515d"
}

variable "s3_bucket" {
  default = "yuvraj-assessment"
}

variable "public_key_path" {}
variable "access_key" {}
variable "secret_key" {}
variable "instance_type" {}
variable "autoscaling_group_min_size" {}

variable "autoscaling_group_max_size" {}
