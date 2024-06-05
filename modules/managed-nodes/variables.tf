variable "project_name" {
  type        = string
  description = "Project name"
}

variable "tags" {
  type        = map(any)
  description = "Tags to be add to AWS Resouces"
}


