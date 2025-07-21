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
    evaluate_target_health = true
  }
}
# Allow creating tokens (required by Terraform or some modules)
path "auth/token/create" {
  capabilities = ["update"]
}

# Allow listing secrets in the KV v2 engine
path "secret/metadata/*" {
  capabilities = ["list"]
}

# Allow reading (getting) secrets in KV v2
path "secret/data/*" {
  capabilities = ["read"]
}


latest_agent_version=$(curl -s https://checkpoint-api.hashicorp.com/v1/check/terraform-enterprise-agent | jq -r .current_version)
RUN dnf install -y terraform && dnf clean all



latest_agent_version=$(curl -s https://releases.hashicorp.com/tfe-agent/ | \
  grep -oP 'tfe-agent/\K[0-9]+\.[0-9]+\.[0-9]+(?=/)' | \
  sort -Vr | \
  head -n 1)

