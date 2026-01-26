terraform {
  required_version = ">= 1.5.0"
}

locals {
  tags_common = {
    ManagedBy = "terraform"
    Stack     = var.prefix
    Env       = var.env
  }

  subnets_by_az = {
    for az in distinct([for s in var.subnets : s.az]) :
    az => sort([for s in var.subnets : s.name if s.az == az])
  }

  rules = [
    { topic = "events", queue = "worker" },
    { topic = "events", queue = "audit" },
  ]
}
