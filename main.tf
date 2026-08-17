resource "aws_launch_template" "tdmfashion_ha_lt" {
  name_prefix   = "tdmfashion-app-"
  description   = "Launch template for application servers"
  image_id      = "ami-011c04cb040289c2a"
  instance_type = "t3.micro"
  key_name      = "mine"

  #   iam_instance_profile {
  #     name = "EC2-SSM-Role"
  #   }

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
  vpc_zone_identifier = ["subnet-0786e56b84ef0b03f", "subnet-02b27a6ac45ce1437", "subnet-0fef3d105e522253a"]
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
