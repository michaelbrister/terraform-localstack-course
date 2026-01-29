# Lab 07 — Terraform Modules (Reuse, Interfaces, and Boundaries)

## What this lab teaches you

This lab teaches one of the **most important structural concepts in Terraform**:

> **Modules are how Terraform scales safely.**

You will learn:

- What a Terraform module actually is (and what it is not)
- How inputs and outputs form a **contract**
- How modules create clear ownership and boundaries
- How modules enable reuse without copy/paste
- How modules fit into multi-environment setups

This lab is critical for:

- writing maintainable Terraform
- working on real teams
- understanding most production Terraform repositories
- passing Terraform Associate exam questions about modules

---

## Mental model: A module is a function

If you have little or no programming background, use this analogy:

> **A Terraform module is like a function.**

- **Inputs** → function parameters
- **Outputs** → return values
- **Module internals** → implementation details
- **Caller** → code that uses the function

Just like a function:

- the caller should not care _how_ the module works
- the caller should only care _what it provides_ and _what it returns_

---

## Why modules exist (the real problem)

Without modules, Terraform code often becomes:

- large
- duplicated
- inconsistent
- hard to change safely

Example of duplication:

- the same S3 bucket logic repeated in dev, stage, prod
- small changes must be made in many places
- mistakes cause drift between environments

Modules solve this by giving you:

- **one place** to define behavior
- **many places** to reuse it safely

---

## What belongs in a module (and what does not)

### Good candidates for modules

- reusable infrastructure patterns
- resources that always belong together
- logic shared across environments

Examples:

- an application stack
- a messaging setup (SNS + SQS)
- a logging bucket with lifecycle rules

---

### What should NOT go in a module

- environment-specific values (like `env = "dev"`)
- backend configuration
- credentials or secrets
- assumptions about who is calling it

Modules should be **environment-agnostic**.

---

## The module structure in this lab

You will see a structure like:

```
modules/
  app_stack/
    main.tf
    variables.tf
    outputs.tf
```

This directory:

- defines reusable infrastructure
- does not know _where_ it will be deployed
- exposes only what callers need via outputs

---

## How a module is called

In a caller (for example `live/dev`):

```hcl
module "app" {
  source = "../../modules/app_stack"

  env     = var.env
  buckets = var.buckets
}
```

Key ideas:

- `source` tells Terraform where the module lives
- input variables configure behavior
- the module does not access caller variables directly

---

## Data flow through a module

Understanding data flow is essential.

1. Caller provides inputs
2. Module computes resources
3. Module exposes outputs
4. Caller can reference outputs

Example:

```hcl
output "bucket_names" {
  value = module.app.bucket_names
}
```

This makes modules composable and predictable.

---

## Predict the plan (before running Terraform)

Before running `terraform plan`, answer:

1. How many resources will the module create?
2. If you change a module input:
   - will resources be added?
   - updated?
   - replaced?
3. If two environments use the same module:
   - will they share state?

Write your answers down before running the plan.

---

## Step-by-step workflow

Run the standard Terraform workflow in a caller directory:

```bash
terraform fmt
terraform init
terraform validate
terraform plan
terraform apply
```

Observe:

- how module inputs affect resource names
- how outputs expose values
- how Terraform shows module paths in the plan

---

## Guided exercises

### Exercise 1 — Add a new module input

Add a new variable to the module (for example, an extra tag).

**Predict:**

- Will existing resources be replaced?
- Or updated in place?

Run `terraform plan` and confirm.

---

### Exercise 2 — Change module internals

Modify how a resource is named _inside_ the module.

**Predict:**

- Which environments are affected?
- Will this cause replacement?

Confirm via `terraform plan`.

---

### Exercise 3 — Add a new output

Expose a new value from the module.

**Predict:**

- Does this affect infrastructure?
- Or only Terraform outputs?

Confirm your prediction.

---

## Common beginner mistakes

### Mistake 1: Putting environment logic inside the module

This makes modules harder to reuse and test.

### Mistake 2: Exposing too many outputs

Expose only what callers actually need.

### Mistake 3: Treating modules as “magic”

Modules are just Terraform code with a boundary — nothing more.

---

## Exam relevance

Terraform Associate questions often test:

- what modules are used for
- how inputs and outputs work
- how modules affect plans
- how changes propagate to callers

If you can explain module behavior without running Terraform,
you are ready for those questions.

---

## Key takeaways

- Modules are the unit of reuse in Terraform
- Inputs and outputs form a contract
- Modules should be environment-agnostic
- Clear boundaries make Terraform safer and easier to maintain
