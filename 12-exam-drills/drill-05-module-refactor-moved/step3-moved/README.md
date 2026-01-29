# Drill 05 — Step 3: Prevent Replacement with a `moved` Block (Safe Refactor)

⏱️ **Timebox:** 10–15 minutes  
🎯 **Exam focus:** `moved` blocks, resource addresses, refactors without destroy/create

---

## Where you are in the workflow

You have completed **Step 2** successfully.

Right now:

- The bucket exists in reality
- Terraform state still tracks it at the _old_ address:
  - `aws_s3_bucket.root_bucket`
- Your configuration defines the same bucket at a _new_ address:
  - `module.b.aws_s3_bucket.this`

Terraform therefore believes:

> “The old resource must be destroyed and a new one must be created.”

Your job in this step is to correct Terraform’s understanding **without changing infrastructure**.

---

## Why this step matters (exam + real world)

This step teaches the **safe refactor pattern**.

In real systems:

- refactors happen constantly
- destroy/recreate during refactors causes outages
- data loss often happens _here_, not during initial creation

On the Terraform Associate exam, this appears as:

- “How do you move a resource into a module safely?”
- “What does a `moved` block do?”
- “When is a destroy/create plan incorrect?”

This step is the answer.

---

## Mental model: Addresses define identity

Terraform tracks **resource identity by address**.

When you moved the resource into a module:

- the _code_ moved
- the _address_ changed
- Terraform did **not** know they represent the same object

A `moved` block tells Terraform:

> “This address is the same resource as before.”

---

## Actions (apply the safe fix)

From this directory, run:

```bash
terraform init
terraform plan
```

---

## Expected results

After adding the `moved` block, Terraform should report:

```
No changes. Infrastructure is up-to-date.
```

This confirms:

- Terraform updated **state identity**
- No destroy or recreate is required
- Reality was left untouched

---

## What must NOT happen

During this step:

- Do NOT run a destroy/create apply
- Do NOT delete state files
- Do NOT remove the `moved` block prematurely

If the plan still shows replacement:

- double-check the `from` and `to` addresses
- they must exactly match state and configuration

---

## Verify state migration (recommended)

Inspect state directly:

```bash
terraform state list
```

Expected:

- `module.b.aws_s3_bucket.this`
- NOT `aws_s3_bucket.root_bucket`

This proves the identity move succeeded.

---

## Step 4 — Cleanup & Prove Stability (Do Not Skip)

This final step proves the refactor is _complete_ and _stable_.

### 1️⃣ Remove the `moved` block

Once Terraform state has been updated, the `moved` block is no longer needed.

Delete the `moved { ... }` block from `main.tf`.

---

### 2️⃣ Re-run Terraform

```bash
terraform plan
```

Expected:

```
No changes. Infrastructure is up-to-date.
```

This confirms:

- Terraform no longer needs the migration hint
- the configuration and state are fully aligned

---

### 3️⃣ Optional stability check (recommended)

Make a harmless change (for example, reorder files or re-run plan):

```bash
terraform plan
```

Expected:

- still no changes

This proves the refactor is complete and future plans are safe.

---

## Verify your understanding (do not skip)

Answer these questions before finishing Drill 05:

1. What did the `moved` block change — configuration, state, or reality?
2. Why is it safe to remove the `moved` block after the migration?
3. What would happen if you skipped the `moved` block entirely?
4. How is `moved` related to `terraform state mv`?

---

## Success checkpoint

You have completed Drill 05 successfully if:

- no destroy/create occurred during the refactor
- state now tracks the module address
- the `moved` block was removed cleanly
- `terraform plan` remains clean afterward

This is the professional pattern for Terraform refactors.
