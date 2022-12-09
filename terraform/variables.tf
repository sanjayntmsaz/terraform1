variable "username" {
  default     = "vmadmin"
  type        = string
  description = "local Admin User Name"
}
variable "password" {
  default     = "123#ntms123#"
  type        = string
  description = "Password"
}
variable "rgname" {
  type = map(any)
  default = {
    dev  = "devtest-RG"
    prod = "prod-RG"
  }
  description = "RG name"
}

