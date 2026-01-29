# Drill 04 — Optional Nested Blocks with `dynamic` (TTL Example)

⏱️ **Timebox:** 8–15 minutes  
🎯 **Exam focus:** `dynamic` blocks, optional nested blocks, conditional rendering

---

## What this drill is testing

This drill simulates a common Terraform pattern:

> A nested block is only valid if a value is provided, but the configuration always renders the block anyway.

Your job is to:

- reproduce the failure
- explain why Terraform/provider rejects it
- fix it using a `dynamic` block so the nested block is rendered **only when needed**
- prove the fix with a clean plan/apply behavior

This drill is about understanding **optional nested blocks**, not memorizing syntax.

---

## Why this matters (exam + real world)

Terraform Associate questions often test:

- when `dynamic` is required
- how to render optional nested blocks
- how Terraform builds final configuration during `plan`

In production, this pattern appears constantly:

- S3 lifecycle rules
- security group rules
- Kubernetes blocks
- Azure settings blocks

If you understand this drill, `dynamic` blocks become predictable.

---

## Starting state (intentional failure)

The configuration includes a nested block that always renders:

```hcl
ttl {
  attribute_name = var.ttl_attribute
  enabled        = true
}
```

When `var.ttl_attribute` is empty, the provider rejects it.

Terraform can’t partially create a block.  
So the fix is to make the entire block conditional.

---

## First: predict the failure (do not skip)

Before running any commands, answer:

1. What does Terraform do with nested blocks during plan?
2. Why is an “empty” value inside a block sometimes invalid?
3. Which of the three is wrong here?
   - configuration
   - state
   - reality

Write your answers down.

---

## Actions (reproduce the failure safely)

Run:

```bash
terraform init
terraform plan
```

Expected:

- plan or apply fails because `ttl_attribute` is invalid when empty
- Terraform stops early

---

## What must NOT happen

During this drill:

- Do NOT “fix” this by hardcoding a value
- Do NOT remove the TTL requirement entirely
- Do NOT apply repeatedly hoping it succeeds

The goal is to make the block optional in a clean, reusable way.

---

## Fix rubric (smallest safe correction)

You must change:

- from a static `ttl { ... }` block
- to a conditional `dynamic "ttl" { ... }` block

Use the standard optional-block pattern:

```hcl
dynamic "ttl" {
  for_each = var.ttl_attribute != "" ? [true] : []
  content {
    attribute_name = var.ttl_attribute
    enabled        = true
  }
}
```

Why the list?

- `[true]` means “render exactly one ttl block”
- `[]` means “render no ttl block”

This is the core `dynamic` pattern.

---

## Verify success

### 1) Plan should succeed with empty ttl_attribute

```bash
terraform plan
```

Expected:

- plan succeeds
- TTL block is omitted

### 2) Apply should succeed with TTL enabled

```bash
terraform apply -auto-approve -var ttl_attribute=ExpiresAt
```

Expected:

- apply succeeds
- TTL is enabled

### 3) Plan should be clean after apply

```bash
terraform plan
```

Expected:

```
No changes. Infrastructure is up-to-date.
```

---

## Exam-style check (self-assessment)

You should be able to answer:

1. Why can’t Terraform “partially” render a block?
2. Why is `[true]` vs `[]` the standard pattern for optional blocks?
3. When would you use `for_each` at the resource level instead of `dynamic`?
4. What other AWS resources use this same pattern?

---

## Cleanup

```bash
terraform destroy -auto-approve
```

---

## Key takeaway

Use `dynamic` when a **nested block** is optional.

If a nested block becomes invalid when an input is missing, conditionally render the entire block using:

- `[true]` → include the block once
- `[]` → omit the block entirely
