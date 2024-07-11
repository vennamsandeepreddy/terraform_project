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
  enabled_cloudwatch_logs_exports = ["audit", "error", "general", "slowquery", "postgresql"]
  
  tags = {
    name = "RDS cluster for ECS"
    env = var.aws_rds_cluster_env_tag

  }
}

resource "aws_rds_cluster_instance" "replica" {
  cluster_identifier   = aws_rds_cluster.cluster.id
  identifier           = var.aws_rds_cluster_instance_identifier_name
  instance_class       = var.aws_rds_cluster_instance_instane_class
  engine               = aws_rds_cluster.cluster.engine
  engine_version       = aws_rds_cluster.cluster.engine_version
  publicly_accessible  = false
  db_subnet_group_name = aws_db_subnet_group.db_subnet_group.id
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
