# Certification Roadmap: Associate vs Professional

This repo can take someone from **zero/limited Terraform** to **strong exam readiness**,
but you still need **targeted exam practice** and a few extra topics that LocalStack
doesn't naturally exercise (cloud-specific nuances).

## Terraform Associate (003) — What you must be able to do
Core objectives:
- Understand Terraform workflow: init/plan/apply/destroy
- Read and write HCL: variables, locals, outputs, functions
- Use collections: maps, lists, objects; for_each; dynamic; expressions
- State: local vs remote; locking; state commands; import basics; drift
- Modules: create, consume, version, pass inputs/outputs
- Terraform Cloud basics (conceptual): workspaces, runs, state storage, VCS integration
- CLI: fmt, validate, console, providers, state subcommands

What this repo covers strongly:
- HCL language + for_each/dynamic patterns
- State progression and migration
- Multi-env folder layout
- Refactor/moved blocks and import drills
- CI + testing mindset

What to add for full Associate coverage:
1) **Terraform Cloud/Enterprise concepts** (no need to use it, but you must know terms):
   - runs, workspaces, remote operations, VCS-driven workflows, variables, state storage
2) **Provider & version constraints** in more depth:
   - required_providers vs provider blocks, dependency lock file, upgrade strategy
3) **Terraform console** drills:
   - expression evaluation, jsonencode/decode, regex, for expressions
4) **Provisioners & null_resource** (mostly "know why not", but exam asks)
5) **Sensitive values** and state implications

Recommendation:
- Add a short `labs/terraform-console/` with 20 prompts + expected outputs.
- Add a `terraform-cloud-concepts.md` cheat sheet and flashcards.

## Terraform Professional (Terraform Ops/Authoring Professional style)
Professional-level expectations go beyond the Associate exam.
You need to demonstrate:
- Designing robust module interfaces (validation, defaults, backwards compatibility)
- Refactoring large states safely (moved blocks, import at scale)
- Multi-env release strategies and promotion
- Policy as code (Sentinel/OPA) and guardrails
- Testing modules (unit-ish) + integration tests (Terratest)
- Drift detection and incident response playbooks
- Secrets handling patterns

What to add for professional readiness:
1) A full **capstone** with:
   - app_stack module versioning
   - separate `live/` envs consuming a pinned module version
   - change promotion with changelog
2) **Policy checks**:
   - Example Sentinel policies or OPA conftest checks (even if run locally)
3) **Documentation discipline**:
   - module READMEs, examples, input/output tables
4) **Operational runbooks**:
   - handling partial applies, stale locks, state recovery procedures
