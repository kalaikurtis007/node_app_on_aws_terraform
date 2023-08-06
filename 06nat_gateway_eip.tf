resource "aws_eip" "elasticip_nat_gatewayA" {
  tags = {
    "Name" = "elasticip-networkgatewayA", "created-by" = "terraform", Environment = "dev"
  }
}
resource "aws_eip" "elasticip_nat_gatewayB" {
  tags = {
    "Name" = "elasticip-networkgatewayB", "created-by" = "terraform", Environment = "dev"
  }
}
resource "aws_eip" "elasticip_nat_gatewayC" {
  tags = {
    "Name" = "elasticip-networkgatewayC", "created-by" = "terraform", Environment = "dev"
  }
}

#zoneA
resource "aws_nat_gateway" "nat_gatewayA" {
  allocation_id     = aws_eip.elasticip_nat_gatewayA.id #
  subnet_id         = aws_subnet.public_subnetA.id
  connectivity_type = "public"
  tags = {
    "Name" = "nat-gatewayA", "created-by" = "terraform", Environment = "dev"
  }

}
#zoneB
resource "aws_nat_gateway" "nat_gatewayB" {
  allocation_id     = aws_eip.elasticip_nat_gatewayB.id #
  subnet_id         = aws_subnet.public_subnetB.id
  connectivity_type = "public"
  tags = {
    "Name" = "nat-gatewayB", "created-by" = "terraform", Environment = "dev"
  }
}
#zoneC
resource "aws_nat_gateway" "nat_gatewayC" {
  allocation_id     = aws_eip.elasticip_nat_gatewayC.id #
  subnet_id         = aws_subnet.public_subnetC.id
  connectivity_type = "public"
  tags = {
    "Name" = "nat-gatewayC", "created-by" = "terraform", Environment = "dev"
  }
}
