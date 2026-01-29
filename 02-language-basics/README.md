# Lab 02 — Terraform Language Basics (Variables, Locals, Outputs)

## What this lab teaches you

This lab focuses on the **Terraform language itself**, independent of any cloud provider.
You will learn how Terraform evaluates expressions and passes data through a configuration.

Concepts covered:

- Input variables and defaults
- Type constraints
- Locals for reuse and clarity
- Outputs as public interfaces

## Key ideas

- Variables are inputs to a configuration
- Locals are computed values used internally
- Outputs expose selected values after apply

## What to pay attention to

- How changing a variable affects the plan
- How locals reduce duplication
- How outputs act like return values

## Exercises

1. Override a variable using `-var`
2. Override using a `.tfvars` file
3. Change a local and observe the plan

## Exam notes

Expect questions about:

- variable precedence
- when to use locals vs variables
- how outputs are consumed

# Lab 02 — Terraform Language Basics (Variables, Locals, Outputs)

## What this lab teaches you

This lab teaches you the **Terraform configuration language** — the part of Terraform you use
to describe _what you want_, not _how to do it_.

You will learn:

- What variables, locals, and outputs actually represent
- How Terraform evaluates expressions
- How data flows _through_ a Terraform configuration
- How small language choices affect plans and safety

This lab is critical for:

- understanding every Terraform file you will ever read
- predicting plans before running them
- passing Terraform Associate exam questions about variables and precedence

---

## Mental model: Terraform is declarative, not procedural

Terraform is **not** a programming language like Python or JavaScript.

You do not write steps like:

1. Create a bucket
2. Then tag the bucket

Instead, you describe the **desired end state**:

> “There should be a bucket with these properties.”

Terraform then:

- compares your configuration to state
- calculates the difference
- figures out the required actions

Everything in this lab exists to help you **describe desired state clearly**.

---

## Variables: inputs to your configuration

Variables are how you make Terraform **flexible and reusable**.

Think of variables as:

> Inputs provided _from outside_ the configuration.

Example:

```hcl
variable "env" {
  description = "Deployment environment name (dev, stage, prod)"
  type        = string
  default     = "dev"
}
```

Key ideas:

- Variables allow the same configuration to behave differently
- Defaults make variables optional
- Variables do not _do_ anything by themselves — they provide values

---

## Variable precedence (very important)

Terraform decides variable values using a **precedence order**.

From lowest to highest priority:

1. Variable defaults
2. `terraform.tfvars`
3. `*.auto.tfvars`
4. Environment variables (`TF_VAR_*`)
5. Command-line flags (`-var`, `-var-file`)

Higher levels override lower ones.

This means:

- CLI overrides everything
- Defaults are used only if nothing else is provided

This is commonly tested on the exam.

---

## Predict the plan (before running Terraform)

Before running `terraform plan`, answer:

1. What value will `var.env` have?
2. Where did that value come from (default, tfvars, CLI)?
3. If you change the variable, will Terraform:
   - add resources?
   - change resources?
   - replace resources?

Write your prediction down before running the plan.

---

## Locals: computed values inside the configuration

Locals are values **computed once** and reused.

Think of locals as:

> Named expressions that reduce duplication and clarify intent.

Example:

```hcl
locals {
  name_prefix = "tf-course-${var.env}"
}
```

Key ideas:

- Locals are not inputs
- Locals cannot be overridden
- Locals make configurations easier to read and maintain

If you find yourself repeating the same expression multiple times,
it probably belongs in a local.

---

## Outputs: exposing selected values

Outputs allow Terraform to **return values** after apply.

Think of outputs as:

> The public interface of your configuration.

Example:

```hcl
output "bucket_name" {
  value       = aws_s3_bucket.demo.bucket
  description = "Name of the S3 bucket created by this configuration"
}
```

Outputs are used to:

- show useful values to humans
- pass values between modules
- feed CI/CD pipelines

---

## What outputs are NOT

Outputs do not:

- create resources
- change infrastructure
- hide sensitive values from state (unless marked sensitive)

They simply expose values Terraform already knows.

---

## Step-by-step workflow

Run the standard workflow:

```bash
terraform fmt
terraform init
terraform validate
terraform plan
```

Observe:

- How variable values appear in the plan
- How locals expand into concrete values
- How outputs reference real resources

---

## Guided exercises

### Exercise 1 — Override a variable via CLI

Run:

```bash
terraform plan -var="env=stage"
```

**Predict:**

- What value will `var.env` have?
- How will that affect resource names or tags?

---

### Exercise 2 — Override via tfvars

Create a `terraform.tfvars` file:

```hcl
env = "prod"
```

Run:

```bash
terraform plan
```

**Predict:**

- Why did Terraform choose this value?
- Which precedence level applied?

---

### Exercise 3 — Modify a local

Change the local definition (for example, adjust a prefix).

**Predict:**

- Will resources be replaced?
- Or will values update in place?

Then run `terraform plan` and confirm.

---

## Common beginner mistakes

### Mistake 1: Overusing variables

If a value never changes between environments,
it does not need to be a variable.

### Mistake 2: Hardcoding values everywhere

This leads to duplication and brittle configurations.

### Mistake 3: Forgetting variable precedence

This often causes confusion when Terraform “ignores” a change.

---

## Exam relevance

Terraform Associate questions often test:

- variable precedence
- when to use locals vs variables
- how outputs are consumed
- how values flow through a configuration

If you can explain:

- where a value came from
- how Terraform chose it
- how changing it affects the plan

you are well prepared for these questions.

---

## Key takeaways

- Variables are **inputs**
- Locals are **computed helpers**
- Outputs are **exposed results**
- Terraform evaluates everything at plan time
- Understanding data flow is critical for safe Terraform
