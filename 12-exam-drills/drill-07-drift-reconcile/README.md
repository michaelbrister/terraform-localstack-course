# Drill 07 — Drift Reconciliation (State vs Reality Decision)

⏱️ **Timebox:** 10–18 minutes  
🎯 **Exam focus:** drift, plan interpretation, “source of truth” decisions

---

## What this drill is testing

This drill simulates a classic real-world Terraform situation:

> Someone changed infrastructure outside Terraform, and now Terraform detects drift.

Your job is to:

- create a baseline resource managed by Terraform
- introduce drift out-of-band (simulate “changed in the console”)
- detect drift via `terraform plan`
- choose a safe resolution:
  - **revert** drift (Terraform remains the source of truth), or
  - **accept** drift (update code and converge)

This drill is not about “getting rid of the diff.”
It is about making a **deliberate decision** and restoring alignment.

---

## Why this matters (exam + real world)

Terraform Associate questions often test whether you understand:

- what drift is
- what Terraform will do when drift exists
- how to interpret “unexpected changes” in a plan
- how to reason about configuration/state/reality mismatches

In production, drift is dangerous because:

- future applies can undo emergency fixes unexpectedly
- audits become difficult (“who changed what?”)
- teams lose trust in IaC

Professional Terraform work means you can detect drift and respond intentionally.

---

## Mental model: Configuration vs State vs Reality

Terraform makes decisions from:

- **Configuration** (desired state)
- **State** (Terraform’s memory)

If reality changes outside Terraform:

- state becomes stale
- plan shows unexpected diffs

Your job is to decide whether:

- Terraform should enforce desired state, or
- desired state should be updated to match reality

---

## First: predict the outcome (do not skip)

Before running anything, answer:

1. After the out-of-band tag change, what will `terraform plan` show?
2. Which of the three becomes “wrong” after the out-of-band change?
   - configuration
   - state
   - reality
3. What are the two safe resolutions to drift?

Write your answers down.

---

## Actions (observe drift safely)

### 1) Create the baseline (Terraform is authoritative)

Run:

```bash
terraform init
terraform apply -auto-approve
```

Expected:

- Terraform creates the S3 bucket
- Tags match whatever is in your Terraform configuration

---

### 2) Introduce drift out-of-band (reality changes)

Run:

```bash
aws --endpoint-url=http://localhost:4566 s3api put-bucket-tagging \
  --bucket tf-course-drill07 \
  --tagging 'TagSet=[{Key=ChangedBy,Value=cli}]'
```

Important:

- This overwrites the bucket tag set in LocalStack
- Terraform state has not changed

---

### 3) Detect drift

Run:

```bash
terraform plan
```

---

## What to look for in the plan output

You should see Terraform propose an in-place update (`~`) to tags.

Typical signs:

- tags being removed/added
- Terraform attempting to restore tags from code

Key lesson:

> Terraform is doing exactly what a source of truth should do: enforce its desired state.

---

## What must NOT happen

During this drill:

- Do NOT delete state files
- Do NOT apply blindly without deciding your intent
- Do NOT assume Terraform is “wrong”

Drift requires a decision.

---

## Fix rubric (choose one safe resolution)

### Option A — Revert drift (Terraform remains source of truth)

Use when:

- out-of-band changes are not allowed
- Terraform should enforce the desired state

Action:

```bash
terraform apply -auto-approve
```

Result:

- Terraform reverts the drift and restores the original tags from code

---

### Option B — Accept drift (update desired state to match reality)

Use when:

- the out-of-band change was correct and should remain
- you want Terraform to manage that change going forward

Action:

1. Update your Terraform config to include the new tag:
   - `ChangedBy = "cli"`
2. Apply:

```bash
terraform apply -auto-approve
```

Result:

- Terraform converges on the new desired state and plan becomes clean

---

## Verify success

Run:

```bash
terraform plan
```

Expected:

```
No changes. Infrastructure is up-to-date.
```

---

## Exam-style check (self-assessment)

You should be able to answer:

1. Why did Terraform detect drift here?
2. What does Terraform use to decide what is “correct”?
3. When is it appropriate to accept drift instead of reverting it?
4. Why is deleting state a bad drift response?

---

## Cleanup

```bash
terraform destroy -auto-approve
```

---

## Key takeaway

Drift is not a Terraform bug — it is a mismatch.

A Terraform operator:

- detects drift with `plan`
- chooses a deliberate resolution (revert or accept)
- restores alignment until the plan is clean
