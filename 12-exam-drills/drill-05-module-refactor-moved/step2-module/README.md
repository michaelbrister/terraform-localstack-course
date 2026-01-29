# Drill 05 — Step 2 (move into module without replacement) (15 min)

Run:

```bash
terraform init
terraform plan
```

Expected bad plan: destroy root bucket, create module bucket.

Fix rubric:
Add moved block:

```hcl
moved {
  from = aws_s3_bucket.root_bucket
  to   = module.b.aws_s3_bucket.this
}
```

Verify: plan shows no destroy/create.

Cleanup:

```bash
terraform destroy -auto-approve
```

# Drill 05 — Step 2: Move into a Module (Without Telling Terraform)

⏱️ **Timebox:** 10–15 minutes  
🎯 **Exam focus:** module refactors, state addresses, destroy/create trap, moved blocks

---

## Where you are in the workflow

You have completed **Step 1** successfully.

Right now:

- The bucket exists
- Terraform state tracks it in the root module address
- The configuration is about to change structure

Your goal in this step is to **trigger a dangerous plan on purpose** so you can learn how to prevent it.

---

## Why this step matters (exam + real world)

This is one of the most common production refactor mistakes:

> “I moved code into a module and Terraform wanted to destroy and recreate everything.”

Terraform is not being dramatic. It is doing exactly what you asked based on identity rules.

On the Associate exam, this appears as:

- “What happens when a resource is moved into a module?”
- “How do you prevent replacement?”
- “What does a moved block do?”

---

## What you are changing in this step

In this step, you change the configuration so that:

- The resource is now defined inside `module "b"`
- The root resource block no longer exists in code

From Terraform’s perspective:

- `aws_s3_bucket.root_bucket` disappeared
- `module.b.aws_s3_bucket.this` is a new resource

Terraform will therefore plan:

- destroy the root resource
- create the module resource

This is expected at this stage.

---

## First: predict the plan (do not skip)

Before running commands, answer:

1. What is the current state address of the bucket?
2. What will the new address be after moving into the module?
3. What will Terraform propose when a resource address disappears?

Write your answers down.

---

## Actions (observe the dangerous plan safely)

Run:

```bash
terraform init
terraform plan
```

---

## What to look for in the output

You should see a plan that includes:

- `-` destroy for `aws_s3_bucket.root_bucket`
- `+` create for `module.b.aws_s3_bucket.this`

This is the “destroy/create trap.”

Do not apply.

---

## What must NOT happen

During this step:

- Do NOT run `terraform apply`
- Do NOT “fix” the plan by undoing the refactor
- Do NOT delete state files

The point is to see the trap clearly.

---

## Fix preview (do not implement yet)

In the next step, you will fix this safely by adding a moved block:

```hcl
moved {
  from = aws_s3_bucket.root_bucket
  to   = module.b.aws_s3_bucket.this
}
```

That tells Terraform:

> “This is the same resource, just at a new address.”

---

## Success checkpoint

You have completed this step successfully if:

- you produced the destroy/create plan
- you did NOT apply it
- you can explain why Terraform proposed it

You are now ready for **Step 3**, where you will safely prevent replacement using `moved`.
