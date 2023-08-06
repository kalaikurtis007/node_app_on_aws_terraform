resource "aws_internet_gateway" "internet_gateway_01" {
  vpc_id = aws_vpc.workspacePro_vpc.id
  tags = {
    "Name" = "internet-gateway_01", "created-by" = "terraform", Environment = "dev"
  }
}