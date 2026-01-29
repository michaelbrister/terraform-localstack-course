
# How to Think in Terraform (for Non‑Programmers)

Terraform is **not programming** in the traditional sense.
You do not write instructions for *how* to do something.

Instead, you describe:
> **What you want the final world to look like.**

Terraform figures out the steps.

## Declarative vs Imperative

Imperative (scripts):
- Create bucket
- Then tag bucket
- Then check bucket exists

Declarative (Terraform):
- “There should be an S3 bucket with these properties”

Terraform:
- figures out if it exists
- figures out what must change
- applies the minimum difference

## Mental model
- Configuration = desired state
- State file = Terraform’s memory
- Plan = difference between them

If you understand this, Terraform becomes predictable.
