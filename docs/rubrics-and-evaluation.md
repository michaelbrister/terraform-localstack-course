
# Rubrics and Evaluation

## Associate-ready rubric (pass/fail)
Learner can:
- Explain Terraform workflow and state
- Write variables/locals/outputs
- Use `for_each` with stable keys
- Use dynamic blocks appropriately
- Configure remote state + locking (conceptually and in labs)
- Migrate state without recreation
- Use moved blocks or state mv for refactors
- Answer core check-your-understanding questions

## Professional-ready rubric (graded)
### Level 1 — Contributor
- Works within existing modules and env structure
- Can run plan/apply safely with review

### Level 2 — Maintainer
- Authors modules, improves interfaces
- Handles state moves, refactors, imports

### Level 3 — Operator
- Designs multi-env promotion strategy
- Creates governance guardrails
- Handles incidents and recovery workflows

## Capstone scoring
- Correctness (plan/apply behavior)
- Safety (no unintended replacement)
- Clarity (README, variables, outputs)
- Governance (policy gates)
- Testing (Terratest behavior validation)
