variable "cidr_block" {
  type        = string
  description = "Networking CIDR block to be used for the VPC"
}

variable "project_name" {
  type        = string
  description = "Name to be used as project name"
}

variable "tags" {
  type        = map(any)
  description = "Tags to be added to AWS resources"
}