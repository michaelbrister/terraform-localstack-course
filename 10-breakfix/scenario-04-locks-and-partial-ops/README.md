# Drill C — lock contention

Two terminals in this folder.

Terminal A:

```bash
terraform init
terraform apply
```

Wait at prompt (do not type yes).

Terminal B:

```bash
terraform init
terraform plan
```

Expected: state lock error.

Fix:

- Understand why locking exists.
- Safest resolution is to let Terminal A finish or cancel cleanly.
- Only use `terraform force-unlock` if you are certain the lock is stale.

# Lab 10 — Scenario 04: Locks and Partial Operations (Why Terraform Protects State)

## Where you are

You are continuing the Break/Fix sequence after **Scenario 03**.

At this point:

- Terraform configuration is valid
- Infrastructure may already exist
- Terraform state is shared (or could be shared in real environments)

Your goal in this scenario is to understand **why Terraform uses locks** and how to recover safely from interrupted or concurrent operations.

---

## Why this scenario matters

State locking exists to prevent one of the most dangerous failures in Terraform:

> **Two operations modifying the same state at the same time.**

Without locking:

- state files become corrupted
- Terraform loses track of identity
- recovery becomes difficult or impossible

This scenario teaches you to recognize lock errors and respond **calmly and correctly**.

---

## Mental model: Locks protect state, not infrastructure

A Terraform lock:

- does **not** lock cloud resources
- does **not** block other people from viewing infrastructure
- **only** protects the state file

Think of a lock as:

> “Someone is currently updating Terraform’s memory.”

Until that finishes, no other operation should proceed.

---

## What is intentionally broken

In this scenario:

- One Terraform operation acquires the state lock
- A second operation attempts to run concurrently
- Terraform blocks the second operation to protect state

This simulates:

- two engineers running Terraform at the same time
- a CI pipeline overlapping with a manual run
- an interrupted apply that left a lock behind

---

## First: predict the outcome (do not skip)

Before running any commands, answer:

1. What will Terraform do when a second operation starts?
2. Will infrastructure change?
3. Which of the three is being protected here?
   - configuration
   - state
   - reality

Write your answers down.

---

## Actions (observe lock behavior safely)

### Terminal A — Acquire the lock

Open **Terminal A** in this scenario directory and run:

```bash
terraform init
terraform apply
```

When prompted:

- **do not** type `yes`
- leave the process waiting

At this point:

- Terraform has acquired the state lock
- No infrastructure changes have occurred yet

---

### Terminal B — Trigger lock contention

Open **Terminal B** in the same directory and run:

```bash
terraform init
terraform plan
```

---

## What to look for in the output

Terraform should fail with a lock error similar to:

- “Error acquiring the state lock”
- Includes:
  - Lock ID
  - Who holds the lock
  - When it was acquired

Key lesson:

> Terraform is preventing state corruption — this is good.

---

## What must NOT happen

During this scenario:

- Do NOT delete state files
- Do NOT immediately run `terraform force-unlock`
- Do NOT assume Terraform is stuck or broken

Lock errors are a **safety mechanism**, not a failure.

---

## Fix rubric (safest resolution first)

Always follow this order:

### Option 1 — Let the original operation finish

- Return to Terminal A
- Either:
  - complete the apply, OR
  - cancel cleanly (`Ctrl+C`)

This releases the lock safely.

---

### Option 2 — Confirm the lock is truly stale

Only consider this if:

- you are **certain** no Terraform process is still running
- the lock owner is gone (crash, terminated CI job)

Then (and only then):

```bash
terraform force-unlock <LOCK_ID>
```

Use this sparingly — it bypasses Terraform’s safety checks.

---

## Verify recovery

After resolving the lock:

```bash
terraform plan
```

Expected:

```
No changes. Infrastructure is up-to-date.
```

This confirms:

- state is intact
- no partial operations occurred

---

## Verify your understanding (do not skip)

Answer these questions before continuing:

1. Why does Terraform lock state but not infrastructure?
2. Why is `force-unlock` dangerous?
3. What could happen if two applies ran concurrently?
4. How does this apply to CI/CD pipelines?

---

## Success checkpoint

You have completed this scenario successfully if:

- you observed a lock contention error
- you resolved it without deleting or corrupting state
- Terraform returned to a clean plan

You are now ready to proceed to **Scenario 05 — Import vs Recreate**.
