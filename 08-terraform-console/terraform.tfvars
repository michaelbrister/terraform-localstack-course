tag_overrides = {
  Owner = "michael"
  Env   = "dev"
}

subnets = [
  { name = "private-a", cidr = "10.0.1.0/24",   az = "us-east-1a", type = "private" },
  { name = "private-b", cidr = "10.0.2.0/24",   az = "us-east-1b", type = "private" },
  { name = "public-a",  cidr = "10.0.101.0/24", az = "us-east-1a", type = "public"  },
]
