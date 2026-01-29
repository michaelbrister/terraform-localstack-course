# Drill 06 — Import and converge (12 min)

Create bucket out-of-band:

```bash
aws --endpoint-url=http://localhost:4566 s3 mb s3://tf-course-drill06-import
```

Import:

```bash
terraform init
terraform import aws_s3_bucket.import_me tf-course-drill06-import
terraform plan
```

Goal: make plan converge (likely tags). Apply once if needed.

Cleanup:

```bash
terraform destroy -auto-approve
aws --endpoint-url=http://localhost:4566 s3 rb s3://tf-course-drill06-import --force || true
```

# Drill 06 — Import and Converge (Adopt Existing Infrastructure Safely)

⏱️ **Timebox:** 12–20 minutes  
🎯 **Exam focus:** `terraform import`, state vs reality, convergence to a clean plan

---

## What this drill is testing

This drill simulates a very common professional Terraform task:

> A resource already exists in reality, but Terraform does not manage it yet.

Your job is to:

- create a resource outside Terraform (reality)
- import it into Terraform state (identity)
- adjust configuration until `terraform plan` is clean (converge)

This drill intentionally introduces a tag mismatch so that import alone is not sufficient.

This drill is not about “making the error go away.”  
It is about learning how Terraform _adopts_ existing resources safely.

---

## Why this matters (exam + real world)

Terraform Associate questions often test:

- what `terraform import` does and does not do
- how Terraform decides whether to create vs manage an existing resource
- how to reason about state vs reality mismatches

In production, import is used for:

- legacy infrastructure adoption
- partial Terraform migrations
- incident recovery after lost state
- consolidating infrastructure under IaC

Import is an operator skill.

---

## Mental model: Import teaches Terraform identity

> **Import does not create infrastructure.**  
> It teaches Terraform that an existing real resource corresponds to a resource address in state.

After import:

- Terraform state contains the resource
- Terraform can now plan changes against it

However:

- Terraform does not automatically update your configuration to match reality
- you must make the configuration converge

---

## Starting state (intentional setup)

In this drill:

- Reality will have an S3 bucket
- Terraform state will initially be empty (for that bucket)
- Terraform configuration will describe the bucket

Terraform will initially want to create it (because state is missing).
Your job is to correct that with import and convergence.

---

## First: predict the outcome (do not skip)

Before running any commands, answer:

1. What will `terraform plan` propose before import?
2. What will change after `terraform import`?
3. Which of the three is incorrect at the start?
   - configuration
   - state
   - reality

Write your answers down.

---

## Actions (do not rush)

### 1) Create the bucket out-of-band (reality)

```bash
aws --endpoint-url=http://localhost:4566 s3 mb s3://tf-course-drill06-import
```

At this point:

- The bucket exists in reality
- Terraform does not track it in state

---

### 2) Initialize Terraform

```bash
terraform init
```

---

### 3) Import the bucket into state

```bash
terraform import aws_s3_bucket.import_me tf-course-drill06-import
```

Key idea:

- You are linking a real resource to a Terraform resource address.

---

### 4) Converge the configuration

Now run:

```bash
terraform plan
```

At this point, you might see differences (often tags).
That is normal.

Your job is to make the plan converge to:

```
No changes. Infrastructure is up-to-date.
```

How to converge:

- If Terraform wants to change tags, decide:
  - enforce Terraform’s tags (apply), or
  - update config to match current reality and then apply.

---

## What must NOT happen

During this drill:

- Do NOT delete the bucket to “make Terraform happy”
- Do NOT delete the state file
- Do NOT assume import alone guarantees a clean plan

Import assigns identity. Convergence aligns configuration.

---

## Verify success

You are done when:

```bash
terraform plan
```

returns:

```
No changes. Infrastructure is up-to-date.
```

---

## Exam-style check (self-assessment)

You should be able to answer:

1. What did `terraform import` change (state, config, reality)?
2. Why can a plan still show changes after import?
3. When would you choose to accept drift vs enforce Terraform?
4. How is import related to `terraform state mv`?

---

## Cleanup

```bash
terraform destroy -auto-approve
aws --endpoint-url=http://localhost:4566 s3 rb s3://tf-course-drill06-import --force || true
```

---

## Key takeaway

Import is a **state operation**:

- it assigns identity in Terraform
- it does not create the resource

Convergence is a **configuration operation**:

- it aligns desired state with reality

Professional Terraform work is about managing both safely.
