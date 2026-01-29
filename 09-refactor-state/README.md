# Lab 09 — Refactoring Without Destruction

## What this lab teaches you

This lab demonstrates how to **change code without changing infrastructure**.

Concepts covered:

- `moved` blocks
- `terraform state mv`
- Safe refactors

## Key takeaway

Resource addresses define identity, not resource names.

## Exam notes

Refactor/state questions separate beginners from experienced users.

# Lab 09 — Refactoring Terraform State Safely (Professional Workflow)

## What this lab is really about

This lab teaches one of the most important **professional Terraform skills**:

> **How to change Terraform code without breaking, replacing, or destroying real infrastructure.**

At this point in the course, you already know how to:

- create infrastructure
- scale resources
- use modules
- manage state safely

Now you are learning how to **change existing Terraform** — which is where most real-world risk lives.

This lab is intentionally structured as a **multi-step workflow**, not a single exercise.

---

## Mental model: Identity lives in state, not code

This is the core idea that everything in this lab builds on:

> **Terraform decides what a resource _is_ based on its state address, not its name.**

Changing:

- filenames
- module paths
- resource blocks
- variable structure

does **not** change infrastructure _by itself_.

What _does_ matter is:

- the **resource address stored in state**

This lab teaches you how to change code _and then update state_ so Terraform still knows which infrastructure is which.

---

## Why refactoring Terraform is dangerous (if you don’t understand this)

Many outages happen because someone:

- reorganized Terraform files
- renamed a resource
- moved code into a module

…and then ran `terraform apply` without understanding identity.

Terraform didn’t “break” anything — it did exactly what it was told.

This lab exists to make sure **you never do that in production**.

---

## How this lab is structured (important)

This lab is broken into **five ordered steps**.

You **must complete them in order**.

Each step:

- builds on the previous one
- assumes state is consistent
- ends with a clean plan before continuing

Skipping steps defeats the purpose of the lab.

---

## The five-step refactor workflow

### Step 1 — Establish a safe baseline

Confirm:

- Terraform plan is clean
- No drift exists
- State accurately reflects infrastructure

> We do not refactor from chaos.

---

### Step 2 — Change code only (do not apply)

Make structural code changes that would _normally_ cause replacement.

Observe:

- Terraform plans destroy/create
- Infrastructure has not changed yet

> This shows why refactors are dangerous without state updates.

---

### Step 3 — Move state to match the new structure

Use:

- `terraform state mv`
- or `moved` blocks

This step teaches Terraform:

> “This is the same resource — just with a new address.”

---

### Step 4 — Verify stability

Run `terraform plan` again.

Expected:

```
No changes. Infrastructure is up-to-date.
```

This is the success condition for refactoring.

---

### Step 5 — Prevent future mistakes

Learn:

- how to structure code to reduce refactor risk
- how tests and policy help
- how professionals approach Terraform changes

---

## Rules for this lab (do not skip)

Before starting:

- Always read the plan
- Never apply if Terraform wants to destroy production resources
- Stop if anything unexpected appears

During the lab:

- Do not “fix” errors by applying
- Use state tools deliberately
- Verify after every step

---

## Predict-before-you-run (critical habit)

Before every step, ask yourself:

- What will Terraform think exists?
- What resource addresses are changing?
- Will infrastructure change or only state?

Write your prediction down before running commands.

This habit is what separates safe operators from dangerous ones.

---

## Exam relevance

Terraform Associate questions often test:

- how Terraform tracks resource identity
- what happens when resources are renamed or moved
- the difference between refactoring code and changing infrastructure

If you can explain this lab in your own words,
you are operating at **professional Terraform level**.

---

## Key takeaways

- Terraform refactors are about **identity**, not names
- Infrastructure does not move unless you tell Terraform it should
- Clean plans before and after refactors are mandatory
- State tools are powerful and must be used deliberately

When you finish all five steps with no infrastructure changes,
you’ve learned one of the hardest Terraform skills correctly.
