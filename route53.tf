resource "aws_route53_record" "tdmfashion_route53_record" {
  zone_id = "Z09314093E2YRK4NEC81L"
  name    = "tdmfashion-app.tdmfashion.com"
  type    = "A"
  alias {
    name                   = aws_lb.tdmfashion_alb.dns_name
    zone_id                = aws_lb.tdmfashion_alb.zone_id
    evaluate_target_health = true
  }

}
