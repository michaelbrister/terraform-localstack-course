# Lab 09 — Step 2 of 5: Change Code Only (Introduce a Dangerous Plan)

## Where you are in the workflow

You have completed **Step 1** successfully.

At this point:

- Infrastructure exists
- Terraform state exists
- Terraform has a clean, trusted baseline
- No refactoring has happened yet

Your goal in this step is **not** to fix anything.
Your goal is to **observe how Terraform reacts to a code-only refactor**.

---

## Why this step matters

This step demonstrates a critical professional lesson:

> **Changing Terraform code without updating state can be dangerous.**

Many real-world outages happen because someone:

- renamed a resource
- moved code into a module
- reorganized files

…and then immediately ran `terraform apply`.

This step exists so you can _see_ that danger **without causing damage**.

---

## What you are changing in this step

In this step, you will:

- rename or move a resource in code
- **not** update Terraform state yet

From Terraform’s perspective:

- the old resource address no longer exists
- a brand-new resource appears to be required

Terraform does not know this is the same infrastructure — yet.

---

## What must be true before continuing

Before running any commands:

- Step 1 ended with a clean plan
- No infrastructure changes are pending
- You understand which resource is being renamed or moved

If any of these are not true, stop and fix them before continuing.

---

## Actions for this step

Run the following commands:

```bash
terraform init
terraform plan
```

**Important:**  
Do **NOT** run `terraform apply` in this step.

This step intentionally produces a plan that looks unsafe.

---

## Expected results

Terraform will propose:

- destroying the old resource
- creating a new resource with the new address

You should see output similar to:

```
Plan: 1 to add, 1 to destroy
```

This is expected and intentional.

---

## What must NOT happen

During this step:

- Do NOT run `terraform apply`
- Do NOT try to “fix” the plan by changing code again
- Do NOT ignore destroy/create warnings

This plan is a **teaching tool**, not an instruction to apply.

---

## Verify your understanding (do not skip)

Answer these questions before continuing:

1. Why does Terraform think the old resource no longer exists?
2. What changed in the configuration that caused this plan?
3. Does Terraform believe this is the same infrastructure or a new one?
4. What would happen if you applied this plan in production?

You should be able to answer these without running more commands.

---

## Success checkpoint

You are ready to continue to **Step 3** only if:

- you saw a destroy/create plan
- you did NOT apply it
- you understand _why_ Terraform proposed it

Proceed only when all three are true.
