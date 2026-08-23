resource "aws_launch_template" "tdmfashion_ha_lt" {
  name_prefix   = "tdmfashion-app-"
  description   = "Launch template for application servers"
  image_id      = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name
  user_data     = filebase64("userdata.sh")

  iam_instance_profile {
    name = aws_iam_instance_profile.ec2_profile.id
  }

  # Configure Network Settings
  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.tdmfashion_ha_sg.id]


  }

}

resource "aws_autoscaling_group" "tdmfashion_ha_asg" {
  name_prefix         = "tdmfashion-app-asg-"
  min_size            = 3
  max_size            = 6
  desired_capacity    = 3
  vpc_zone_identifier = var.subnet_ids
  launch_template {
    id      = aws_launch_template.tdmfashion_ha_lt.id
    version = "$Latest"
  }
  tag {
    key                 = "Name"
    value               = "tdmfashion-app"
    propagate_at_launch = true
  }

}

# Attach the Target Group to the Auto Scaling Group
resource "aws_autoscaling_attachment" "tdmfashion_asg_attachment" {
  autoscaling_group_name = aws_autoscaling_group.tdmfashion_ha_asg.name
  lb_target_group_arn    = aws_lb_target_group.tdmfashion_target_group.arn
}
