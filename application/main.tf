resource "aws_lb" "my_load_balancer" {
  name               = "${var.service_name}-load-balancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb_sg.id]
  subnets            = var.public_subnet_ids
}

resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.my_load_balancer.arn
  port              = "80"
  protocol          = "HTTP"
  # Add default action
}

resource "aws_launch_configuration" "my_launch_configuration" {
  name_prefix          = "${var.service_name}-lc-"
  image_id             = var.ami_id
  instance_type        = var.instance_type
  security_groups      = [aws_security_group.instance_sg.id]
  associate_public_ip_address = false

  # User data and other configurations
}

resource "aws_autoscaling_group" "my_asg" {
  vpc_zone_identifier  = var.private_subnet_ids
  launch_configuration = aws_launch_configuration.my_launch_configuration.id
  min_size             = 1
  max_size             = 3
  desired_capacity     = 1

  # Add target group ARNs and other settings
}

resource "aws_db_instance" "my_db" {
  identifier           = "${var.service_name}-db"
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  allocated_storage    = 20
  username             = "root"
  password             = "password123"
  db_subnet_group_name = aws_db_subnet_group.my_db_subnet_group.name
  vpc_security_group_ids = [aws_security_group.db_sg.id]
  
  # Additional configurations
}

resource "aws_security_group" "lb_sg" {
  vpc_id = var.vpc_id
  # Add ingress and egress rules
}

resource "aws_security_group" "instance_sg" {
  vpc_id = var.vpc_id
  # Add ingress and egress rules
}

resource "aws_security_group" "db_sg" {
  vpc_id = var.vpc_id
  # Add ingress and egress rules
}

