variable "aws_region" {
  description = "AWS region where resources will be provisioned"
  default     = "us-east-2"
}



variable "instance_type" {
  description = "Instance type for the EC2 instance"
  default     = "t2.large"
}
variable "public_key_path" {
  description = "Path to the SSH public key"
  type        = string
}
