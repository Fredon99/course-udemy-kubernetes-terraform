variable "project_name" {
  type        = string
  description = "Name to be used as project name"
}

variable "tags" {
  type        = map(any)
  description = "Tags to be added to AWS resources"
}

variable "public_subnet_1a" {
  type        = string
  description = "Subnet to create eks cluster at AZ 1a"
}

variable "public_subnet_1b" {
  type        = string
  description = "Subnet to create eks cluster at AZ 1b"
}