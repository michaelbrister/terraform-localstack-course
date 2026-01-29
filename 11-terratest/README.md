# Lab 11 — Terratest Integration Testing

## What this lab teaches you

This lab introduces **infrastructure testing** using Terratest.

Concepts covered:

- Terraform automation
- Assertions on real infrastructure
- Behavior-based testing

## Why this matters

Terraform code should be tested like application code.

## Exam notes

Terratest is not on the Associate exam, but it reflects professional practice.

# Lab 11 — Terratest: Infrastructure Testing for Terraform Operators

## What this lab teaches you

This lab introduces **infrastructure testing** using Terratest and explains _why_ testing matters for Terraform—not just _how_ to write tests.

By the end of this lab, you will understand:

- What Terratest is actually testing (and what it is not)
- The difference between **“apply succeeded”** and **“behavior is correct”**
- How tests protect refactors and prevent regressions
- How infrastructure tests fit into CI/CD pipelines
- Why professional Terraform teams test infrastructure

You do **not** need to be a Go expert to complete or understand this lab.

---

## Mental model: Tests protect behavior, not syntax

Terraform already validates:

- syntax (`terraform fmt`, `terraform validate`)
- provider schemas
- dependency graphs

Terratest exists to answer a different question:

> **“Does the deployed infrastructure behave the way we expect?”**

Examples of behavior:

- An S3 bucket exists and has the correct tags
- An SNS message is delivered to all subscribed SQS queues
- A refactor did not cause resource replacement
- A stable configuration produces a clean plan after apply

Terratest verifies outcomes, not just configuration correctness.

---

## Why this lab matters

Terraform refactors (like Lab 09) are safe **only if behavior stays the same**.

Without tests:

- refactors rely on human review alone
- regressions slip through
- teams become afraid to change code

With tests:

- refactors are safer
- CI can block dangerous changes
- confidence increases over time

This lab teaches how testing enables **fearless Terraform changes**.

---

## Where Terratest fits in the Terraform workflow

A professional Terraform workflow typically looks like:

1. Lint and validate (fmt, validate, tflint)
2. Plan and review
3. Apply
4. **Test deployed infrastructure**
5. Lock in behavior for the future

Terratest lives at step 4.

---

## What Terratest is NOT

Terratest is not:

- a replacement for `terraform plan`
- a replacement for policy (OPA/Conftest)
- required for the Terraform Associate exam

Terratest **is**:

- a professional best practice
- common in production teams
- expected knowledge at senior levels

---

## Structure of the tests in this lab

The tests in this lab are written in Go, but focus on **readability over cleverness**.

You will see patterns like:

- `terraform.InitAndApply`
- reading Terraform outputs
- asserting resource properties
- verifying no replacements occurred

Focus on _what is being asserted_, not Go syntax details.

---

## Predict the test outcomes (before running)

Before running the tests, answer:

1. What behavior is each test trying to protect?
2. What would break if the assertion failed?
3. What Terraform change would cause this test to fail?

These questions matter more than memorizing test code.

---

## Running the tests

From the test directory:

```bash
go test -v -timeout 25m
```

Expected:

- Terraform applies infrastructure
- Tests verify behavior
- Tests pass with clear output

If a test fails, that is **useful information**, not a problem.

---

## Common professional test patterns

### Pattern 1 — No-replacement guard

Run `terraform plan` after apply and assert:

```
No changes. Infrastructure is up-to-date.
```

This protects refactors.

---

### Pattern 2 — Tag assertions

Assert that resources include required tags like:

- `Env`
- `Stack`
- `ManagedBy`

This enforces organizational standards.

---

### Pattern 3 — Behavioral assertions

Example:

- publish an SNS message
- confirm it arrives in subscribed SQS queues

This tests **real behavior**, not configuration.

---

## Common beginner mistakes

### Mistake 1: Testing everything

Test **critical behavior**, not every attribute.

### Mistake 2: Sharing state across tests

Each test must be isolated to avoid flakiness.

### Mistake 3: Treating tests as optional

Tests are what make Terraform safe at scale.

---

## Exam relevance

Terratest itself is **not** on the Terraform Associate exam.

However, the _thinking_ this lab teaches is:

- how to reason about safe changes
- how to prevent regressions
- how Terraform fits into CI/CD systems

That mindset directly improves exam performance and real-world skill.

---

## Key takeaways

- Terraform correctness is more than “apply succeeded”
- Tests protect behavior and confidence
- Terratest enables safe refactors
- Professional Terraform teams test infrastructure
