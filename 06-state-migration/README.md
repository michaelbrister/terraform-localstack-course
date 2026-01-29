# Lab 06 — Migrating Terraform State (Local → Remote Backend)

## What this lab teaches you

This lab teaches one of the **most sensitive and high‑impact Terraform operations**:

> **Changing where Terraform stores its state without changing infrastructure.**

You will learn:

- What _state migration_ actually means (and what it does NOT mean)
- How Terraform detects backend changes
- How `terraform init -migrate-state` works step by step
- Why state migration is safe when done correctly
- How to reason about risk during state operations

This lab builds directly on **Lab 05 (Backend Bootstrap)** and is essential for:

- moving from solo Terraform usage to team usage
- CI/CD pipelines
- Terraform Cloud workflows
- passing Terraform Associate exam questions about state

---

## Mental model: Terraform never “moves” infrastructure

This is the single most important idea in this lab:

> **Terraform does not move, copy, or recreate infrastructure during state migration.**

What Terraform migrates is:

- the **state file**
- Terraform’s _memory_ of what exists

Infrastructure stays exactly where it is.

If you understand this, state migration becomes much less scary.

---

## Why state migration exists

You usually start Terraform with **local state** because:

- it’s simple
- it requires no setup
- it’s perfect for learning and experimentation

But eventually you need:

- shared state
- locking
- CI/CD access

That means switching to a **remote backend**.

State migration is how you do that **without destroying anything**.

---

## What triggers a state migration

Terraform decides a migration is needed when:

- the `backend` configuration changes
- Terraform detects that state exists in a different location

This typically happens when you:

- add a backend block for the first time
- change backend settings (bucket, key, region, etc.)

Terraform does **not** automatically migrate state.
You must explicitly approve it.

---

## Predict the migration (before running Terraform)

Before running anything, answer:

1. Where is Terraform state stored _right now_?
2. Where will it be stored _after_ migration?
3. Will any resources be recreated?
4. What would happen if migration failed halfway through?

Write your answers down before continuing.

---

## The migration command (what actually happens)

You will run:

```bash
terraform init -migrate-state
```

During this process, Terraform:

1. Reads the **existing state** from the old backend (local)
2. Writes the state to the **new backend** (S3)
3. Updates its internal backend configuration
4. Confirms success before proceeding

If Terraform cannot safely migrate state, it stops.

---

## Step-by-step workflow

### 1) Confirm current state

Before migration, confirm:

- Terraform plan is clean
- No pending changes exist

```bash
terraform plan
```

You should see:

```
No changes. Infrastructure is up-to-date.
```

This is important: migrations should start from a stable state.

---

### 2) Update backend configuration

Add or modify the backend block to point to:

- S3 bucket
- DynamoDB lock table

This does **not** create infrastructure.
It only tells Terraform where state should live.

---

### 3) Initialize with migration

Run:

```bash
terraform init -migrate-state
```

Terraform will:

- detect backend change
- ask for confirmation
- migrate state if approved

Read the prompts carefully.

---

### 4) Verify migration success

After init completes:

```bash
terraform plan
```

Expected:

```
No changes. Infrastructure is up-to-date.
```

This confirms:

- state was migrated
- Terraform still recognizes existing resources
- no infrastructure was recreated

---

## What could go wrong (and why it’s still safe)

### Scenario 1: Migration fails before completion

- State remains in the old backend
- No infrastructure is changed
- You can retry safely

### Scenario 2: Migration completes, but plan shows changes

- This usually indicates:
  - backend mismatch
  - environment mismatch
  - accidental config drift
- Stop and investigate before applying

### Scenario 3: You interrupt Terraform mid-migration

- Terraform uses locks to prevent corruption
- State remains consistent
- Recovery is possible

---

## Common beginner mistakes

### Mistake 1: Migrating with pending changes

Always migrate from a **clean plan**.
Never mix migration with infrastructure changes.

### Mistake 2: Editing state files manually

Manual state edits bypass safety checks and can cause corruption.

### Mistake 3: Panicking and deleting state

Deleting state does not delete infrastructure — but it creates confusion.
Pause, inspect, and recover instead.

---

## Exam relevance

Terraform Associate questions often test:

- what triggers state migration
- whether migration recreates resources
- the purpose of `-migrate-state`
- differences between backend config and resources

If you can explain _why_ migration is safe,
you can answer these questions confidently.

---

## Key takeaways

- State migration moves **Terraform’s memory**, not infrastructure
- Terraform requires explicit approval to migrate
- A clean plan before and after migration is the safety check
- Migration is a normal, expected part of Terraform workflows
