# Lab 09 — Step 5 of 5: Import Existing Infrastructure (Prevent Regression)

## Where you are in the workflow

You have completed **Steps 1–4** successfully.

At this point:

- You understand how Terraform tracks identity using state
- You have safely refactored code without changing infrastructure
- You have proven that a clean plan is the end state of safe refactors

This final step expands that skill set to a closely related professional task:

> **Bringing existing, unmanaged infrastructure under Terraform control.**

---

## Why this step matters

In real environments, you will often encounter infrastructure that:

- already exists
- was created manually or by another tool
- is not yet managed by Terraform

Professional Terraform users must know how to:

- adopt existing infrastructure safely
- avoid destroying or recreating it
- align state and configuration deliberately

This step teaches that skill and reinforces the same identity concepts used in refactoring.

---

## Mental model: Import assigns identity, it does not create resources

This is the key idea for this step:

> **`terraform import` does not create infrastructure — it teaches Terraform what already exists.**

Import:

- adds an entry to Terraform state
- links an existing real-world resource to a Terraform resource address
- does not change the resource itself

Just like refactoring, import is about **state alignment**, not infrastructure changes.

---

## What you are doing in this step

In this step, you will:

1. Create an S3 bucket **outside of Terraform**
2. Define a matching Terraform resource block
3. Import the existing bucket into Terraform state
4. Verify Terraform converges to a clean plan

This is the same identity workflow you practiced earlier — just in reverse.

---

## What must be true before continuing

Before starting this step:

- Steps 1–4 completed successfully
- You are comfortable identifying resource addresses
- You understand that import modifies state only

If any of these are unclear, review earlier steps before continuing.

---

## Actions for this step

### 1) Create infrastructure out-of-band

Create a bucket without Terraform:

```bash
aws --endpoint-url=http://localhost:4566 s3 mb s3://tf-course-import-me
```

At this point:

- Infrastructure exists
- Terraform state does not know about it

---

### 2) Initialize Terraform

```bash
terraform init
```

---

### 3) Import the existing resource

Run:

```bash
terraform import aws_s3_bucket.import_me tf-course-import-me
```

This command tells Terraform:

> “The real bucket named `tf-course-import-me` corresponds to this resource address.”

---

### 4) Verify convergence

Run:

```bash
terraform plan
```

---

## Expected results

After `terraform import`:

- Terraform state includes the bucket
- No infrastructure changes occur

After `terraform plan`:

```
No changes. Infrastructure is up-to-date.
```

This confirms:

- Terraform state matches reality
- Configuration accurately describes the resource
- No replacement is required

---

## What must NOT happen

During this step:

- Terraform must not propose destroying the bucket
- Terraform must not propose recreating the bucket
- You must not run `terraform apply` to “fix” mismatches

If Terraform proposes changes:

- stop
- inspect the resource arguments
- update configuration to match reality

---

## Verify your understanding (do not skip)

Answer these questions before finishing the lab:

1. What did `terraform import` change?
2. Where is the imported resource identity stored?
3. Why is import similar to `terraform state mv`?
4. What would happen if you deleted the state entry?

You should be able to answer these without running more commands.

---

## Success checkpoint

You have successfully completed **Lab 09** if:

- the imported resource converges to a clean plan
- no infrastructure was destroyed or recreated
- you understand how Terraform adopts existing resources

---

## Key takeaways (end of Lab 09)

- Terraform identity lives in state
- Refactors and imports are both state operations
- Clean plans are the proof of safety
- Professional Terraform work is about alignment, not recreation

You now have the core skills required to safely refactor and adopt infrastructure in real Terraform environments.
