variable "region" {
  description = "AWS region"
  type        = string
  default     = "eu-west-3"
}

variable "tags" {
  type = map(string)
  description = "Map of tags to set to resources"
  default = {}
}