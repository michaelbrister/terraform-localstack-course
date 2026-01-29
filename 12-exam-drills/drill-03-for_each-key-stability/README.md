# Drill 03 — Stable keys in flatten (10 min)

Run:

```bash
terraform init
terraform apply -auto-approve
```

Insert a queue in the middle by editing `variables.tf` default:

- queues = ["worker","metrics","audit"]

Then:

```bash
terraform plan
```

Expected bad plan:

- replacements due to index-key changes

Fix rubric:

- Make key stable: "${topic}|${qname}"
- Update for_each maps accordingly
- Use `terraform state mv` to preserve existing objects

Cleanup:

```bash
terraform destroy -auto-approve
```

# Drill 03 — Stable `for_each` Keys in Flattened Data (Prevent Surprise Replacement)

⏱️ **Timebox:** 10–18 minutes  
🎯 **Exam focus:** `for_each` key stability, flattening patterns, refactors without replacement

---

## What this drill is testing

This drill simulates a real production mistake:

> You used `for_each` (good), but you keyed resources using list indexes (bad), so inserting an item causes replacements.

Your job is to:

- reproduce the replacement plan safely
- explain _why_ Terraform thinks resources changed
- fix the keying strategy using stable composite keys
- (optionally) migrate state addresses so no replacement occurs

This drill teaches a subtle but critical idea:

> `for_each` is only stable if your keys are stable.

---

## Why this matters (exam + real world)

Terraform Associate questions often test:

- how `for_each` addresses resources
- what happens when keys change
- how to design stable identifiers

In production, unstable keys can:

- replace resources unexpectedly
- cause downtime (queues, subscriptions, rules)
- break integrations (ARNs/URLs change)

This is one of the most common “I used for_each but still broke prod” problems.

---

## Starting state (intentional setup)

This drill starts with a pattern like:

- a map of topics → list of queue names
- a `flatten([...])` to produce a list of `{topic, qname, key}`
- a `for_each = { for x in local.flattened : x.key => x }`

The **intentional bug**:

- the key is based on list index (e.g. `"events-0"`, `"events-1"`)
- inserting a new element shifts indexes and changes keys

---

## First: predict the failure (do not skip)

Before running any commands, answer:

1. What is the identity of a `for_each` resource instance?
2. If a key changes from `"events-0"` to `"events-1"`, what does Terraform assume?
3. Which of the three becomes incorrect after inserting the new queue?
   - configuration
   - state
   - reality

Write your answers down.

---

## Actions (reproduce the failure safely)

### 1) Apply the baseline

```bash
terraform init
terraform apply -auto-approve
```

Expected:

- resources are created
- state addresses include index-style keys like:
  - `aws_sqs_queue.q["events-0"]`
  - `aws_sqs_queue.q["events-1"]`
  - `aws_sns_topic_subscription.sub["events-0"]`
  - ...

Confirm what keys exist:

```bash
terraform state list | head -n 20
```

---

### 2) Trigger the instability

Edit `variables.tf` default and insert a queue in the middle:

- `queues = ["worker","metrics","audit"]`

Now run:

```bash
terraform plan
```

---

## What to look for in the output

You should see a plan that proposes replacements because keys changed.

Key observation:

> Terraform thinks the old instances were removed and new ones must be created because the keys changed.

Even if the real-world intent is “just add metrics,” the unstable keys cause Terraform to reshuffle identity.

---

## What must NOT happen

During this drill:

- Do NOT run `terraform apply` while replacement is proposed
- Do NOT “fix” this by putting the list back the old way and calling it done
- Do NOT delete state files

The goal is to learn stable key design and safe migration.

---

## Fix rubric (smallest safe correction)

### Step A — Use stable composite keys

Replace the unstable key (index-based) with a stable key like:

- `"${topic}|${qname}"`

Example:

```hcl
key = "${topic}|${qname}"
```

This guarantees:

- inserting an item does not change existing keys
- Terraform only adds one new resource for the new item

---

### Step B — (Optional but recommended) Preserve existing infrastructure using `terraform state mv`

If you already applied once with unstable keys, you can migrate state addresses so Terraform does not replace.

General approach:

1. Identify what each old key represents (topic + queue name)
2. Move state from old key to new stable key

Examples (adjust to match your actual topic/queue names):

```bash
terraform state mv 'aws_sqs_queue.q["events-0"]' 'aws_sqs_queue.q["events|worker"]'
terraform state mv 'aws_sqs_queue.q["events-1"]' 'aws_sqs_queue.q["events|audit"]'

terraform state mv 'aws_sns_topic_subscription.sub["events-0"]' 'aws_sns_topic_subscription.sub["events|worker"]'
terraform state mv 'aws_sns_topic_subscription.sub["events-1"]' 'aws_sns_topic_subscription.sub["events|audit"]'
```

Tip:

- Use `terraform state show <address>` to confirm which queue name each instance is tied to before moving it.

---

## Verify success

After fixing keys (and moving state if needed), run:

```bash
terraform plan
```

Expected:

- no replacements for existing items
- only one new queue/subscription for the new `metrics` entry

You should see something like:

- `Plan: 2 to add, 0 to change, 0 to destroy.`  
  (one queue + one subscription)

---

## Exam-style check (self-assessment)

You should be able to answer:

1. Why did inserting `"metrics"` cause replacements earlier?
2. What does Terraform use as identity for `for_each` resources?
3. Why is `"${topic}|${qname}"` stable when indexes are not?
4. When should you use `terraform state mv` during key refactors?

---

## Cleanup

```bash
terraform destroy -auto-approve
```

---

## Key takeaway

`for_each` only prevents replacement if your **keys are stable**.

Avoid index-based keys in flattened data.
Use stable composite keys (topic + queue name), and migrate state safely when refactoring.
