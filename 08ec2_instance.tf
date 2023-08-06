#create db instance
resource "aws_instance" "ec2_instance_application" {
  ami                    = "ami-0f34c5ae932e6f0e4"
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.key_pair.key_name
  vpc_security_group_ids = [aws_security_group.sg_workspacePro_application.id]

  subnet_id = aws_subnet.public_subnetA.id
  root_block_device {
    volume_size = 10
    volume_type = "gp2"
  }
  associate_public_ip_address = true
  tags = {
    "Name" = "ec2-instance-application", "created-by" = "terraform", Environment = "dev"
  }
  #user_data                   = "${file("user_data/node.sh")}"
  provisioner "local-exec" {
    command = "touch dynamic_inventory.ini"
  }
}


resource "aws_instance" "ec2_instance_backend" {
  ami           = "ami-0f34c5ae932e6f0e4"
  instance_type = "t2.micro"
  key_name      = aws_key_pair.key_pair.key_name

  vpc_security_group_ids = [aws_security_group.sg_workspacePro_backend.id]

  subnet_id = aws_subnet.private_subnetA.id
  root_block_device {
    volume_size = 10
    volume_type = "gp2"
  }
  tags = {
    "Name" = "ec2-instance-backend", "created-by" = "terraform", Environment = "dev"
  }
  user_data                   = "${file("user_data/mysql.sh")}"
}

resource "local_file" "dynamic_inventory" {
  depends_on = [aws_instance.ec2_instance_application]

  filename = "dynamic_inventory.ini"
  content = <<-EOT
          [ec2_instances]
          ${aws_instance.ec2_instance_application.public_ip} ansible_user=ec2-user ansible_private_key_file=${path.module}/${var.encrypt_key}.pem
    EOT

  provisioner "local-exec" {
    command = "chmod 400 ${local_file.dynamic_inventory.filename}"
  }
}

resource "null_resource" "add_ssh_to_local" {
  depends_on = [local_file.dynamic_inventory]

  provisioner "local-exec" {
    command = "ssh-keygen -R ${aws_instance.ec2_instance_application.public_ip}"
    working_dir = path.module
  }
}

resource "null_resource" "run_ansible" {
  depends_on = [local_file.dynamic_inventory]

  provisioner "local-exec" {
    command = "ansible-playbook -i dynamic_inventory.ini deploy-app.yml"
    working_dir = path.module
  }
}