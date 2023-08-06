# aws_vpc.demo_vpc:
resource "aws_vpc" "workspacePro_vpc" {
  cidr_block                       = "10.0.0.0/16" #65536 private ips
  instance_tenancy                 = "default"
  assign_generated_ipv6_cidr_block = false
  enable_dns_hostnames             = true
  enable_dns_support               = true
  tags                             = {
    "Name" = "workspacePro-vpc", "created-by" = "terraform", Environment = "dev"
  }
}
