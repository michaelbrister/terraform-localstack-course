# IAM policy guardrails (Policy-as-code example)

This repo is LocalStack-based, but the principle is production-grade:
**prevent overly broad IAM policies** in code review/CI.

## What the guardrail checks
If a Terraform `aws_iam_policy` contains any statement with:
- `Action: "*"` (or includes `"*"`)
AND
- `Resource: "*"` (or includes `"*"`)

…then CI should fail.

## Why this matters
This pattern is one of the most common real-world security failures:
it grants “admin-like” power unintentionally.

## Where it’s implemented
See `policy/iam.rego`.

## Extending it
- Require specific AWS services only
- Enforce condition blocks
- Enforce name/tag conventions
