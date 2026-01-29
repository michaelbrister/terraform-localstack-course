
# Terraform Associate (003) Objective Mapping — Expanded

This mapping aligns course materials to the official exam domains.
Domain names can shift between versions; the goal here is coverage of tested skills.

## IaC Concepts
- docs/00-how-to-think-in-terraform.md
- docs/glossary.md
- 01-local-basics

## Terraform Workflow and CLI
- 01-local-basics (init/plan/apply/destroy)
- 02-language-basics (validate, variable overrides)
- 12-exam-drills (timed troubleshooting)
- 13-state-subcommands (state list/show/mv/rm/pull)
- CI workflow reinforces fmt/validate and plan discipline

## Terraform Configuration Language
- 02-language-basics
- 03-for-each-patterns (collections and for expressions)
- 04-dynamic-patterns (optional nested blocks)
- 08-terraform-console (expressions, jsonencode/decode, try/can)
- 07-modules (module interfaces)

## State Management
- 05-backend-bootstrap
- 06-state-migration
- 13-state-subcommands
- 09-refactor-state
- 10-breakfix (drift, locks)

## Modules
- 07-modules
- modules/app_stack
- live/dev|stage|prod (consuming modules per env)

## Terraform Cloud Concepts
- docs/terraform-cloud-team-governance-guide.md
- docs/workspaces-vs-folder-per-env.md
- 14–16 labs simulate TFC workflows via GitHub Actions approvals/policies

## Security & Best Practices (tested indirectly)
- policy/ checks (tags, naming, IAM guardrails if included)
- docs/provider-lockfile-and-upgrades.md
- docs/provisioners-and-null_resource.md
