resource "aws_ecs_cluster" "api" {
  name = var.aws_ecs_cluster_name
}

resource "aws_ecs_cluster_capacity_providers" "api" {
  cluster_name = aws_ecs_cluster.api.name

  capacity_providers = [var.capacity_providers_type]

  default_capacity_provider_strategy {
    base              = var.capacity_provider_strategy_base_value
    weight            = var.capacity_provider_strategy_weight_value  
    capacity_provider = var.capacity_providers_type
  }
  depends_on = [ aws_ecs_cluster.api ]
}

resource "aws_ecs_service" "helloworld" {
  name            = var.aws_ecs_service_service_name
  cluster         = aws_ecs_cluster.api.id
  task_definition = aws_ecs_task_definition.helloworld.arn
  desired_count   = var.aws_ecs_service_task_desired_count 
  launch_type     = var.capacity_providers_type

# Below two steps are related to Rolling-Update deloyment Strategy : 
  deployment_minimum_healthy_percent = var.deployment_minimum_healthy_percent
  deployment_maximum_percent         = var.deployment_maximum_percent

  network_configuration {
    subnets          = var.private_subnets
    security_groups  = [aws_security_group.api.id]
    assign_public_ip = false
  }

  load_balancer {
    container_name   = var.aws_ecs_container_name
    container_port   = var.aws_ecs_container_port
    target_group_arn = var.lb_target_group_id
  }
}

resource "aws_security_group" "api" {
  vpc_id      = var.vpc_id
  ingress {
    from_port   = var.ecs_service_port
    to_port     = var.ecs_service_port
    protocol    = var.ecs_service_protocol
    security_groups = var.alb_sg
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_ecs_task_definition" "helloworld" {
  family                   = var.aws_ecs_task_definition_name
  cpu                      = var.aws_ecs_task_definition_cpu_limit
  memory                   = var.aws_ecs_task_definition_memory_limit
  network_mode             = "awsvpc"
  requires_compatibilities = [var.capacity_providers_type]

  container_definitions = jsonencode(
    [
      {
        name      = "${var.aws_ecs_container_name}"
        image     = "${var.aws_ecs_task_definition_container_image}"
        essential = true
        portMappings = [
          {
            protocol      = "${var.ecs_service_protocol}"
            hostPort      = "${var.aws_ecs_container_port}"
            containerPort = "${var.aws_ecs_container_port}"
          }
        ]
      }
    ]
  )
}


resource "aws_appautoscaling_target" "ecs_autoscaling" {
  max_capacity = 5
  min_capacity = 1
  resource_id = "service/${var.aws_ecs_cluster_name}/${var.aws_ecs_service_service_name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace = "ecs"
}

resource "aws_appautoscaling_policy" "ecs_as_towards_memory_target" {
  name               = "ecs-memory-metric"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.ecs_autoscaling.resource_id
  scalable_dimension = aws_appautoscaling_target.ecs_autoscaling.scalable_dimension
  service_namespace  = aws_appautoscaling_target.ecs_autoscaling.service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageMemoryUtilization"
    }

    target_value       = 80
  }
}

resource "aws_appautoscaling_policy" "ecs_as_towards_cpu_target" {
  name = "ecs-cpu-metric"
  policy_type = "TargetTrackingScaling"
  resource_id = aws_appautoscaling_target.ecs_autoscaling.resource_id
  scalable_dimension = aws_appautoscaling_target.ecs_autoscaling.scalable_dimension
  service_namespace = aws_appautoscaling_target.ecs_autoscaling.service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }

    target_value = 60
  }
}