

#create key with rsa 4096
resource "tls_private_key" "rsa_4096" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

#create key pair using generated key
resource "aws_key_pair" "key_pair" {
  key_name   = var.encrypt_key
  public_key = tls_private_key.rsa_4096.public_key_openssh
}

#write private key in local
resource "local_file" "private_key" {
  filename = "${var.encrypt_key}.pem"
  content  = tls_private_key.rsa_4096.private_key_pem
  provisioner "local-exec" {
    command = "chmod 400 ${var.encrypt_key}.pem"
  }
}


data "aws_availability_zones" "azs" {
  state = "available"
}