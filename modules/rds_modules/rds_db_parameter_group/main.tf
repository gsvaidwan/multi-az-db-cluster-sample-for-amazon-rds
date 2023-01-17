locals {
  name        = var.use_name_prefix ? null : var.name
  name_prefix = var.use_name_prefix ? "${var.name}-" : null

  description = coalesce(var.description, format("%s parameter group", var.name))
}

resource "aws_rds_cluster_parameter_group" "this" {
  count = var.create ? 1 : 0

  name        = local.name
  name_prefix = local.name_prefix
  description = local.description
  family      = var.family

  parameter {
    name="log_statement"
    value="all"
  }

  parameter {
    name="log_min_duration_statement"
    value="1"
  }

  tags = merge(
    var.tags,
    {
      "Name" = var.name
    },
  )

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_db_parameter_group" "this" {
  count = var.create ? 1 : 0

  name        = local.name
  name_prefix = local.name_prefix
  description = local.description
  family      = var.family

  parameter {
    name="log_statement"
    value="all"
  }

  parameter {
    name="log_min_duration_statement"
    value="1"
  }

  tags = merge(
    var.tags,
    {
      "Name" = var.name
    },
  )

  lifecycle {
    create_before_destroy = true
  }
}