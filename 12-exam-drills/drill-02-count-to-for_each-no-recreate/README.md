# Drill 02 — Count → for_each Without Recreation (Stable Identity Migration)

⏱️ **Timebox:** 12–20 minutes  
🎯 **Exam focus:** `count` vs `for_each`, identity, state moves (`terraform state mv`)

---

## What this drill is testing

This drill simulates a classic real-world incident:

> A configuration used `count` with a list, and a harmless reordering triggered a destructive plan.

Your job is to:

- reproduce the dangerous plan safely
- explain _why_ Terraform proposes replacement
- migrate the configuration to `for_each` using stable keys
- move state so **no buckets are destroyed or recreated**

This drill is about **identity**, not syntax.

---

## Why this matters (exam + real world)

Terraform Associate questions frequently test:

- what happens when `count` inputs change order
- why `for_each` is safer than `count`
- how Terraform decides identity

In production, this exact mistake causes:

- outages
- data loss (buckets/queues/tables)
- surprise replacements

A Terraform operator must be able to fix it without downtime.

---

## Starting state (intentional setup)

This drill assumes the configuration uses:

- `count` with `var.names` (a list)
- bucket names derived from list items
- identity stored as numeric indexes in state:
  - `aws_s3_bucket.b[0]`
  - `aws_s3_bucket.b[1]`
  - `aws_s3_bucket.b[2]`

That is the core problem.

---

## First: predict the failure (do not skip)

Before running any commands, answer:

1. How does Terraform identify `aws_s3_bucket.b[0]`?
2. What happens if `var.names` order changes?
3. Which of the three becomes incorrect after reordering?
   - configuration
   - state
   - reality

Write your answers down.

---

## Actions (reproduce the failure safely)

### 1) Create the baseline

```bash
terraform init
terraform apply -auto-approve
```

Expected:

- 3 buckets created
- state contains 3 instances of `aws_s3_bucket.b[...]`

Verify identity:

```bash
terraform state list
```

Expected:

- `aws_s3_bucket.b[0]`
- `aws_s3_bucket.b[1]`
- `aws_s3_bucket.b[2]`

---

### 2) Introduce the “harmless” change

Edit the default list order in `variables.tf` to:

- `["gamma","beta","alpha"]`

Now run:

```bash
terraform plan
```

---

## What to look for in the output

Terraform will propose destroy/create because indexes changed.

Key observation:

> With `count`, identity is the index, not the name.

So if `"alpha"` moves from index 0 to index 2, Terraform believes:

- `[0]` is now gamma (not alpha)
- therefore it must destroy and recreate

---

## What must NOT happen

During this drill:

- Do NOT run `terraform apply` after the destructive plan appears
- Do NOT “fix” this by changing the list back and pretending it never happened
- Do NOT delete state files

This drill is specifically about learning to repair identity safely.

---

## Fix rubric (smallest safe path)

Your fix must have **two parts**:

### Part A — Change configuration to stable identity (`for_each`)

1. Replace `count` with `for_each`
2. Convert list to a set:
   ```hcl
   for_each = toset(var.names)
   ```
3. Use `each.key` in naming so identity is key-based

After this change, Terraform addresses will look like:

- `aws_s3_bucket.b["alpha"]`
- `aws_s3_bucket.b["beta"]`
- `aws_s3_bucket.b["gamma"]`

### Part B — Move state addresses (avoid recreation)

Terraform state currently uses numeric addresses.
You must move them to key-based addresses.

Run:

```bash
terraform state mv aws_s3_bucket.b[0] aws_s3_bucket.b["alpha"]
terraform state mv aws_s3_bucket.b[1] aws_s3_bucket.b["beta"]
terraform state mv aws_s3_bucket.b[2] aws_s3_bucket.b["gamma"]
```

If your list started in a different order, adjust accordingly.

Tip:

- Use `terraform state show aws_s3_bucket.b[0]` to confirm which bucket name it maps to before moving.

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

Now reorder the list again and run plan again.

Expected:

- still clean plan (no replacements)

---

## Exam-style check (self-assessment)

You should be able to answer:

1. Why does `count` cause replacements when order changes?
2. Why is `for_each` stable even if order changes?
3. What did `terraform state mv` change (state, config, reality)?
4. What is the “operator rule” for preventing this incident?

---

## Cleanup

```bash
terraform destroy -auto-approve
```

---

## Key takeaway

If identity must be stable, **never** use `count` with an ordered list.

Use `for_each` with stable keys, and migrate safely using `terraform state mv`.
