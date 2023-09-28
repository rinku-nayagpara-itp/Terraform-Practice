locals {
  tags = {
      Environment = var.Environment
      Operating_System = var.Operating_System
      Application = var.Application
      Project_ID = var.Project_ID
      Business_Owner = var.Business_Owner
      Start_Up = var.Start_Up
      Shut_Down = var.Shut_Down
      Backup = var.Backup
      Retention = var.Retention
      Database  = var.Database
      L1_Technical_Owner = var.L1_Technical_Owner
      L2_Technical_Owner = var.L2_Technical_Owner
      Date_in_Service = var.Date_in_Service
      Cost_Center = var.Cost_Center
      SNOW_RITM = var.SNOW_RITM
      Division = var.Division
      Functions = var.Function
      DR_Grouping = var.DR_Grouping
      AWS_Service = var.AWS_Service
      AWX_Template = var.awx_template_tag
    } 
}

locals {
  asgtags = [
    {
      "key"                 = "Environment"
      "value"               = var.Environment
      "propagate_at_launch" = true
    },
    {
      "key"                 = "Operating_System"
      "value"               = var.Operating_System
      "propagate_at_launch" = true
    },
    {
      "key"                 = "Application"
      "value"               = var.Application
      "propagate_at_launch" = true
    },
    {
      "key"                 = "Project_ID"
      "value"               = var.Project_ID
      "propagate_at_launch" = true
    },
    {
      "key"                 = "Business_Owner"
      "value"               = var.Business_Owner
      "propagate_at_launch" = true
    },
    {
      "key"                 = "Start_Up"
      "value"               = var.Start_Up
      "propagate_at_launch" = true
    },
    {
      "key"                 = "Shut_Down"
      "value"               = var.Shut_Down
      "propagate_at_launch" = true
    },
    {
      "key"                 = "Backup"
      "value"               = var.Backup
      "propagate_at_launch" = true
    },
    {
      "key"                 = "Retention"
      "value"               = var.Retention
      "propagate_at_launch" = true
    },
    {
      "key"                 = "L1_Technical_Owner"
      "value"               = var.L1_Technical_Owner
      "propagate_at_launch" = true
    },
    {
      "key"                 = "L2_Technical_Owner"
      "value"               = var.L2_Technical_Owner
      "propagate_at_launch" = true
    },
    {
      "key"                 = "Date_in_Service"
      "value"               = var.Date_in_Service
      "propagate_at_launch" = true
    },
    {
      "key"                 = "Cost_Center"
      "value"               = var.Cost_Center
      "propagate_at_launch" = true
    },
    {
      "key"                 = "SNOW_Ritm"
      "value"               = var.SNOW_RITM
      "propagate_at_launch" = true
    },
    {
      "key"                 = "Division"
      "value"               = var.Division
      "propagate_at_launch" = true
    },
    {
      "key"                 = "Functions"
      "value"               = var.Function
      "propagate_at_launch" = true
    },
    {
      "key"                 = "DR_Grouping"
      "value"               = var.DR_Grouping
      "propagate_at_launch" = true
    },
    {
      "key"                 = "AWS_Service"
      "value"               = var.AWS_Service
      "propagate_at_launch" = true
    },
    {
      "key"                 = "AWX_Template"
      "value"               = var.awx_template_tag
      "propagate_at_launch" = true
    },
  ]
}

# Testing here, will extract to a module once working

data "null_data_source" "asg_tags" {
  count = length(keys(local.tags))

  inputs = merge(
    {
      "key"   = element(keys(local.tags), count.index)
      "value" = element(values(local.tags), count.index)
    },
    {
      "propagate_at_launch" = "true"
    },
  )
}

