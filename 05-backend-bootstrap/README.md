# Lab 05 — Bootstrapping Remote State Infrastructure

## What this lab teaches you

This lab shows how to use Terraform to **create its own backend infrastructure**.

Concepts covered:

- S3 buckets for remote state
- DynamoDB for state locking
- Multi-environment backend patterns

## Why this matters

Terraform cannot manage remote state until the backend exists.
This lab teaches the safe bootstrapping pattern.

## Key warning

Backend infrastructure should be created once and rarely changed.

## Exam notes

Expect questions about:

- why remote state is important
- why locking matters

# Lab 05 — Bootstrapping Remote State Infrastructure

## What this lab teaches you

This lab teaches one of the **most critical and misunderstood Terraform concepts**:

> **Terraform state is just data — and it has to live somewhere.**

You will learn:

- What a Terraform backend actually is (and what it is not)
- Why remote state is required for teams
- How state locking prevents corruption
- How to safely bootstrap backend infrastructure using Terraform itself
- Why backend infrastructure is treated differently than “normal” resources

This lab is foundational for:

- multi-person Terraform usage
- CI/CD pipelines
- Terraform Cloud concepts
- passing the Terraform Associate exam

---

## Mental model: State is Terraform’s memory

Terraform does not “look at the cloud” to decide what exists.

Instead:

- **Configuration** = what you want
- **State** = Terraform’s memory of what exists
- **Plan** = difference between the two

If Terraform loses state, it does **not** lose infrastructure — it loses memory.

A backend is simply:

> The place where Terraform stores and locks its state file.

---

## Local state vs remote state

### Local state (what you’ve used so far)

- State file lives on your machine
- Only safe for:
  - learning
  - solo experimentation
- Dangerous for teams

Problems with local state:

- No locking
- Easy to overwrite
- Impossible to safely share

---

### Remote state (what you’re building here)

- State lives in shared storage (S3)
- Locking is handled separately (DynamoDB)
- Enables:
  - team collaboration
  - CI/CD pipelines
  - safe concurrent usage

Remote state does **not**:

- create infrastructure
- change how resources behave
- magically fix bad Terraform code

It only changes **where Terraform remembers things**.

---

## Why this lab feels “scary” (and why it shouldn’t)

Many beginners fear backends because:

- “If I break state, everything is gone”
- “I might destroy production”

Important reality:

- Terraform never deletes infrastructure because state is lost
- Worst case, Terraform cannot determine what exists
- Recovery is possible

This lab uses LocalStack so you can learn safely.

---

## What “bootstrapping” means in Terraform

Terraform needs a backend to store state.
But the backend infrastructure itself must exist first.

This creates a chicken-and-egg problem:

1. Terraform needs state storage
2. State storage needs Terraform to create it

The solution:

> **Create backend infrastructure with local state first, then switch.**

This lab demonstrates that pattern.

---

## What you are creating in this lab

You will create:

- An S3 bucket used **only** to store Terraform state
- A DynamoDB table used **only** for state locking

These resources:

- are shared
- change very rarely
- should not be deleted casually

This is why backend infrastructure is often separated into its own stack.

---

## Predict the plan (before running Terraform)

Before running `terraform plan`, answer:

1. How many resources will be created?
2. Are these application resources or infrastructure-for-Terraform?
3. Would deleting these resources destroy applications?

Write your answers down before continuing.

---

## Terraform workflow for this lab

Run the standard workflow:

```bash
terraform fmt
terraform init
terraform validate
terraform plan -out tfplan
terraform apply -auto-approve
```

Expected (high level):

- One S3 bucket created
- One DynamoDB table created
- No other resources affected

---

## Verifying backend resources (optional)

You can confirm creation using AWS CLI against LocalStack:

```bash
aws --endpoint-url=http://localhost:4566 s3 ls
aws --endpoint-url=http://localhost:4566 dynamodb list-tables
```

You should see:

- the backend bucket
- the lock table

---

## Common beginner mistakes (and how to avoid them)

### Mistake 1: Storing application data in the state bucket

The state bucket should only store Terraform state.

Never:

- store app files
- reuse the bucket for logging
- mix concerns

---

### Mistake 2: Frequently modifying backend infrastructure

Changing backend resources risks:

- state unavailability
- team disruption

Backend stacks should be:

- boring
- stable
- rarely touched

---

### Mistake 3: Confusing backend config with resources

The `backend` block:

- configures Terraform
- does not create resources

Resources create infrastructure.
Backends configure Terraform itself.

---

## Exam relevance

Terraform Associate questions often test:

- what a backend is
- why locking matters
- why remote state is required for teams
- how Terraform Cloud relates to remote state

If you can explain this lab without running commands,
you understand the concept well enough for the exam.

---

## Key takeaways

- State is Terraform’s memory
- A backend is where that memory lives
- Remote state enables safe collaboration
- Backend infrastructure is created once and rarely changed
- Bootstrapping with local state is the safe pattern
