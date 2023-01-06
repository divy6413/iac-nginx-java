variable "env" {
  type = string
  description = "Environment name"
}

variable "team" {
  type = string
  description = "Team name"
}

variable "cidr_block" {
  type = string
  description = "cidr block"
  default = "10.0.0.0/16"
}
variable "env" {
  type        = string
  description = "Environment name"
}

variable "team" {
  type        = string
  description = "Team name"
}

variable "availability_zone" {
  type        = string
  description = "Availability Zone"
}

variable "public_cidr_block" {
  type        = string
  description = "cidr block"
}

variable "private_cidr_block" {
  type        = string
  description = "cidr block"
}

variable "db_cidr_block" {
  type        = string
  description = "cidr block"
}

variable "vpc_id" {
  type        = string
  description = "VPC id"
}

variable "ig_id" {
  type        = string
  description = "Internet Gateway ID"
}