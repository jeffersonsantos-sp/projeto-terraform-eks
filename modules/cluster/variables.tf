variable "project_name" {
  type        = string
  description = "Project name"
}

variable "tags" {
  type        = map(any)
  description = "Tags to be add to AWS Resouces"
}


variable "subnet_public_1a" {
  type        = string
  description = "Subnet Public 1a"

}

variable "subnet_public_1b" {
  type        = string
  description = "Subnet Public 1b"

}