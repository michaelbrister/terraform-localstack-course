# Drill 10 — Dependency Cycle (Terraform Graph Debugging)

⏱️ **Timebox:** 10–18 minutes  
🎯 **Exam focus:** dependency graph reasoning, locals/outputs, “cycle” errors, safe refactors

---

## What this drill is testing

This drill simulates a common Terraform failure mode:

> Terraform cannot build a plan because your configuration creates a dependency cycle.

Your job is to:

- reproduce the cycle error
- understand _what Terraform is telling you_
- identify the cycle in plain English
- break the cycle with the smallest safe change
- prove success with a clean plan/apply

This drill is about understanding Terraform’s **dependency graph**, not memorizing an error string.

---

## Why this matters (exam + real world)

Terraform builds a graph of dependencies from your configuration.
If Terraform cannot determine a valid evaluation order, it stops.

On the Terraform Associate exam, you may see questions like:

- “Why does this configuration fail?”
- “Which change breaks the cycle?”
- “What does Terraform evaluate first?”

In real repos, cycles happen during refactors when:

- locals reference outputs that reference resources
- modules reference each other’s outputs incorrectly
- computed values depend on resources that depend on those values

The correct response is never “apply harder.”
It is to fix the graph.

---

## Mental model: Terraform must find an evaluation order

Terraform must decide:

- which values can be computed now
- which values are unknown until apply
- which resources depend on which values

A cycle means:

> “A depends on B, and B depends on A. I cannot start.”

---

## Starting state (intentional failure)

This scenario intentionally introduces a self-referential pattern such as:

- a `local` tries to read an `output`
- the `output` reads a resource attribute
- the resource uses that `local`

That creates the loop:

```
local.bucket_name → output.bucket_name → aws_s3_bucket.x.bucket → local.bucket_name
```

Terraform cannot evaluate it.

---

## First: predict the failure (do not skip)

Before running commands, answer:

1. What does Terraform need to compute the bucket name?
2. What does Terraform need to compute the output?
3. Where is the circular reference?

Write your answers down.

---

## Actions (reproduce the error safely)

Run:

```bash
terraform init
terraform plan
```

Expected:

- Terraform reports a **cycle error**
- Plan does not run

---

## What to look for in the output

Terraform typically prints a message that includes:

- the word “Cycle”
- a list of addresses / references involved

Key technique:

> Read the chain from top to bottom and restate it in plain English.

Example (conceptually):

- “local.bucket_name depends on output.bucket_name”
- “output.bucket_name depends on aws_s3_bucket.x”
- “aws_s3_bucket.x depends on local.bucket_name”

That is the cycle.

---

## What must NOT happen

During this drill:

- Do NOT run `terraform apply` until plan succeeds
- Do NOT delete state files (state is not the problem)
- Do NOT add random `depends_on` everywhere

Adding `depends_on` often hides understanding and can make the graph worse.

---

## Fix rubric (smallest safe correction)

Your goal is to break the cycle by making one side independent.

Choose one of these safe fixes:

### Option A — Make the local independent (recommended)

Instead of referencing an output, define the local directly:

```hcl
locals {
  bucket_name = "tf-course-drill10"
}
```

Now the resource can depend on the local safely, and the output can depend on the resource.

### Option B — Use an input variable

If the bucket name should be configurable:

```hcl
variable "bucket_name" {
  type    = string
  default = "tf-course-drill10"
}
```

Then use `var.bucket_name` in the resource.

### Option C — Remove the local entirely

If it adds no value, delete it.

---

## Verify success

After applying the fix, run:

```bash
terraform fmt
terraform validate
terraform plan
terraform apply -auto-approve
```

Expected:

- plan succeeds
- apply succeeds
- no cycle errors

---

## Exam-style check (self-assessment)

You should be able to answer:

1. What is Terraform’s dependency graph?
2. Why can a local reference create a cycle?
3. Why is `depends_on` not the right fix most of the time?
4. What is the safest way to break a cycle?

---

## Cleanup

```bash
terraform destroy -auto-approve
```

---

## Key takeaway

A dependency cycle is a logic error, not a runtime error.

A Terraform operator fixes cycles by:

- identifying the dependency chain
- breaking the loop with a small, clear change
- verifying the graph is valid with a successful plan
