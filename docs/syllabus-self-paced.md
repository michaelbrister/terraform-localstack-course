
# Self-Paced Syllabus (8 weeks)

This is designed for learners with limited programming experience.
If you’re experienced, you can compress weeks 1–4.

## Week 0 — Orientation (2–3 hours)
- Read:
  - docs/00-how-to-think-in-terraform.md
  - docs/glossary.md
- Install tools:
  - Terraform
  - Docker
  - LocalStack
- Run:
  - 01-local-basics (guided)

## Week 1 — Core workflow & local state
- Labs: 01, 02
- Outcomes:
  - Explain state/plan/apply in your own words
  - Predict what happens when you change a variable
- Drill: 12-exam-drills (drill 01 only)

## Week 2 — Scaling with collections
- Labs: 03, 08 (console)
- Outcomes:
  - Explain `count` vs `for_each`
  - Use terraform console for expressions

## Week 3 — Optional config with dynamic blocks
- Labs: 04
- Outcomes:
  - Use dynamic blocks safely
  - Know when NOT to use dynamic blocks

## Week 4 — State backends and locking
- Labs: 05, 06, 13
- Outcomes:
  - Explain why remote state + locking matters
  - Migrate state without recreating resources

## Week 5 — Modules & reuse
- Labs: 07, 09
- Outcomes:
  - Create module interfaces (inputs/outputs)
  - Refactor safely using moved blocks

## Week 6 — Troubleshooting + test discipline
- Labs: 10, 11
- Outcomes:
  - Diagnose drift and key instability
  - Run Terratest and interpret failures

## Week 7 — Team & Governance (Terraform Cloud concepts)
- Labs: 14, 15, 16
- Outcomes:
  - Understand workspaces, runs, approvals
  - Understand RBAC/variables/policies
  - Explain team workflows (PR → plan → approval → apply)

## Week 8 — Professional scenarios + capstone
- Labs: 17–22
- Outcomes:
  - Import and adopt existing infra
  - Version modules and promote changes
  - Recover from incidents
  - Complete capstone

---

## Completion standard
- All labs completed
- All timed drills passed
- Capstone delivered with README + CI green
