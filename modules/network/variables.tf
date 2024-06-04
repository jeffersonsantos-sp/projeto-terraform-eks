variable "cidr_block" {
  type        = string
  description = "Networking CIDR BLOCK to be used the VPC"

}

variable "project_name" {
  type        = string
  description = "Project name"
}

variable "tags" {
  type        = map(any)
  description = "Tags to be add to AWS Resouces"
}
