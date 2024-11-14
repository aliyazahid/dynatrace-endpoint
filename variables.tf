variable "tenant_id" {
    type = string
    description = "Your Dynatrace Environment ID (8 characters)"
}
variable "vpc_id" {
    type = string
    description = "VPC ID of your VPC where PrivateLink was created (must be the same region as your Dynatrace Environment)"
}
variable "region" {
  type = string
}