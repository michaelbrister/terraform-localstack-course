
# Terraform Cloud / Team & Governance Guide (Thorough)

This guide is written for learners who may not have access to Terraform Cloud yet.
It explains **how teams operate Terraform** and what governance looks like.

## 1) Why Terraform Cloud exists
Terraform CLI is great for a single person. Teams need:
- Shared state (single source of truth)
- Locking
- Auditable run history
- Access control
- Consistent execution environments
- Policy guardrails

Terraform Cloud provides those features.

## 2) Core objects
### Organization
Top-level container for:
- projects
- workspaces
- policies
- teams/users

### Workspace
A workspace contains:
- 1 state
- variables
- run history
- settings for VCS integration

Rule of thumb:
- 1 workspace per “deployable unit” per environment
  - e.g., `app1-dev`, `app1-prod`
  - or `network-prod`

### Project
A grouping mechanism for workspaces. Useful for large orgs.

## 3) Runs
A run typically includes:
1) Plan
2) Policy checks
3) (Optional) manual approval
4) Apply

**Speculative plan**:
- runs on PR
- produces plan output
- does not apply

## 4) VCS-driven workflow (gold standard)
Typical team flow:
- Developer opens PR
- Terraform Cloud runs speculative plan
- Team reviews plan output
- PR is merged
- Terraform Cloud runs plan on main
- Apply requires approval

Why this is good:
- changes are reviewed
- audit trail exists
- less “cowboy apply”

## 5) Variables and variable sets
Variables in TFC can be:
- Terraform variables (TF_VAR_*)
- Environment variables

Variable sets:
- share common variables across many workspaces
- example: tags, regions, org defaults

Sensitive variables:
- masked in UI/logs
- still may appear in state depending on usage

## 6) RBAC (teams and permissions)
Common roles:
- Read-only (view state/runs)
- Plan (can queue runs / speculative plans)
- Apply (can approve/apply)
- Admin (workspace settings)

Best practice:
- Many can plan
- Few can apply

## 7) Policies (Sentinel) and policy sets
Policies are guardrails enforced during runs.
Examples:
- Require tags
- Prevent public S3 buckets
- Enforce naming conventions
- Block destructive changes in prod

In this repo:
- We use **OPA/Conftest** to teach the same governance concept locally/CI.

## 8) Run tasks
Run tasks integrate external checks into the run lifecycle:
- security scanning
- cost estimation
- compliance checks

## 9) Multi-env strategy in TFC
Two common patterns:

### Pattern A: Workspace-per-env
- `app-dev`, `app-stage`, `app-prod`
Pros: clear isolation, approvals differ by env
Cons: more workspaces

### Pattern B: Workspace + workspaces in CLI
Not recommended for long-lived envs.
Better to use separate workspaces.

## 10) How to translate this repo to Terraform Cloud (optional hands-on)
If your team uses TFC:
- create a workspace per env directory under `live/`
- configure VCS integration
- move backend config out of code (TFC manages state)
- use variable sets for shared tags
- enable approvals for prod

## 11) Governance playbook (practical)
Minimum governance for real teams:
- fmt/validate in CI
- policy checks on plan JSON
- protected main branch
- approvals for prod applies
- run history audit
- state access restricted

This repo already teaches most of that using GitHub Actions + Conftest + Terratest.
