variable "project_name" {
  type        = string
  description = "Name to be used as project name"
}

variable "tags" {
  type        = map(any)
  description = "Tags to be added to AWS resources"
}

variable "cluster_name" {
  type        = string
  description = "EKS Cluster name to create Managed Node Group"
}

variable "private_subnet_1a" {
  type        = string
  description = "Private subnet ID for availability zone 1a"
}

variable "private_subnet_1b" {
  type        = string
  description = "Private subnet ID for availability zone 1b"
}