# Drill 05 — Step 1: Establish the Baseline (Root Module Owns the Resource)

⏱️ **Timebox:** 5–8 minutes  
🎯 **Exam focus:** resource addresses, state ownership, refactor preparation

---

## What this step is teaching

This step establishes a **known-good baseline** before a refactor.

At this stage:

- A resource is defined **directly in the root module**
- Terraform state records the resource address accordingly
- No modules are involved yet

This step is intentionally simple, because **state accuracy at the start matters** for everything that follows.

---

## Why this matters (exam + real world)

Terraform Associate questions often test:

- how Terraform tracks resource addresses in state
- what happens when code is moved without updating state
- why refactors can cause unexpected destroys

In real environments, many outages happen because:

- code is refactored into a module
- Terraform is not told the resource “moved”
- Terraform proposes destroy + recreate

This step ensures you understand the _starting point_ before that mistake happens.

---

## Mental model: State tracks addresses, not files

Terraform does **not** care about:

- file names
- folder layout
- how pretty your code is

Terraform **does** care about:

- the full resource address  
  (example: `aws_s3_bucket.example`)

Right now, that address lives in the **root module**.

---

## Actions

Run the following commands:

```bash
terraform init
terraform apply -auto-approve
```

---

## Expected results

Terraform should report:

```
Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
```

Terraform state should now contain:

```bash
terraform state list
```

Expected:

```
aws_s3_bucket.example
```

This address is critical — it is what Terraform will look for in later steps.

---

## What must NOT happen

During this step:

- Do NOT introduce modules yet
- Do NOT rename the resource
- Do NOT delete state files
- Do NOT refactor “early”

This step is about creating a **clean baseline**.

---

## Verify your understanding (do not skip)

Answer these questions before moving on:

1. Where does Terraform record the resource’s identity?
2. What is the full address of the resource right now?
3. Why does Terraform not care which file the resource is in?

If you cannot answer these, stop and review before continuing.

---

## Success checkpoint

You have completed this step successfully if:

- the apply succeeded
- exactly one resource exists
- `terraform state list` shows the expected root-module address

You are now ready to proceed to **Step 2 — Move the Resource into a Module (Without Telling Terraform)**.
