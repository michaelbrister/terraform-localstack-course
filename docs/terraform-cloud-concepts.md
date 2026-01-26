# Terraform Cloud Concepts (Associate-level)

You do **not** need to use Terraform Cloud to pass the Associate exam, but you *do* need to understand the vocabulary.

## Core entities
- **Organization**: top-level container (users/teams, policies, projects).
- **Project**: groups workspaces (optional, but common).
- **Workspace**: where runs happen; contains state, variables, run history.

## Runs
A **run** is a workflow execution:
- speculative plan (PR validation)
- plan-only
- plan + apply (often requires approval)

Runs can be triggered by:
- VCS commit / PR
- API
- UI/manual

## State and locking
- Each workspace stores one state (per workspace).
- Terraform Cloud coordinates locking so concurrent applies don't corrupt state.

## Variables
- Workspace variables (Terraform variables / environment variables)
- Variable sets (shared variables applied to multiple workspaces)
- Sensitive variables are masked in UI/logs (but can still be in state)

## Remote operations
- **Remote execution**: TFC runs Terraform in its workers.
- **Local execution**: your machine runs Terraform, but TFC stores state.

## VCS-driven workflow (common pattern)
- PR opens → speculative plan
- Merge to main → plan (and optionally apply with approval)

## Teams and RBAC (high level)
Grant least privilege:
- many can plan
- fewer can apply

## Policies
Guardrails for Terraform:
- **Sentinel** (HashiCorp)
- Enforced at plan/apply time

## When to use Terraform Cloud
- shared remote state + locking
- consistent runs with approvals
- audit trail of infra changes
