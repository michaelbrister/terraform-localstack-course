# Lab 08 — Terraform Console and Expressions

## What this lab teaches you

Terraform Console lets you **interactively evaluate expressions**.

Concepts covered:

- Type inspection
- `for` expressions
- `try`, `can`, `lookup`

## Why this matters

Console mastery dramatically improves debugging speed.

## Exercises

Work through each prompt and predict the output before running it.

## Exam notes

Console-style expressions appear frequently in exam questions.

# Lab 08 — Terraform Console (Expressions, Types, and Debugging)

## What this lab teaches you

This lab teaches you how to use **Terraform Console** as a learning and debugging tool.

Terraform Console allows you to:

- evaluate expressions without applying infrastructure
- inspect types and values
- understand how Terraform interprets your configuration
- experiment safely without changing state

You will learn:

- how Terraform evaluates expressions
- how to inspect types and structures
- how to use `for` expressions
- how to safely handle optional or missing values with `try`, `can`, and `lookup`

This lab is critical for:

- debugging Terraform configurations
- understanding complex expressions
- answering many Terraform Associate exam questions
- gaining confidence without “trial-and-error applies”

---

## Mental model: Terraform Console is a calculator, not a deployer

Terraform Console **does not create, change, or destroy infrastructure**.

Think of it as:

> A read-only REPL (interactive shell) for Terraform expressions.

Terraform Console:

- reads your configuration
- evaluates expressions exactly as Terraform would during `plan`
- never touches real infrastructure

This makes it one of the **safest tools** in Terraform.

---

## When to use Terraform Console

You should reach for Terraform Console when:

- an expression feels confusing
- a plan result surprises you
- you are unsure what a `for` expression will return
- you want to test `try`, `can`, or `lookup`
- you want to inspect a variable or local value

Experienced Terraform users rely on Console heavily.

---

## Starting Terraform Console

From a directory with Terraform initialized:

```bash
terraform console
```

You will see a prompt:

```
>
```

Everything you type after this is an **expression**, not a command.

---

## Understanding types (very important)

Terraform is **strongly typed**, even if it doesn’t always feel like it.

Common types you will see:

- string
- number
- bool
- list
- map
- object

### Inspecting a value

Try:

```hcl
> var.env
```

Then:

```hcl
> type(var.env)
```

Understanding types explains many Terraform errors.

---

## For expressions (step by step)

Terraform `for` expressions transform collections.

Example:

```hcl
> [for k, v in var.buckets : k]
```

This means:

- iterate over a map
- return a list of keys

Try variations:

```hcl
> [for k, v in var.buckets : "${k}-${var.env}"]
> { for k, v in var.buckets : k => v.versioning }
```

---

## Filtering with for expressions

You can filter items using `if`:

```hcl
> [for k, v in var.buckets : k if v.versioning]
```

This returns only keys where versioning is enabled.

This same pattern is used heavily in real Terraform code.

---

## Safe access with `try`, `can`, and `lookup`

### `lookup`

Use when accessing a map with a default:

```hcl
> lookup(var.tags, "Env", "unknown")
```

### `try`

Use when values might not exist:

```hcl
> try(var.buckets["logs"].expire_days, null)
```

### `can`

Use to test whether an expression will succeed:

```hcl
> can(var.buckets["logs"].expire_days)
```

These functions prevent plan-time failures.

---

## Predict the result (before hitting Enter)

Before evaluating each expression:

1. Predict the type
2. Predict the value

Then compare Terraform’s result to your prediction.

This habit builds exam and production confidence.

---

## Guided exercises

### Exercise 1 — Inspect a complex variable

Evaluate:

```hcl
> var.buckets
> type(var.buckets)
```

Explain in your own words what this structure represents.

---

### Exercise 2 — Transform data

Create a list of bucket names with environment prefix.

Predict the output, then evaluate.

---

### Exercise 3 — Filter data

Return only buckets with versioning enabled.

Confirm the result matches your expectation.

---

### Exercise 4 — Handle missing values safely

Attempt to access a value that does not exist directly (observe the error).

Then use `try` or `lookup` to handle it safely.

---

## Common beginner mistakes

### Mistake 1: Thinking console changes infrastructure

It does not. Console is always safe.

### Mistake 2: Ignoring types

Most confusing Terraform errors are type-related.

### Mistake 3: Writing complex expressions without testing

Terraform Console exists to prevent this.

---

## Exam relevance

Terraform Associate questions frequently test:

- expression evaluation
- collection transformations
- safe handling of optional values
- understanding types

If you can reason through console expressions confidently,
these questions become straightforward.

---

## Key takeaways

- Terraform Console is a safe sandbox
- It evaluates expressions exactly like `plan`
- Types matter more than syntax
- Console mastery makes Terraform predictable
