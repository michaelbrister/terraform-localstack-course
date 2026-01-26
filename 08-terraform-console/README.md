# 08 — Terraform Console Drills (20 prompts + expected outputs)

These drills are designed for **Terraform Associate (003)** exam readiness.
They train you to reason about Terraform expressions quickly.

## Setup
```bash
cd 08-terraform-console
terraform init -backend=false
terraform console
```

In the console, paste each prompt exactly and compare to the expected output.

---

## Data available in this folder

Variables are defined in `variables.tf` and defaulted in `terraform.tfvars`.

Locals:
- `local.tags_common`
- `local.subnets_by_az`
- `local.rules`

---

## Prompts

### 1) Simple string interpolation
Prompt
```hcl
"${var.prefix}-${var.env}"
```
Expected
```
"tf-course-dev"
```

### 2) join
Prompt
```hcl
join("-", ["tf", var.env, "app"])
```
Expected
```
"tf-dev-app"
```

### 3) format
Prompt
```hcl
format("%s-%02d", var.env, 7)
```
Expected
```
"dev-07"
```

### 4) lookup with default
Prompt
```hcl
lookup(var.tag_overrides, "Owner", "unknown")
```
Expected
```
"michael"
```

### 5) merge maps
Prompt
```hcl
merge(local.tags_common, var.tag_overrides)
```
Expected
```
{
  "Env" = "dev"
  "ManagedBy" = "terraform"
  "Owner" = "michael"
  "Stack" = "tf-course"
}
```

### 6) try (missing key)
Prompt
```hcl
try(var.maybe.missing, "fallback")
```
Expected
```
"fallback"
```

### 7) can (safe access)
Prompt
```hcl
can(var.maybe.missing)
```
Expected
```
false
```

### 8) toset (dedupe)
Prompt
```hcl
toset(["a","b","a"])
```
Expected
```
toset([
  "a",
  "b",
])
```

### 9) flatten nested lists
Prompt
```hcl
flatten([["a","b"],["c"]])
```
Expected
```
[
  "a",
  "b",
  "c",
]
```

### 10) for expression (map from list)
Prompt
```hcl
{ for s in var.subnets : s.name => s.cidr }
```
Expected
```
{
  "private-a" = "10.0.1.0/24"
  "private-b" = "10.0.2.0/24"
  "public-a" = "10.0.101.0/24"
}
```

### 11) for expression with filter
Prompt
```hcl
[for s in var.subnets : s.name if s.type == "private"]
```
Expected
```
[
  "private-a",
  "private-b",
]
```

### 12) group by AZ (map(list))
Prompt
```hcl
local.subnets_by_az
```
Expected
```
{
  "us-east-1a" = [
    "private-a",
    "public-a",
  ]
  "us-east-1b" = [
    "private-b",
  ]
}
```

### 13) distinct
Prompt
```hcl
distinct([for s in var.subnets : s.az])
```
Expected
```
[
  "us-east-1a",
  "us-east-1b",
]
```

### 14) regexall
Prompt
```hcl
regexall("([a-z]+)-([a-z]+)", "tf-course")
```
Expected
```
[
  [
    "tf-course",
    "tf",
    "course",
  ],
]
```

### 15) jsonencode
Prompt
```hcl
jsonencode({ env = var.env, tags = local.tags_common })
```
Expected
```
"{\"env\":\"dev\",\"tags\":{\"Env\":\"dev\",\"ManagedBy\":\"terraform\",\"Stack\":\"tf-course\"}}"
```

### 16) jsondecode
Prompt
```hcl
jsondecode("{\"a\":1,\"b\":[2,3]}")
```
Expected
```
{
  "a" = 1
  "b" = [
    2,
    3,
  ]
}
```

### 17) coalesce
Prompt
```hcl
coalesce(var.optional_name, "default-name")
```
Expected
```
"default-name"
```

### 18) conditional
Prompt
```hcl
var.env == "prod" ? 3 : 1
```
Expected
```
1
```

### 19) zipmap
Prompt
```hcl
zipmap(["a","b"], [1,2])
```
Expected
```
{
  "a" = 1
  "b" = 2
}
```

### 20) stable composite keys
Prompt
```hcl
{ for r in local.rules : "${r.topic}|${r.queue}" => r }
```
Expected
```
{
  "events|audit" = {
    "queue" = "audit"
    "topic" = "events"
  }
  "events|worker" = {
    "queue" = "worker"
    "topic" = "events"
  }
}
```

---

If you can do these quickly without guessing, your expression skills are exam-ready.
