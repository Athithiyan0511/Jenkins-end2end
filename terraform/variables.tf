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

variable "eks_cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
  default     = "wanderlust-eks"
}

variable "eks_kubernetes_version" {
  description = "Kubernetes version for EKS"
  type        = string
  default     = "1.34"
}

variable "eks_node_group_name" {
  description = "Name of the EKS managed node group"
  type        = string
  default     = "wanderlust-ng"
}

variable "eks_node_instance_type" {
  description = "EC2 instance type for EKS worker nodes"
  type        = string
  default     = "t3.medium"
}

variable "eks_desired_nodes" {
  description = "Desired number of EKS worker nodes"
  type        = number
  default     = 1
}

variable "eks_min_nodes" {
  description = "Minimum number of EKS worker nodes"
  type        = number
  default     = 1
}

variable "eks_max_nodes" {
  description = "Maximum number of EKS worker nodes"
  type        = number
  default     = 2
}
