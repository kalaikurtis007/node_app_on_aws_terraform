variable "certificate_arn" {
  type    = string
  default = ""
}

variable "encrypt_key" {
  type    = string
  default = "ec2_key"
}

variable "application_ami" {
  type    = "string"
  default = "ami-0f34c5ae932e6f0e4" // free tier amazon linux latest.
}