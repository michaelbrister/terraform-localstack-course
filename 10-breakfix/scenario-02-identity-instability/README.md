# Lab 10 — Scenario 02: Identity Instability (Why `count` Can Destroy Everything)

## Where you are

You are continuing the Break/Fix sequence after **Scenario 01**.

At this point:

- Terraform configuration is valid
- Infrastructure can be created successfully
- Terraform state already exists
- A change in _inputs_ will trigger this failure

Your goal in this scenario is **not** just to fix the code —  
it is to understand **why Terraform thinks replacement is required**.

---

## Why this scenario matters

This scenario teaches one of the most important Terraform concepts:

> **Resource identity must be stable across runs.**

Many real-world outages happen because:

- `count` is used with ordered lists
- list ordering changes
- Terraform interprets this as “everything changed”

This scenario explains _why_ that happens and how to prevent it permanently.

---

## What is intentionally broken

The configuration uses:

- `count` with a list (`var.names`)
- implicit numeric identity (`[0]`, `[1]`, `[2]`)

When the list order changes, Terraform believes:

- resource `[0]` is no longer the same resource
- all resources must be destroyed and recreated

This is an **identity problem**, not a bug.

---

## First: predict the outcome (do not skip)

Before running any commands, answer:

1. How does Terraform identify each resource instance?
2. What happens when list ordering changes?
3. Which of the three is wrong here?
   - configuration
   - state
   - reality

Write your answers down.

---

## Actions (observe the failure safely)

### 1) Create baseline infrastructure

Run:

```bash
terraform init
terraform apply -auto-approve
```

Expected:

- Three S3 buckets are created
- Terraform state tracks them as:
  - `aws_s3_bucket.example[0]`
  - `aws_s3_bucket.example[1]`
  - `aws_s3_bucket.example[2]`

---

### 2) Introduce identity instability

Edit `terraform.tfvars` and reorder the list:

```hcl
names = ["c", "b", "a"]
```

Now run:

```bash
terraform plan
```

---

## What to look for in the output

Terraform will propose:

- destroying all existing buckets
- creating new ones

Even though:

- the _names_ are the same
- only the _order_ changed

This is expected behavior when using `count`.

---

## What must NOT happen

During this scenario:

- Do NOT run `terraform apply`
- Do NOT accept mass replacement plans
- Do NOT assume Terraform is “wrong”

Terraform is behaving correctly based on the identity model you gave it.

---

## Fix rubric (smallest safe action)

Your goal is to give Terraform **stable identity**.

### Required changes:

- Replace `count` with `for_each`
- Convert the list to a set to remove ordering
- Use `each.key` for naming

Example pattern:

```hcl
for_each = toset(var.names)
bucket   = each.key
```

This gives Terraform:

- stable keys
- order-independent identity

---

## Verify the fix

After updating the configuration:

```bash
terraform plan
```

Expected:

```
No changes. Infrastructure is up-to-date.
```

Now reorder the list again and re-run `terraform plan`.

The plan should remain clean.

---

## Verify your understanding (do not skip)

Answer these questions before continuing:

1. Why did Terraform want to replace everything earlier?
2. What changed when switching from `count` to `for_each`?
3. Where does Terraform now store identity?
4. Why does list ordering no longer matter?

---

## Success checkpoint

You have completed this scenario successfully if:

- Reordering inputs causes **no replacements**
- Terraform plans remain stable
- You can explain the difference between numeric and key-based identity

You are now ready to proceed to **Scenario 03 — Drift**.
