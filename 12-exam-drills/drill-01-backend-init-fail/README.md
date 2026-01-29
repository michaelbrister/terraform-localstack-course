# Drill 01 — Backend init fails (10 min)

Goal:

- Fix backend config so `terraform init` succeeds.
- End with `terraform plan` working.

Run:

```bash
terraform init
```

Expected failure:

- cannot reach endpoint OR lock table not found

Fix rubric:

- endpoint must be `http://localhost:4566`
- dynamodb_table must match backend bootstrap output (e.g. `tf-course-lock-dev`)

Verify:

```bash
terraform init
terraform plan
```

Cleanup:

```bash
terraform destroy -auto-approve
```

# Drill 01 — Backend Initialization Failure (State & Backend Diagnostics)

⏱️ **Timebox:** 10 minutes  
🎯 **Exam focus:** Backends, state locking, initialization failures

---

## What this drill is testing

This drill simulates one of the most common Terraform exam and real-world failures:

> **Terraform cannot initialize its backend.**

Your job is to:

- diagnose _why_ `terraform init` is failing
- fix the backend configuration safely
- prove success with a clean plan

This drill is about **understanding backend configuration**, not trial-and-error fixes.

---

## Why this matters (exam + real world)

On the Terraform Associate exam, backend questions often test whether you understand:

- how Terraform stores state
- when initialization happens
- what Terraform needs _before_ it can plan or apply

In real environments, backend failures block:

- CI pipelines
- team workflows
- any further Terraform work

If `terraform init` fails, **nothing else matters yet**.

---

## Starting state (intentional failure)

You are starting with:

- a backend configuration that does **not** work
- no usable initialized backend
- no valid plan

This is intentional.

---

## First: predict the failure (do not skip)

Before running any commands, answer:

1. What does Terraform need during `init`?
2. Does Terraform read backend config before or after providers?
3. What kind of resources does a remote backend depend on?

Write your answers down.

---

## Reproduce the failure

Run:

```bash
terraform init
```

---

## What to look for in the error output

You should see an error indicating one of the following:

- Terraform cannot reach the backend endpoint
- The DynamoDB lock table does not exist
- The S3 backend bucket cannot be found

Key insight:

> Backend initialization happens **before** planning, validation, or apply.

---

## What must NOT happen

During this drill:

- Do NOT run `terraform apply`
- Do NOT comment out the backend
- Do NOT switch to local backend “just to make it work”

The goal is to fix the backend, not bypass it.

---

## Fix rubric (smallest safe corrections)

Use the following checklist:

### 1️⃣ Backend endpoint

- Must point to LocalStack:
  ```
  http://localhost:4566
  ```

### 2️⃣ Lock table name

- Must match the backend bootstrap output
- Example:
  ```
  tf-course-lock-dev
  ```

### 3️⃣ Region and credentials

- Must be consistent with LocalStack
- Dummy credentials are acceptable

Make the **minimal changes** required to satisfy these conditions.

---

## Verify success

After fixing the backend configuration, run:

```bash
terraform init
terraform plan
```

Expected:

- `terraform init` completes successfully
- `terraform plan` runs without backend errors

You do **not** need to apply infrastructure for this drill.

---

## Exam-style check (self-assessment)

You should be able to answer:

1. Why does Terraform require the backend during `init`?
2. What happens if the lock table is missing?
3. Why can’t Terraform “skip” backend initialization?
4. How would this failure appear in a CI pipeline?

If you can answer all four, you’re exam-ready on this topic.

---

## Cleanup

If you created any resources during testing:

```bash
terraform destroy -auto-approve
```

---

## Key takeaway

Backend failures are **blocking failures**.

A Terraform operator always:

- fixes backend issues first
- understands where state lives
- never proceeds until `terraform init` succeeds
