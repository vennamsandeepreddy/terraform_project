resource "aws_rds_cluster" "cluster" {
  cluster_identifier     = var.aws_rds_cluster_identifier
  engine                 = var.aws_rds_cluster_engine
  engine_version         = var.aws_rds_cluster_engine_version
  availability_zones     = var.private_zones
  database_name          = var.aws_rds_cluster_database_name
  port                   = var.aws_rds_cluster_port
  master_username        = var.rds_credentials_username
  manage_master_user_password = true
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  deletion_protection = true
  backup_retention_period = 10
  preferred_backup_window = "07:00-09:00"  # hh:mm-hh:mm
  enabled_cloudwatch_logs_exports = ["audit", "error", "general", "slowquery"]
  
  tags = {
    name = "RDS cluster for ECS"
    env = var.aws_rds_cluster_env_tag

  }
}

resource "aws_rds_cluster_instance" "replica" {
  count = var.replica_count
  cluster_identifier   = "${aws_rds_cluster.cluster.id}-${count.index}"
  identifier           = var.aws_rds_cluster_instance_identifier_name
  instance_class       = var.aws_rds_cluster_instance_instane_class
  engine               = aws_rds_cluster.cluster.engine
  engine_version       = aws_rds_cluster.cluster.engine_version
  publicly_accessible  = false
  db_subnet_group_name = aws_db_subnet_group.db_subnet_group.id
}

resource "aws_appautoscaling_target" "read_replica_scaling_target" {
  max_capacity       = 15
  min_capacity       = 1
  resource_id        = "cluster:${aws_rds_cluster.aurora.id}"
  scalable_dimension = "rds:cluster:ReadReplicaCount"
  service_namespace  = "rds"
}

resource "aws_appautoscaling_policy" "read_replica_scaling_policy" {
  name               = "read-replica-scaling-policy"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.read_replica_scaling_target.resource_id
  scalable_dimension = aws_appautoscaling_target.read_replica_scaling_target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.read_replica_scaling_target.service_namespace

  target_tracking_scaling_policy_configuration {
    target_value = 50.0

    predefined_metric_specification {
      predefined_metric_type = "RDSReaderAverageCPUUtilization"
    }

    scale_in_cooldown  = 300
    scale_out_cooldown = 300
  }
}
resource "aws_db_subnet_group" "db_subnet_group" {
  name = "rds"
  subnet_ids = var.private_zones
}


resource "aws_security_group" "rds_sg" {
  vpc_id = var.vpc_id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
  
    security_groups = var.security_group_ecs 
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
