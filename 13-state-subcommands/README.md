# Lab 13 — Terraform State Commands

## What this lab teaches you

This lab explores **direct state manipulation commands**.

Concepts covered:

- `state list`
- `state show`
- `state mv`
- `state rm`

## Warning

These commands are powerful and dangerous.

## Exam notes

You must know what these commands do conceptually.

# Lab 13 — Terraform State Subcommands (Operator-Level Control)

⏱️ **Estimated time:** 30–45 minutes  
🎯 **Exam focus:** state inspection, safe state manipulation, refactors and recovery

---

## What this lab teaches you

This lab teaches you how to **inspect and manipulate Terraform state directly**.

State subcommands are:

- powerful
- sharp-edged
- sometimes the only safe way out of a bad situation

You are not expected to use these commands every day — but when you need them, you must understand them deeply.

This lab focuses on _when_ and _why_ to use state commands, not just syntax.

---

## Why this matters (exam + real world)

On the Terraform Associate exam, you will be tested on:

- what Terraform state represents
- how Terraform tracks resource identity
- how refactors affect state
- how to recover when configuration and state diverge

In real environments, state commands are used for:

- refactoring without downtime
- fixing accidental renames
- recovering from partial applies
- adopting or decommissioning resources safely

These commands are how operators fix mistakes **without destroying infrastructure**.

---

## ⚠️ Critical warning (read this)

Terraform state commands:

- bypass normal safety checks
- do **not** consult providers
- can permanently orphan resources if misused

Rule of thumb:

> If you are unsure, inspect state first.  
> Never manipulate state blindly.

---

## Mental model: State is Terraform’s memory

Terraform state answers one question:

> “Which real-world resource corresponds to which Terraform address?”

State:

- does NOT create infrastructure
- does NOT change infrastructure
- tells Terraform _what it believes exists_

State commands change Terraform’s **memory**, not reality.

---

## Commands covered in this lab

You will work with the following subcommands:

---

### 1️⃣ `terraform state list` — What does Terraform think exists?

Lists all resource addresses currently tracked:

```bash
terraform state list
```

Use this to:

- confirm resource addresses
- debug refactors
- validate imports or moves

**Exam tip:** Always check state addresses before refactoring.

---

### 2️⃣ `terraform state show` — What does Terraform know about a resource?

Displays all tracked attributes for a resource:

```bash
terraform state show aws_s3_bucket.example
```

Use this to:

- inspect IDs, ARNs, tags
- verify imported resources
- debug unexpected diffs

**Key insight:** This is Terraform’s view — not necessarily reality.

---

### 3️⃣ `terraform state mv` — Change identity safely

Moves a resource from one address to another:

```bash
terraform state mv aws_s3_bucket.old module.new.aws_s3_bucket.this
```

Use this when:

- refactoring into modules
- renaming resources
- reorganizing code structure

This is the **manual equivalent** of a `moved` block.

**Exam connection:** You should understand how `state mv` and `moved` relate.

---

### 4️⃣ `terraform state rm` — Stop managing a resource

Removes a resource from state **without destroying it**:

```bash
terraform state rm aws_s3_bucket.legacy
```

Use this when:

- decommissioning Terraform management
- handing resources to another tool
- preparing for manual deletion later

⚠️ Terraform will forget the resource entirely after this.

---

## What this lab is NOT teaching

This lab is not about:

- daily Terraform workflows
- replacing `apply` with state edits
- fixing broken configs with hacks

State commands are **last-resort or surgical tools**.

---

## Recommended workflow when something goes wrong

1. Run `terraform plan`
2. Identify whether the problem is:
   - configuration
   - state
   - reality
3. Inspect state with `state list` / `state show`
4. Choose the **least invasive** fix
5. Re-run `terraform plan` and verify safety

Never start with `state rm`.

---

## Exam-style self-check

You should be able to answer:

1. What does Terraform state represent?
2. When would you use `state mv` vs a `moved` block?
3. Why is `state rm` dangerous?
4. How can incorrect state lead to destroy/recreate plans?
5. Why do state commands not contact the provider?

If you cannot answer these, revisit earlier labs before moving on.

---

## Success criteria

You have completed this lab successfully if:

- you can explain each state command in plain English
- you know when each command is appropriate
- you understand how state manipulation affects identity
- you recognize when **not** to use these commands

At this point, you should think of Terraform state as a powerful tool —
not something to fear, but something to respect.

---

## Mini-Drill — Safe Resource Rename with `terraform state mv`

⏱️ **Timebox:** 10–15 minutes  
🎯 **Skill focus:** identity preservation, refactors without destroy/create

This mini-drill gives you **hands-on practice** using state subcommands safely.

You will:

- create a resource
- rename it in configuration
- observe a dangerous plan
- fix it using `terraform state mv`
- prove the plan is clean

This mirrors a very common real-world Terraform refactor.

---

### Scenario

You start with an S3 bucket defined like this:

```hcl
resource "aws_s3_bucket" "example" {
  bucket = "tf-course-state-mini"
}
```

Terraform state currently tracks:

```
aws_s3_bucket.example
```

You want to rename the resource to be more descriptive **without destroying the bucket**.

---

### Step 1 — Create the baseline

Run:

```bash
terraform init
terraform apply -auto-approve
```

Verify state:

```bash
terraform state list
```

Expected:

```
aws_s3_bucket.example
```

This confirms Terraform’s current understanding of identity.

---

### Step 2 — Rename the resource in configuration (danger step)

Update the configuration to:

```hcl
resource "aws_s3_bucket" "primary" {
  bucket = "tf-course-state-mini"
}
```

Now run:

```bash
terraform plan
```

Expected:

- Terraform proposes **destroy + create**
- This is the identity problem you have seen earlier in the course

🚫 **Do not apply.**

---

### Step 3 — Fix identity with `terraform state mv`

Run:

```bash
terraform state mv aws_s3_bucket.example aws_s3_bucket.primary
```

What this does:

- updates Terraform’s memory
- preserves the real bucket
- avoids replacement

No infrastructure is changed.

---

### Step 4 — Verify stability

Run:

```bash
terraform plan
```

Expected:

```
No changes. Infrastructure is up-to-date.
```

Verify state:

```bash
terraform state list
```

Expected:

```
aws_s3_bucket.primary
```

This confirms the refactor is complete.

---

### Cleanup

```bash
terraform destroy -auto-approve
```

---

### Mini-drill self-check

You should now be able to answer:

1. Why did Terraform want to destroy and recreate the bucket?
2. What exactly did `terraform state mv` change?
3. How is this similar to using a `moved` block?
4. When would you prefer a `moved` block over `state mv`?

---

### Key takeaway

If the resource stays the same but the **address changes**,  
you must move **identity**, not infrastructure.

Terraform will always choose destroy/create unless you tell it otherwise.
