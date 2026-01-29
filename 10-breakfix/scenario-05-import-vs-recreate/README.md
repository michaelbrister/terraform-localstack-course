# Lab 10 — Scenario 05: Import vs Recreate (Adopting Existing Infrastructure Safely)

## Where you are

You are completing the Break/Fix sequence after **Scenarios 01–04**.

At this point:

- You understand how Terraform tracks identity using state
- You know how to reason about config, state, and reality mismatches
- You have seen how dangerous blind destroy/create plans can be

Your goal in this scenario is to make a **professional decision**:

> Should Terraform _import_ existing infrastructure, or _recreate_ it?

---

## Why this scenario matters

In real environments, it is extremely common to encounter infrastructure that:

- already exists
- was created manually or by another tool
- is not yet managed by Terraform

A common mistake is to:

- delete the existing resource so Terraform can recreate it

This is often unnecessary, risky, and disruptive.

Professionals instead ask:

> “Can this infrastructure be safely adopted into Terraform?”

---

## Mental model: Import assigns identity, recreate replaces reality

This distinction is critical:

- **Import**
  - Updates Terraform _state_
  - Does NOT change infrastructure
  - Preserves data and uptime

- **Recreate**
  - Destroys existing infrastructure
  - Creates new infrastructure
  - Risks data loss and downtime

Most production scenarios should prefer **import**.

---

## What is intentionally broken

In this scenario:

- A resource exists in reality (created outside Terraform)
- Terraform configuration defines the same resource
- Terraform state does NOT track it

Terraform therefore believes:

> “This resource does not exist and must be created.”

Your task is to correct Terraform’s understanding safely.

---

## First: predict the outcome (do not skip)

Before running any commands, answer:

1. What will `terraform plan` propose initially?
2. Would applying that plan destroy anything?
3. Which of the three is currently incorrect?
   - configuration
   - state
   - reality

Write your answers down.

---

## Actions (observe the problem safely)

### 1) Create infrastructure outside Terraform

Run:

```bash
aws --endpoint-url=http://localhost:4566 s3 mb s3://tf-course-import-demo
```

At this point:

- The bucket exists
- Terraform does not know about it

---

### 2) Initialize Terraform

```bash
terraform init
```

---

### 3) Observe Terraform’s incorrect assumption

Run:

```bash
terraform plan
```

Terraform should propose:

- creating a bucket that already exists

This is expected given Terraform’s current state.

---

## What must NOT happen

During this scenario:

- Do NOT delete the existing bucket
- Do NOT apply a plan that recreates infrastructure
- Do NOT modify state files manually

Terraform is missing information — not wrong.

---

## Fix rubric (import is the smallest safe action)

The safest fix is to **teach Terraform about the existing resource**.

Run:

```bash
terraform import aws_s3_bucket.import_me tf-course-import-demo
```

This command tells Terraform:

> “This real bucket corresponds to this resource address.”

---

## Verify convergence

After import, run:

```bash
terraform plan
```

Expected:

```
No changes. Infrastructure is up-to-date.
```

If Terraform still proposes changes:

- update configuration arguments (tags, settings)
- re-run `terraform plan` until it is clean

---

## Verify your understanding (do not skip)

Answer these questions before finishing the lab:

1. Why did Terraform initially want to create the bucket?
2. What changed when you ran `terraform import`?
3. Why is import similar to `terraform state mv`?
4. When would recreation actually be the correct choice?

---

## Success checkpoint

You have completed this scenario successfully if:

- the existing resource is managed by Terraform
- no infrastructure was destroyed or recreated
- `terraform plan` is clean

---

## Key takeaways (end of Lab 10)

- Import fixes _state_, not infrastructure
- Recreate replaces _reality_
- Clean plans prove alignment
- Professional Terraform work favors safety and preservation

You have now completed **Lab 10 — Break/Fix** and practiced the most common real-world Terraform recovery scenarios.
