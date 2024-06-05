variable "project_name" {
  type        = string
  description = "Project name"
}

variable "tags" {
  type        = map(any)
  description = "Tags to be add to AWS Resouces"
}


variable "cluster_name" {
  type        = string
  description = "Name Cluster"
}


variable "subnet-private-1a" {
  type        = string
  description = "Subnet Private 1a"

}

variable "subnet-private-1b" {
  type        = string
  description = "Subnet Private 1b"

}

 