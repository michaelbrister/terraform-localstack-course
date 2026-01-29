# Step 1 — apply initial resource

Run:

```bash
terraform init
terraform apply -auto-approve
```

Expected: `Resources: 1 added`.

# Lab 09 — Step 1 of 5: Establish a Safe Baseline

## Where you are in the workflow

You are at the **starting point** of a multi-step refactor process.

At this stage:

- Infrastructure already exists
- Terraform state already exists
- No refactoring has happened yet

Your goal in this step is **not to change anything** — it is to prove that Terraform and reality are in agreement.

---

## Why this step matters

Professional Terraform refactors always begin the same way:

> **You do not refactor from an unstable baseline.**

If Terraform’s understanding of the world is already wrong:

- refactors become unsafe
- later steps become unpredictable
- mistakes are harder to diagnose

This step establishes trust between:

- configuration
- state
- real infrastructure

---

## What must be true before continuing

Before moving to Step 2, all of the following must be true:

- `terraform init` completes successfully
- `terraform plan` shows **no changes**
- You understand what resources exist and why

If any of these are not true, **stop here** and fix them before continuing.

---

## Actions for this step

Run the following commands from this directory:

```bash
terraform init
terraform plan
terraform apply -auto-approve
```

Yes — even though this is a refactor lab, we apply here intentionally
to ensure state and infrastructure are synchronized.

---

## Expected results

After `terraform plan`:

```
No changes. Infrastructure is up-to-date.
```

After `terraform apply`:

```
Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
```

This confirms:

- state was created correctly
- Terraform’s baseline is trustworthy

---

## What must NOT happen

During this step:

- No resources should be destroyed
- No unexpected resources should be created
- No errors should be ignored

If Terraform proposes a destroy or replace:

- **do not apply**
- investigate why before continuing

---

## Verify your understanding (do not skip)

Answer these questions before moving on:

1. What is the full resource address Terraform created?
2. Where is that address stored?
3. If you renamed the resource block now, what would Terraform plan?

You do not need to run commands to answer these.
This is about reasoning, not execution.

---

## Success checkpoint

You are ready to continue to **Step 2** only if:

- the plan is clean
- you can explain what exists
- you feel confident nothing unexpected happened

Proceed only when all three are true.
