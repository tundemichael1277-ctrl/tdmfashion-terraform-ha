variable "ami" {
  description = "The AMI ID to use for the instance"
  type        = string
  default     = "ami-011c04cb040289c2a"

}

variable "instance_type" {
  description = "The type of instance to use"
  type        = string
  default     = "t2.micro"

}

variable "key_name" {
  description = "The name of the key pair to use for the ssh access"
  type        = string
  default     = "mine"


}

variable "environment" {
  description = "The environment for the instance (e.g, dev, QA, prod)"
  type        = string
  default     = "dev"

}

variable "vpc_id" {
  description = "The ID of the VPC where the security group will be created"
  type        = string
  default     = "vpc-06d940850c06f1ea6"

}

variable "subnet_ids" {
    description = "subnet ids"
    type = list(string)
    default = [ "subnet-0786e56b84ef0b03f", "subnet-02b27a6ac45ce1437", "subnet-0fef3d105e522253a" ]
  
}