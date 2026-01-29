
# Common Terraform Mistakes (and Why They Happen)

## Mistake: Using `count` for long-lived resources
Why it's bad:
- Index changes cause replacement
- Hard to reason about

Fix:
- Use `for_each` with stable keys

## Mistake: Editing state by hand
Why it's dangerous:
- Terraform loses trust in state

Fix:
- Use `terraform state` commands
