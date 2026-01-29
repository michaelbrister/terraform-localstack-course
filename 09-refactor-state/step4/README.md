# Step 4 — move resource into module without replacement

Run:

```bash
terraform init
terraform plan
```

Expected: `No changes.` (the moved block should prevent replace).

Apply:

```bash
terraform apply -auto-approve
```

Expected: no destroy/create.

# Lab 09 — Step 4 of 5: Verify Stability After Refactor

## Where you are in the workflow

You have completed **Step 3** successfully.

At this point:

- Infrastructure still exists exactly as before
- Terraform configuration reflects the new structure
- Terraform state has been moved to match that structure
- Terraform should now believe everything is aligned

Your goal in this step is to **prove that the refactor is complete and safe**.

---

## Why this step matters

Professional Terraform refactors always end the same way they begin:

> **With a clean plan.**

This step exists to:

- rebuild trust after a dangerous intermediate state
- prove that identity was preserved correctly
- confirm no hidden changes remain

If this step does not end with a clean plan, the refactor is **not finished**.

---

## What you are verifying in this step

In this step, you are verifying that:

- Terraform sees the refactored configuration as canonical
- No destroy or create actions are required
- The refactor changed _structure_, not _infrastructure_

This is the moment where the refactor becomes “real.”

---

## What must be true before continuing

Before running commands:

- Step 3 ended with a clean plan
- No state commands are pending
- You understand what resource was moved and where it now lives

If any of these are not true, stop and review the previous steps.

---

## Actions for this step

Run the standard Terraform workflow:

```bash
terraform init
terraform plan
```

If (and only if) the plan is clean, apply:

```bash
terraform apply -auto-approve
```

Applying here is safe because no infrastructure changes are proposed.

---

## Expected results

After `terraform plan`:

```
No changes. Infrastructure is up-to-date.
```

After `terraform apply`:

```
Apply complete! Resources: 0 added, 0 changed, 0 destroyed.
```

This confirms:

- Terraform state and configuration agree
- The refactor is stable
- Infrastructure was not modified

---

## What must NOT happen

During this step:

- No resources should be destroyed or replaced
- No unexpected resources should be created
- No warnings should be ignored

If Terraform proposes any changes:

- stop
- do not apply
- investigate why before continuing

---

## Verify your understanding (do not skip)

Answer these questions before continuing:

1. Why is it safe to apply in this step?
2. What would it mean if Terraform proposed changes here?
3. How does this step mirror Step 1?

You should be able to answer these without running additional commands.

---

## Success checkpoint

You are ready to continue to **Step 5** only if:

- the plan is clean
- the apply resulted in zero changes
- you are confident the refactor preserved identity

Proceed only when all three are true.
