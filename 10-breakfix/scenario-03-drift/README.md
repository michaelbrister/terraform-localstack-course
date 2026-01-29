# Drill D — drift detection and reconciliation

Run:

```bash
terraform init
terraform apply -auto-approve
```

Expected: bucket created with tag.

Create drift (out-of-band):

```bash
aws --endpoint-url=http://localhost:4566 s3api put-bucket-tagging   --bucket tf-course-drift-demo   --tagging 'TagSet=[{Key=ChangedBy,Value=cli}]'
```

Then:

```bash
terraform plan
```

Expected: Terraform detects drift and wants to change tags back.

Cleanup:

```bash
terraform destroy -auto-approve
```

# Lab 10 — Scenario 03: Drift (Reality Changed Outside Terraform)

## Where you are

You are continuing the Break/Fix sequence after **Scenario 02**.

At this point:

- Terraform configuration is valid
- Infrastructure exists and is tracked in Terraform state
- Terraform believes it is the source of truth

Your goal in this scenario is to learn what happens when **reality changes outside Terraform**.

---

## Why this scenario matters

Drift is one of the most common real-world Terraform problems.

Drift happens when:

- someone changes a resource in the cloud console
- a script changes a resource outside Terraform
- an automated system modifies configuration
- a “quick fix” is made and not recorded

The danger of drift is not just “differences exist” — it’s that:

- future applies may undo someone’s change unexpectedly
- teams lose trust in IaC
- production changes become hard to audit

Professionals learn to detect drift and choose the correct response.

---

## Mental model: State vs Reality

Terraform makes decisions from:

- configuration (desired state)
- state (Terraform’s memory)

If reality changes out-of-band:

- state becomes stale
- plan becomes surprising

In this scenario, your job is to restore alignment.

---

## What is intentionally broken

In this scenario:

1. Terraform creates a bucket with tags
2. You modify the bucket tags **outside Terraform**
3. Terraform detects drift during plan

This is a controlled simulation of “someone changed prod in the console.”

---

## First: predict the outcome (do not skip)

Before running any commands, answer:

1. After you change tags outside Terraform, what will `terraform plan` show?
2. Which of the three is wrong after the out-of-band change?
   - configuration
   - state
   - reality
3. What are your two safe options to resolve drift?

Write your answers down.

---

## Actions (observe drift safely)

### 1) Apply baseline (Terraform creates the resource)

Run:

```bash
terraform init
terraform apply -auto-approve
```

Expected:

- bucket exists
- tags include `ManagedBy = "terraform"`

---

### 2) Create drift out-of-band (change reality)

Run:

```bash
aws --endpoint-url=http://localhost:4566 s3api put-bucket-tagging \
  --bucket tf-course-drift-demo \
  --tagging 'TagSet=[{Key=ChangedBy,Value=cli}]'
```

Important:

- This overwrites the bucket’s tags in LocalStack
- Terraform state has not changed

---

### 3) Detect drift

Run:

```bash
terraform plan
```

---

## What to look for in the output

Terraform should propose changes to bring the resource back to what the configuration says.

Typical signals:

- a `~` (update in place)
- a diff in `tags` showing removal of `ChangedBy` and restoration of `ManagedBy`

Key lesson:

> Terraform is not “confused” — it is doing exactly what a source of truth should do.

---

## What must NOT happen

During this scenario:

- Do NOT assume drift means “Terraform is wrong”
- Do NOT apply blindly without deciding your intent
- Do NOT delete state to “make it match”

Drift requires a decision.

---

## Fix rubric (choose one safe resolution)

There are two professional resolutions to drift:

### Option A — Enforce Terraform desired state (revert drift)

Use this when:

- Terraform is authoritative
- out-of-band changes are not allowed

Action:

```bash
terraform apply -auto-approve
```

Result:

- Terraform resets tags back to the configuration

---

### Option B — Accept the drift (update code to match reality)

Use this when:

- the out-of-band change was correct
- you want Terraform to manage that change going forward

Action:

1. Update your Terraform configuration to include the new tag(s)
2. Run:
   ```bash
   terraform apply -auto-approve
   ```

Result:

- Terraform converges on the new desired state and plan becomes clean

---

## Verify your understanding (do not skip)

Answer these questions before continuing:

1. Why did Terraform propose changes after the out-of-band edit?
2. Which resolution did you choose, and why?
3. Why is “delete state” a bad drift response?
4. What would drift look like in production systems?

---

## Success checkpoint

You have completed this scenario successfully if:

- you can reproduce drift and detect it via `terraform plan`
- you reconciled it using either Option A or Option B
- `terraform plan` is clean afterward

You are now ready to proceed to **Scenario 04 — Locks and Partial Operations**.

---

## Cleanup

```bash
terraform destroy -auto-approve
```
