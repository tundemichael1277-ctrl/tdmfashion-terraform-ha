resource "aws_security_group" "tdmfashion_ha_sg" {
  name        = "tdmfashion-ha-sg"
  description = "http and ssh access"
  vpc_id      = "vpc-06d940850c06f1ea6"
}

resource "aws_security_group_rule" "ingress_ssh" {
  type              = "ingress"
  description       = "ssh"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.tdmfashion_ha_sg.id

}

resource "aws_security_group_rule" "ingress_http" {
  type              = "ingress"
  description       = "http"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.tdmfashion_ha_sg.id

}


resource "aws_security_group_rule" "egress_access" {
  type              = "egress"
  description       = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.tdmfashion_ha_sg.id

}