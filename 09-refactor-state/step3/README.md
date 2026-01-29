# Step 3 — resource in root

Run:

```bash
terraform init
terraform apply -auto-approve
```

Expected: `Resources: 1 added`.

# Lab 09 — Step 3 of 5: Move State to Match the New Structure

## Where you are in the workflow

You have completed **Step 2** successfully.

At this point:

- Infrastructure exists
- Terraform state exists
- Terraform configuration has changed
- Terraform believes the old resource was destroyed and a new one must be created

This is an **unsafe situation** — but it is expected at this stage.

Your goal in this step is to **teach Terraform that the resource did not change — only its address did**.

---

## Why this step matters

This step demonstrates one of the most powerful professional Terraform capabilities:

> **You can change Terraform’s understanding of identity without touching infrastructure.**

Most Terraform outages during refactors happen because this step is skipped.

Instead of moving state, people:

- apply destroy/create plans
- cause downtime
- lose data

This step is how professionals avoid that outcome.

---

## What you are changing in this step

In this step, you will:

- leave the refactored code exactly as-is
- update Terraform **state** so it matches the new resource address

Important:

- Infrastructure must remain untouched
- Only Terraform’s memory will change

---

## What must be true before continuing

Before running any commands:

- Step 2 ended with a destroy/create plan
- You did NOT apply that plan
- You understand both:
  - the old resource address
  - the new resource address

If you cannot clearly identify those addresses, stop here and review the plan output.

---

## Actions for this step

You will use a state command to move identity.

Run:

```bash
terraform state mv \
  <old_resource_address> \
  <new_resource_address>
```

Use the exact addresses shown in the Step 2 plan output.

After moving state, run:

```bash
terraform plan
```

---

## Expected results

After `terraform state mv`:

- Terraform updates its internal state file
- No infrastructure changes occur

After `terraform plan`:

```
No changes. Infrastructure is up-to-date.
```

This is the **success signal** for this step.

---

## What must NOT happen

During this step:

- Do NOT run `terraform apply`
- Do NOT delete state files
- Do NOT edit state manually
- Do NOT accept any plan that destroys or recreates resources

If a destroy/create plan still appears after moving state:

- stop
- re-check the resource addresses
- correct the state move

---

## Verify your understanding (do not skip)

Answer these questions before continuing:

1. What resource address existed before the refactor?
2. What resource address exists now?
3. What did `terraform state mv` actually change?
4. Why did infrastructure remain untouched?

You should be able to answer these without guessing.

---

## Success checkpoint

You are ready to continue to **Step 4** only if:

- `terraform plan` shows no changes
- you did not apply anything
- you understand how state now maps to the new code structure

Proceed only when all three are true.
