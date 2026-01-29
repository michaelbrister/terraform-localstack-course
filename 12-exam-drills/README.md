# Lab 12 — Timed Exam Drills (Thinking Under Pressure)

## What this lab teaches you

This lab is designed to simulate **Terraform exam conditions** and real-world on-call situations:

- limited time
- incomplete information
- ambiguous failures
- no step-by-step guidance

Unlike earlier labs, these drills intentionally provide **less scaffolding**.

The goal is to help you transition from:

> “I can follow Terraform instructions”  
> to  
> **“I can diagnose Terraform problems quickly and confidently.”**

---

## How these drills are different from earlier labs

Earlier labs:

- explained concepts in depth
- walked you through solutions
- focused on understanding and correctness

This lab:

- assumes you already know the concepts
- emphasizes speed, prioritization, and judgment
- mirrors how Terraform problems appear on the Associate exam

You are expected to **recognize patterns**, not rediscover fundamentals.

---

## How to use this lab (important)

For each drill:

1. **Time yourself**
   - Use the suggested timebox
   - Stop when time expires, even if unfinished

2. **Do not look ahead**
   - Do not read future steps
   - Do not search documentation initially

3. **Diagnose before acting**
   - Identify whether the issue is:
     - configuration
     - state
     - backend
     - dependency graph
     - identity
   - Decide what _must_ be fixed first

4. **Apply only when justified**
   - Blind applies are penalized on the exam
   - Dangerous plans should stop you immediately

5. **Debrief afterward**
   - Read the README explanation
   - Compare your reasoning to the intended solution
   - Note where you hesitated or panicked

This reflection step is where most learning happens.

---

## What these drills are testing

Collectively, the drills test your ability to:

- Read and interpret Terraform error messages quickly
- Identify destructive or unsafe plans
- Reason about resource identity and state
- Debug backend and locking issues
- Fix configuration problems without escalation
- Maintain a “clean plan” discipline

These are the exact skills the Terraform Associate exam rewards.

---

## Drill progression (recommended order)

Do the drills in order. They are sequenced intentionally.

1. **Drill 01 — Backend initialization failure**  
   Diagnose and fix `terraform init` issues.

2. **Drill 02 — Count to for_each without recreation**  
   Prevent destructive refactors using stable identity.

3. **Drill 03 — Stable keys in flattened for_each data**  
   Avoid subtle replacement caused by unstable keys.

4. **Drill 04 — Optional nested blocks with dynamic**  
   Conditionally render blocks without invalid configs.

5. **Drill 05 — Module refactor with moved blocks**  
   Refactor safely without destroying infrastructure.

6. **Drill 06 — Import and converge**  
   Adopt existing infrastructure into Terraform state.

7. **Drill 07 — Drift reconciliation**  
   Decide whether to revert or accept out-of-band changes.

8. **Drill 08 — Stale lock recovery**  
   Resolve lock contention safely under pressure.

9. **Drill 09 — Plan interpretation under time pressure**  
   Identify dangerous changes quickly.

10. **Drill 10 — Dependency cycle debugging**  
    Break cycles by reasoning about Terraform’s graph.

---

## Exam mindset reminder

On the Terraform Associate exam:

- Speed matters
- Panic causes mistakes
- Terraform is never “random”

If something looks dangerous:

- stop
- reread the plan or error
- identify the root cause

Terraform always tells you what it believes.
Your job is to understand _why_.

---

## Success criteria for this lab

You have completed this lab successfully if:

- you can finish most drills within the timebox
- you can explain the root cause without guessing
- you consistently avoid destructive applies
- you recognize problem patterns quickly

At this point, you are not just studying Terraform —
you are **thinking like a Terraform operator under exam conditions**.
