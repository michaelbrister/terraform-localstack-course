# Lab 04 — Dynamic Blocks and Optional Configuration

## What this lab teaches you

This lab shows how to create **optional nested blocks** using `dynamic`.

Concepts covered:

- `dynamic` blocks
- Conditional inclusion
- Complex object variables

## Why this matters

Many real Terraform resources have optional nested blocks.
Dynamic blocks let you avoid duplication while keeping flexibility.

## Exercises

1. Enable/disable a dynamic block via variables
2. Add multiple nested blocks via a list

## Exam notes

Understand when `dynamic` is required vs simple conditionals.

# Lab 04 — Dynamic Blocks and Optional Configuration

## What this lab teaches you

This lab teaches you how Terraform can build **optional nested blocks** using `dynamic`.

This is a key “intermediate Terraform” skill because many real Terraform resources have configurations like:

- “Add **zero or more** rules”
- “Add this nested block **only if** a value is provided”
- “Repeat this nested block **N times** from a list”

By the end of this lab you will be able to:

- Explain what a `dynamic` block is (and what it is not)
- Use `dynamic` to render **0, 1, or many** nested blocks
- Use conditional expressions to include blocks only when needed
- Recognize common `dynamic` anti-patterns

---

## Mental model: `dynamic` is not a loop that “runs”

If you are new to programming, this is important:

Terraform does not “run” a `dynamic` block like a `for` loop in code.

Instead, Terraform:

1. Evaluates expressions during **plan**
2. Generates the final configuration **structure**
3. Plans the difference between state and that structure

So a `dynamic` block is best thought of as:

> A template that Terraform expands into real nested blocks.

---

## Where `dynamic` is used

Terraform only needs `dynamic` when a **nested block** must be optional or repeated.

Common examples:

- S3 lifecycle rules (multiple `rule` blocks)
- Security group rules (multiple `ingress` / `egress` blocks)
- App Service settings / Azure rules / Kubernetes blocks (same concept)

In this lab, you’re using an S3 lifecycle configuration because it is a clear example of:

- multiple nested blocks (`rule`)
- optional nested blocks inside it (`filter`, `expiration`)

---

## The pattern used in this lab (high level)

You will see patterns like:

### 1) “Only create this resource if a list is non-empty”

```hcl
for_each = {
  for k, v in var.buckets : k => v
  if length(v.lifecycle_rules) > 0
}
```

This means:

- If a bucket has no lifecycle rules → Terraform does not create a lifecycle configuration for it
- If a bucket has rules → it gets one lifecycle configuration resource

### 2) “Create a nested block once per item”

```hcl
dynamic "rule" {
  for_each = each.value.lifecycle_rules
  content {
    # rule.value.<field> here
  }
}
```

This means:

- Terraform will generate one `rule { ... }` block per list element

### 3) “Create a nested block only if a value exists”

```hcl
dynamic "expiration" {
  for_each = try(rule.value.expire_days, null) != null ? [true] : []
  content {
    days = rule.value.expire_days
  }
}
```

This is the key idea:

- Terraform cannot create _partial_ blocks
- So we create either:
  - 1 item in a list (`[true]`) → block exists
  - 0 items in a list (`[]`) → block omitted

---

## Predict the plan (before running Terraform)

Before you run anything, answer these:

1. How many buckets will be created?
2. How many lifecycle configuration resources will be created?
3. For the buckets that have lifecycle rules:
   - how many `rule` blocks will Terraform generate?
4. For each rule:
   - will it have a `filter` block?
   - will it have an `expiration` block?

Write your answers down. Then run `terraform plan` and compare.

---

## Step-by-step workflow

Run the normal Terraform workflow:

```bash
terraform fmt
terraform init
terraform validate
terraform plan -out tfplan
terraform apply -auto-approve
```

Expected (high level):

- Buckets are created
- Lifecycle configuration exists only for buckets with rules
- No unexpected replacements

---

## Guided exercises

### Exercise 1 — Make a lifecycle rule optional

In `terraform.tfvars`, pick a bucket and remove all lifecycle rules.

**Predict:**

- What happens to the lifecycle configuration resource for that bucket?

Then run:

```bash
terraform plan
```

You should see the lifecycle configuration resource being removed (or never created) for that bucket.

---

### Exercise 2 — Add a second rule (multiple nested blocks)

Add a second lifecycle rule to the same bucket.

**Predict:**

- How many `rule` blocks will exist now?

Run:

```bash
terraform plan
```

Terraform should show a modification that adds an additional `rule` block.

---

### Exercise 3 — Toggle optional nested blocks

For a rule, remove `prefix` but keep `expire_days`.

**Predict:**

- Will the `filter` block still exist?

Then remove `expire_days` but keep `prefix`.

**Predict:**

- Will the `expiration` block still exist?

Run a plan after each change and confirm that blocks appear/disappear.

---

## Common anti-patterns (what not to do)

### Anti-pattern 1: Using dynamic blocks when a simple conditional works

If a field can be set to `null` and the provider treats it as “unset”,
you may not need a dynamic block.

### Anti-pattern 2: Using dynamic blocks to “generate resources”

Use `for_each` at the **resource** level to create multiple resources.
Use `dynamic` only inside a resource to create nested blocks.

### Anti-pattern 3: Deeply nested dynamic blocks

If you have dynamic blocks inside dynamic blocks inside dynamic blocks,
it becomes hard to reason about and debug.

At that point:

- consider splitting into separate resources
- or designing a cleaner module interface

---

## Exam relevance

Terraform Associate questions often test:

- Can you reason about what Terraform will create?
- Can you understand conditional rendering of config?
- Do you know the difference between `for_each` vs `dynamic`?

If you can correctly predict the plan for the exercises in this lab,
you’re in great shape for those questions.

---

## Key takeaways

- `dynamic` expands into nested blocks during plan
- You use `dynamic` for **0/1/many nested blocks**
- Use `for_each` to create resources, `dynamic` to create nested blocks
- The `[true]` vs `[]` pattern is how you make a block optional
