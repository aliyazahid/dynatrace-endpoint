resource "aws_route53_zone" "dynatrace" {
  name = join(".", [var.tenant_id, "live.dynatrace.com."])

  vpc {
    vpc_id = var.vpc_id
    vpc_region = var.region
  }
}

resource "aws_route53_record" "dynatrace" {
  zone_id = aws_route53_zone.dynatrace.zone_id
  name    = join(".", [var.tenant_id, "live.dynatrace.com."])
  type    = "A"

  alias {
    name                   = aws_vpc_endpoint.replace_me.dns_name
    zone_id                = aws_vpc_endpoint.replace_me.hosted_zone_id
    # evaluate_target_health = true
  }
}