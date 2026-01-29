# Lab 03 — `for_each` Patterns and Stable Resource Addressing

## What this lab teaches you

This lab teaches how to **scale resources safely** using `for_each` instead of copy/paste.

Concepts covered:

- `for_each` with maps and sets
- Stable addressing vs `count`
- Filtering resources using expressions

## Why `for_each` matters

- Keys, not indexes, define identity
- Order changes do not cause replacement
- Essential for long-lived infrastructure

## Exercises

1. Add a new map entry and observe the plan
2. Remove an entry and observe destroy
3. Reorder entries and confirm no replacement

## Exam notes

Terraform exams strongly favor `for_each` over `count`.

# Lab 03 — Scaling Resources with `for_each` (Stable Identity)

## What this lab teaches you

This lab teaches one of the **most important Terraform concepts**:

> **How Terraform decides what a resource _is_.**

You will learn:

- How `for_each` creates multiple resources
- How Terraform assigns **identity** to resources
- Why `for_each` is safer than `count`
- How small data structure choices can cause **mass destruction** if done wrong

This lab is critical for:

- real production Terraform
- passing the Terraform Associate exam
- avoiding accidental deletes in real environments

---

## The core problem this lab solves

Imagine you want **multiple similar resources**:

- multiple S3 buckets
- multiple queues
- multiple subnets

You could copy/paste resource blocks…  
…but that does not scale and is error-prone.

Terraform gives you **loops**, but they work differently than traditional programming loops.

---

## Two ways to loop in Terraform (high level)

Terraform supports two main looping mechanisms:

| Method     | Identity                              | Risk    |
| ---------- | ------------------------------------- | ------- |
| `count`    | numeric index (`[0]`, `[1]`)          | ⚠️ High |
| `for_each` | stable key (`["logs"]`, `["images"]`) | ✅ Low  |

This lab focuses on **`for_each`**, because it is the correct default.

---

## How `for_each` works (conceptual)

When you write:

```hcl
for_each = {
  logs   = {}
  images = {}
}
```

Terraform does **not** think:

> “Create two resources.”

Terraform thinks:

> “Create one resource named `logs` and one resource named `images`.”

These keys become part of the resource **address**:

```
aws_s3_bucket.example["logs"]
aws_s3_bucket.example["images"]
```

This is the most important idea in this lab.

---

## Identity vs quantity (critical distinction)

❌ Quantity-based thinking:

> “I want 2 buckets.”

Terraform does _not_ care how many resources you want.

✅ Identity-based thinking:

> “I want a bucket named `logs` and a bucket named `images`.”

Terraform tracks **identity**, not count.

---

## The resource pattern used in this lab

```hcl
resource "aws_s3_bucket" "buckets" {
  for_each = var.buckets

  bucket = "tf-course-${each.key}"

  tags = {
    Name = each.key
    Env  = var.env
  }
}
```

Key ideas:

- `for_each = var.buckets` → one resource per key
- `each.key` → stable identity
- `each.value` → per-resource configuration

---

## Visualizing what Terraform sees

Given:

```hcl
buckets = {
  logs   = {}
  images = {}
}
```

Terraform internally tracks:

```
aws_s3_bucket.buckets["logs"]
aws_s3_bucket.buckets["images"]
```

If you add:

```hcl
backups = {}
```

Terraform plans **one add only**.

---

## Why `for_each` is safer than `count`

`count` uses numeric indexes.  
If ordering changes, Terraform thinks resources changed.

This leads to:

- replacement
- downtime
- accidental destruction

`for_each` avoids this by tying identity to keys.

---

## Exercises (do not skip)

### Exercise 1 — Add a resource

Add a new key and run `terraform plan`.

Expected:

```
Plan: 1 to add, 0 to change, 0 to destroy
```

### Exercise 2 — Remove a resource

Remove a key and run `terraform plan`.

Expected:

- Only that resource is destroyed.

### Exercise 3 — Reorder keys

Reorder entries and run `terraform plan`.

Expected:

- **No changes**

---

## Common beginner mistakes

- Using lists instead of maps for long-lived resources
- Using `count` because it feels simpler
- Not thinking about resource identity

---

## Exam relevance

On the Terraform Associate exam:

- `for_each` vs `count` is tested frequently
- Many questions are really about **identity**

If this lab makes sense, those questions become easy.

---

## Key takeaways

- Terraform tracks **identity**, not quantity
- `for_each` provides stable identity via keys
- Stable keys prevent accidental destruction
- `for_each` should be your default choice
