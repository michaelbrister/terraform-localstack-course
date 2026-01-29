# Drill 08 — Stale lock recovery (10 min)

Terminal A:

```bash
terraform init
terraform apply
```

Ctrl+C after lock acquired.

Terminal B:

```bash
terraform plan
```

Expected: lock error with Lock ID.

If you're sure it's stale:

```bash
terraform force-unlock <LOCK_ID>
```

Cleanup:

```bash
terraform destroy -auto-approve
```

# Drill 08 — Stale Lock Recovery (State Locking Under Pressure)

⏱️ **Timebox:** 10–15 minutes  
🎯 **Exam focus:** state locking, concurrency, safe recovery, `force-unlock`

---

## What this drill is testing

This drill simulates a real-world Terraform situation:

> A Terraform run acquired a state lock and did not release it cleanly.

Your job is to:

- reproduce lock contention safely
- read the lock error carefully (including Lock ID)
- resolve the lock using the safest method first
- use `terraform force-unlock` only when it is truly appropriate
- restore the system to a clean, safe plan

This drill is about safety and judgment, not speed.

---

## Why this matters (exam + real world)

Terraform uses locks to prevent one of the worst failures in IaC:

> **Two operations modifying the same state at the same time.**

Without locking:

- state can become corrupted
- resource identity can be lost
- recovery becomes much harder

On the Associate exam, you may see questions about:

- what locking is for
- when it happens
- how to respond to lock errors

In production, lock errors are common when:

- two engineers run Terraform concurrently
- CI overlaps with manual runs
- a run crashes mid-operation

---

## Mental model: Locks protect state, not infrastructure

A lock:

- does **not** lock the cloud resource itself
- does **not** “freeze” infrastructure
- only prevents concurrent writes to Terraform’s state

Think of it as:

> “Terraform’s memory is currently being updated by someone else.”

---

## First: predict the outcome (do not skip)

Before running commands, answer:

1. What will happen when a second Terraform command runs while a lock is held?
2. Will infrastructure change as a result of the lock error?
3. Which of the three is being protected here?
   - configuration
   - state
   - reality

Write your answers down.

---

## Actions (reproduce lock contention safely)

You need **two terminals** in this directory.

### Terminal A — Acquire the lock

Run:

```bash
terraform init
terraform apply
```

When Terraform asks for confirmation:

- do **not** type `yes`
- leave it waiting at the prompt

At this point:

- Terraform has acquired the lock
- no infrastructure changes have happened yet

---

### Terminal B — Trigger the lock error

Run:

```bash
terraform init
terraform plan
```

Expected:

- Terraform fails with a lock error
- The error includes a **Lock ID**

---

## What must NOT happen

During this drill:

- Do NOT delete state files
- Do NOT edit state manually
- Do NOT immediately force-unlock without checking if the lock is stale
- Do NOT run multiple applies “until it works”

The lock is a safety feature.

---

## Fix rubric (safest resolution first)

### Option 1 — Release the lock normally (preferred)

Go back to Terminal A and do one of these:

- Cancel cleanly: `Ctrl+C` (and confirm if prompted), OR
- Finish the apply (type `yes`) if you want to proceed

Then rerun in Terminal B:

```bash
terraform plan
```

Expected: plan runs (no lock error).

---

### Option 2 — Force-unlock ONLY if the lock is stale

Use this only if you are certain:

- Terminal A is gone/crashed
- No other Terraform process is running
- This lock will never be released normally

Then run:

```bash
terraform force-unlock <LOCK_ID>
```

Why this is dangerous:

- If another process is still running, you can corrupt state.

---

## Verify success

After the lock is resolved:

```bash
terraform plan
```

Expected:

- no lock error
- the plan behaves normally

If you completed an apply, you may see “No changes” afterwards.
If you cancelled without applying, you may still see pending changes — that is fine for this drill.

The key is:

> Terraform can operate normally again and state is not corrupted.

---

## Exam-style check (self-assessment)

You should be able to answer:

1. Why does Terraform lock state but not infrastructure?
2. What information is included in a lock error message?
3. When is `terraform force-unlock` appropriate?
4. What is the risk of force-unlocking a non-stale lock?
5. How do locks relate to remote backends and CI pipelines?

---

## Cleanup

If you applied any infrastructure changes:

```bash
terraform destroy -auto-approve
```

---

## Key takeaway

Locks are a guardrail.

A Terraform operator:

- treats lock errors as a safety feature
- resolves locks safely (finish/cancel first)
- force-unlocks only when truly stale
- returns the system to a safe, predictable state
