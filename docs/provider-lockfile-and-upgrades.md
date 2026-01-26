# Provider lockfile, constraints, and upgrades (`terraform.lock.hcl`)

Exam-relevant and production-critical.

Terraform resolves providers using:
1) **Constraints** in configuration (`required_providers`)
2) **Lockfile** (`terraform.lock.hcl`) created by `terraform init`

## What the lockfile does
The lockfile records:
- chosen provider version(s)
- checksums for provider packages (multiple platforms)

Purpose: deterministic installs across machines/CI.

## Constraints vs lockfile
Constraints define allowed versions:

```hcl
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
```

Lockfile pins the selected version within constraints.

## `terraform init` behavior
- installs provider versions satisfying constraints
- prefers the locked version if valid
- updates lockfile when needed

### `terraform init -upgrade`
- re-evaluates and downloads newer versions within constraints
- updates lockfile

## Upgrade strategy
1. Use sane constraints (`~> 5.0`)
2. Upgrade intentionally (`init -upgrade`)
3. Review plan before apply
4. Avoid surprise upgrades in CI unless testing upgrades

## Exam tips
- Lockfile improves repeatability (not “secrets security”)
- Constraints + lockfile together determine what gets installed
- Typical fix for init failures:
  - adjust constraint responsibly and/or run `init -upgrade`
