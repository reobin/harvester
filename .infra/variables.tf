variable "aws_account_id" {
  type = string
}

variable "aws_vpc_id" {
  type = string
}

variable "aws_subnet_ids" {
  type = list(string)
}

variable "harvest_account_id" {
  type = string
}

variable "harvest_api_token" {
  type      = string
  sensitive = true
}
