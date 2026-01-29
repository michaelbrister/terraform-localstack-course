# Drill A — invalid bucket name

Run:

```bash
terraform init
terraform plan
```

Expected: error about invalid bucket name characters.

Fix:

- remove the `'` character
- rerun plan/apply

# Lab 10 — Scenario 01: Configuration Parse Error (Fail Fast, Read Carefully)

## Where you are

You are at the beginning of the Break/Fix lab sequence.

At this point:

- No infrastructure should be created yet
- Terraform state may or may not exist
- Terraform cannot even reach the planning phase

Your goal is **not** to fix infrastructure.
Your goal is to learn how to stop early and diagnose configuration errors correctly.

---

## Why this scenario matters

This scenario teaches an essential professional habit:

> **If Terraform cannot parse configuration, nothing else matters yet.**

In real work, many outages and wasted hours happen because people:

- ignore early error messages
- assume Terraform is “broken”
- jump ahead to state or apply steps too early

Professionals always fix **configuration correctness first**.

---

## What is intentionally broken

The Terraform configuration in this scenario contains an **invalid value**:

- an S3 bucket name that violates AWS naming rules
- the error is detectable _before_ planning or applying

This is a configuration-level problem, not a state or infrastructure problem.

---

## First: predict the outcome (do not skip)

Before running any commands, answer:

1. Will Terraform reach the planning phase?
2. Will Terraform create or destroy anything?
3. Which of the three is wrong here?
   - configuration
   - state
   - reality

Write your answers down.

---

## Actions (slow and deliberate)

Run the following commands:

```bash
terraform init
terraform plan
```

Do **not** skip directly to fixing the code.

---

## What to look for in the output

You should see an error similar to:

- invalid bucket name
- invalid characters
- configuration validation failure

Key observation:

> Terraform stops **before** proposing any plan.

This is expected and correct behavior.

---

## What must NOT happen

During this scenario:

- Do NOT run `terraform apply`
- Do NOT delete state files
- Do NOT assume this is a state or provider issue

Terraform is protecting you by failing early.

---

## Fix rubric (smallest safe action)

Ask yourself:

- What is the **minimal change** required to satisfy the provider?
- Can this be fixed without touching state or infrastructure?

Apply the fix:

- remove the invalid character from the bucket name
- keep everything else unchanged

Then re-run:

```bash
terraform plan
```

---

## Expected results after the fix

Terraform should now:

- initialize successfully
- produce a valid plan
- show **only create actions**, not destroys

Example:

```
Plan: 1 to add, 0 to change, 0 to destroy.
```

---

## Verify your understanding (do not skip)

Answer these questions before continuing:

1. Why did Terraform fail before planning?
2. Which layer was incorrect: configuration, state, or reality?
3. Why would running `apply` earlier have been a mistake?

---

## Success checkpoint

You have completed this scenario successfully if:

- Terraform reaches the planning phase
- The error is resolved with a minimal config change
- You can explain why no state or infrastructure was involved

You are now ready to proceed to **Scenario 02 — Identity Instability**.
