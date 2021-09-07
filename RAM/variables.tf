variable "user_name_membership_group1" {
  type = list
  default = ["user1_name"]
}

variable "cpu_core_count" {
  type = number
  default = 1
}

variable "memory_size" {
  type = number
  default = 2 
}

variable "k8_version" {
  type        = string
  default     = ""
}

variable "worker_instance_types" {
  type        = list(string)
  default     = ["ecs.n4.xlarge"]
  
}
