# Terraform Fundamentals → Production (with LocalStack)

> A hands-on Terraform training program: Zero → Associate → Professional.

**Last updated:** 2026-01-29

This repository is a **complete, hands-on Terraform training program** designed to take learners from
**little/no Terraform experience** to **production-grade Terraform proficiency**.

By the end of the program, learners can:

- Pass the **Terraform Associate (003)** exam (with additional practice)
- Contribute safely to real Terraform codebases
- Understand team workflows, governance, and Terraform Cloud concepts
- Handle professional scenarios: refactors, imports, drift, incident recovery, CI gating, policy-as-code

The program emphasizes:

- reproducible labs
- safe failure and recovery
- opinionated best practices
- validation-first, CI-friendly workflows

---

## Who this is for

- New Terraform users (even without programming background)
- DevOps / Cloud engineers onboarding to Terraform
- Teams standardizing IaC workflows
- Engineers moving from “Terraform user” → “Terraform operator”

---

## How the program is structured

### Track A — Foundations (Associate-ready)

Labs 01–13 + docs + timed drills.

### Track B — Terraform Cloud / Team & Governance

Labs 14–16 + governance docs + CI patterns + “approval gates”

### Track C — Professional scenario labs

Labs 17–22 + capstone + instructor-led incident drills

---

## Fast start

1. Start LocalStack:

```bash
docker compose up -d
curl -s http://localhost:4566/_localstack/health | jq
```

2. Run Labs in order (recommended):

- `01-local-basics`
- `02-language-basics`
- `03-for-each-patterns`
- `04-dynamic-patterns`
- `05-backend-bootstrap`
- `06-state-migration`
- `07-modules`
- `08-terraform-console`
- `09-refactor-state`
- `10-breakfix`
- `11-terratest`
- `12-exam-drills`
- `13-state-subcommands`

3. Then do Team & Governance + Professional labs:

- `14-tfc-workspaces-and-runs`
- `15-team-rbac-and-variables`
- `16-governance-sentinel-opa-and-approvals`
- `17-import-and-adopt`
- `18-module-versioning-and-promotion`
- `19-multi-team-boundaries`
- `20-policy-hardening`
- `21-incident-recovery`
- `22-capstone`

---

## Instructor-led vs self-paced

- **Self-paced:** Use `docs/syllabus-self-paced.md`.
- **Instructor-led:** Use `docs/syllabus-instructor-led.md` + `docs/instructor-notes.md`.

---

## What “proficient” means here

A proficient learner can:

- Predict plans (adds/changes/destroys) before running them
- Use `for_each` and stable keys correctly
- Migrate and manage state safely (remote backends + locks)
- Refactor without replacing resources (moved blocks, state mv)
- Import existing infra and converge without downtime
- Use CI gates (fmt/validate/tflint/trivy, policy checks)
- Explain Terraform Cloud concepts: workspaces, runs, approvals, policies, RBAC
- Handle drift and incident recovery calmly

---

## Reference documents

- `docs/glossary.md`
- `docs/00-how-to-think-in-terraform.md`
- `docs/associate-objective-mapping.md`
- `docs/terraform-cloud-team-governance-guide.md`
- `docs/instructor-notes.md`
- `docs/rubrics-and-evaluation.md`
