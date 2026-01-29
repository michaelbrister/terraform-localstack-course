# Lab 10 — Break/Fix: How to Debug Terraform Safely

## What this lab is really about

This lab teaches one of the most important **professional Terraform skills**:

> **How to stay calm, reason clearly, and recover safely when Terraform breaks.**

In real-world Terraform work:

- things go wrong
- plans fail
- applies error halfway through
- state and reality drift apart

This lab is not about memorizing fixes.  
It is about learning a **repeatable troubleshooting mindset**.

---

## Mental model: Every Terraform problem is a mismatch

Every Terraform failure can be reduced to a mismatch between **three things**:

1. **Configuration** — what your code says should exist
2. **State** — what Terraform believes exists
3. **Reality** — what actually exists in the cloud

Break/Fix work is simply figuring out:

> _Which of these three is wrong — and how to realign them safely._

This mental model will guide every scenario in this lab.

---

## Why this lab exists

Many Terraform outages are caused not by bugs, but by **panic**.

Common panic reactions:

- re-running `terraform apply` repeatedly
- deleting state files
- commenting out code until the plan is empty
- accepting destroy/replace plans “just to see what happens”

This lab exists to replace panic with **process**.

---

## Rules for this lab (do not skip)

Before starting any scenario:

- Read the error or plan carefully
- Do **not** run `terraform apply` immediately
- Never delete state files
- Never “fix” things blindly

If Terraform proposes destroying resources unexpectedly:

- stop
- investigate
- do not apply

These rules are not academic — they are how production outages are avoided.

---

## A universal troubleshooting checklist

Use this checklist in every scenario:

1. What does Terraform think exists?
   - `terraform state list`
   - `terraform state show`

2. What does the configuration say should exist?
   - resource blocks
   - module structure
   - `for_each` / `count` keys

3. What exists in reality?
   - cloud console or CLI
   - LocalStack inspection

4. Where is the mismatch?
   - config error
   - state mismatch
   - real drift

5. What is the **smallest safe action** to realign them?

Only act once you can answer all five.

---

## Predict before you fix (critical habit)

Before running _any_ command, ask yourself:

- What will Terraform propose?
- Will this change state, infrastructure, or both?
- What is the worst thing that could happen?

Write your prediction down, then proceed carefully.

---

## Scenarios in this lab (do them in order)

These scenarios are intentionally ordered from “beginner break” to “professional break”.
Each scenario should end with:

- a clean `terraform plan`
- and your ability to explain **why** it broke

### Scenario 1 — Configuration won’t even parse (syntax / structure error)

**Goal:** learn how to stop early, read the exact error, and fix config before init/plan.

- **Intentionally broken:** invalid HCL (common causes: single-line blocks with multiple arguments, missing braces, wrong types).
- **Inspect:**
  - Configuration first (`terraform fmt`, `terraform validate`)
  - Do not touch state/infrastructure yet.
- **Smallest safe action:** fix the config so Terraform can initialize.
- **Success condition:** `terraform init` + `terraform validate` succeed; `terraform plan` runs.
- **Timebox:** 10–15 minutes.

### Scenario 2 — Identity instability (count/list reorder causes replacements)

**Goal:** learn why stable identity matters and how to prevent accidental replacement.

- **Intentionally broken:** using `count` with a list where ordering changes.
- **Inspect:**
  - Configuration (`count` usage)
  - Plan output (look for many destroy/create due to index shifts)
  - State addresses (`[0]`, `[1]` style addressing)
- **Smallest safe action:** migrate to `for_each` with stable keys and move state addresses (`terraform state mv`).
- **Success condition:** reordering inputs causes **no replacements**; plan is clean.
- **Timebox:** 15–25 minutes.

### Scenario 3 — Drift (reality changed outside Terraform)

**Goal:** learn to recognize drift and decide whether to accept it or revert it.

- **Intentionally broken:** change tags (or settings) out-of-band via AWS CLI/console.
- **Inspect:**
  - Reality (AWS CLI against LocalStack)
  - Plan output (look for unexpected changes)
  - State (what Terraform believes)
- **Smallest safe action:** choose one:
  - revert drift by applying Terraform desired state, OR
  - accept drift by updating config and converging back to clean plan.
- **Success condition:** plan becomes clean after reconciliation.
- **Timebox:** 15–20 minutes.

### Scenario 4 — Locks and partial operations (safe recovery mindset)

**Goal:** learn why locks exist and how to recover without panic.

- **Intentionally broken:** interrupt an apply after lock acquisition or run two plans/applies concurrently.
- **Inspect:**
  - Lock error message (Lock ID and who/when)
  - Whether another run is actually active
- **Smallest safe action:** resolve safely:
  - wait/cancel the other run, OR
  - `terraform force-unlock` only if you are certain it is stale.
- **Success condition:** plan/apply can proceed and state remains consistent.
- **Timebox:** 10–15 minutes.

### Scenario 5 — Import vs recreate (adopt existing infra safely)

**Goal:** learn the “professional move”: bring existing infra under Terraform control.

- **Intentionally broken:** a resource exists, but Terraform does not track it (no state entry).
- **Inspect:**
  - Reality (resource exists)
  - State (missing resource)
  - Config (resource block present)
- **Smallest safe action:** `terraform import` + converge config until plan is clean.
- **Success condition:** imported resource results in `No changes. Infrastructure is up-to-date.`
- **Timebox:** 15–25 minutes.

---

## Scenario template (how every scenario README should look)

Use this exact structure for each scenario README (like Lab 09):

```md
# Lab 10 — Scenario X: <short title>

## Where you are

- What exists (state/config/reality)
- What you should NOT do yet

## Why this matters

- The production failure this prevents

## What is intentionally broken

- One clear sentence

## First: predict the outcome

- What do you think plan/validate will do?

## Actions (do not rush)

- Exact commands to run (validate/plan/state/cli)
- What to look for in output

## What must NOT happen

- “Do not apply” warnings
- Red flags

## Fix rubric (smallest safe action)

- The minimal change that restores alignment

## Success checkpoint

- Clean plan
- Explain why it broke and why the fix worked
```

---

## What success looks like

You have completed this lab successfully if:

- you can explain _why_ each scenario broke (config/state/reality mismatch)
- you fixed issues without destructive applies
- you restored Terraform to a clean plan
- you felt **in control**, not rushed

---

## Key takeaways

- Terraform failures are normal
- Panic causes outages — process prevents them
- Configuration, state, and reality must agree
- Clean plans are the signal that alignment is restored

This lab turns Terraform errors from something to fear into something you can debug confidently.
