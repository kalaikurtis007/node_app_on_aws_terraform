#create Route53 zone
resource "aws_route53_zone" "route5301" {
  name = "workspacePro.in"
  vpc {
    vpc_id = aws_vpc.workspacePro_vpc.id
  }
  tags = {
    "Name" = "route5301", "created-by" = "terraform", Environment = "dev"
  }
}
data "aws_route53_zone" "selected" {
  name         = aws_route53_zone.route5301.name
  private_zone = true
  #zone_id = data.aws_availability_zones.azs.id
}

#create a route 53 for db
resource "aws_route53_record" "workspacepro_db01_record" {
  zone_id    = data.aws_route53_zone.selected.id
  depends_on = [aws_route53_zone.route5301]

  name       = "app01.${data.aws_route53_zone.selected.name}"
  type       = "A"
  ttl        = "300"
  records    = [aws_instance.ec2_instance_application.private_ip]
}

resource "aws_route53_record" "workspacepro_db02_record" {
  zone_id    = data.aws_route53_zone.selected.id
  depends_on = [aws_route53_zone.route5301]

  name       = "db01.${data.aws_route53_zone.selected.name}"
  type       = "A"
  ttl        = "300"
  records    = [aws_instance.ec2_instance_backend.private_ip]
}
