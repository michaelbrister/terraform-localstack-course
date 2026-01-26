# Terraform LocalStack Course (Zero → Advanced)

This repository is a **certification‑grade, hands‑on Terraform course** that takes you from **no / limited Terraform knowledge** to **real‑world, production‑ready Terraform usage**, using **LocalStack** as the AWS provider.

It is intentionally opinionated, practical, and exam‑aligned.

---

## 🎯 Who this course is for

- Engineers new to Terraform who want to *actually understand* it
- Cloud / DevOps engineers transitioning from AWS Console → IaC
- Anyone preparing for:
  - **Terraform Associate (003)**
  - **Terraform Authoring & Operations Professional**
- Engineers who want repeatable labs instead of slides

If you can complete this repo end‑to‑end, you are **over‑prepared** for the Associate exam and **well on your way** to professional‑level Terraform usage.

---

## 🧱 Core Principles

- **Local first** (no real AWS account required)
- **State safety matters**
- **Refactors should not destroy infrastructure**
- **for_each > count**
- **Dynamic blocks used intentionally**
- **CI validates everything**
- **Testing is part of IaC, not optional**

---

## 🧰 Tooling

- Terraform ≥ 1.5
- Docker + Docker Compose
- LocalStack
- AWS Provider (endpoint overridden)
- Go (for Terratest)
- GitHub Actions (CI)

Apple Silicon (M1/M2/M3) fully supported.

---

## 🚀 Getting Started

### 1. Start LocalStack

```bash
docker compose up -d
```

Verify:

```bash
curl http://localhost:4566/_localstack/health | jq
```

---

### 2. Terraform Basics (Local State)

Start with:

```
01-basics/
02-variables/
03-locals-outputs/
```

These labs teach:
- terraform init / plan / apply / destroy
- variable types and validation
- locals and outputs
- reading plans correctly

State is **local only** at this stage.

---

### 3. State & Backends (Critical Section)

```
04-backend-bootstrap/
05-backend-migration/
```

You will:
- Create an S3 backend using Terraform
- Add DynamoDB locking
- Migrate local state → remote state safely
- Learn when **NOT** to migrate state

This section alone eliminates ~40% of common exam mistakes.

---

### 4. Modules & Refactors

```
06-modules/
07-refactors/
```

You will learn:
- How to author reusable modules
- Input/output contracts
- Refactoring without destruction
- `moved` blocks and state safety

This mirrors real production Terraform work.

---

### 5. for_each & dynamic (Deep Dive)

```
08-for_each/
09-dynamic-blocks/
```

Topics:
- Stable keys vs index‑based addressing
- Nested flatten patterns
- Optional nested blocks
- Realistic AWS examples (SQS, SNS, DynamoDB)

This is **heavily tested on the exam**.

---

### 6. Multi‑Environment Layout

```
live/
  dev/
  stage/
  prod/
```

You will:
- Use one module across environments
- Keep state isolated
- Understand promotion patterns
- Avoid environment drift

This mirrors real org layouts.

---

## 🧪 Testing with Terratest

```
11-terratest/
```

Terratest validates:
- Terraform plans
- Resource counts
- Outputs
- Environment isolation

Run locally:

```bash
cd 11-terratest
go mod tidy
go test -v -timeout 25m
```

CI runs Terratest automatically using LocalStack.

---

## ⏱ Exam‑Style Timed Drills

```
12-exam-drills/
```

These are **break / fix drills**, designed to simulate real exam pressure.

Examples:
- Backend init failures
- count → for_each refactors with zero replacement
- Dynamic block bugs
- Provider version conflicts
- Stale state lock recovery
- Import & drift reconciliation
- Dependency cycles

Each drill includes:
- Broken configuration
- Expected failure
- Time limit
- Fix rubric

If you can complete these calmly under time pressure, you are exam‑ready.

---

## 🤖 CI (GitHub Actions)

CI validates:
- terraform fmt
- terraform validate
- selected plans
- terratest execution

CI is intentionally strict — if it fails, something is genuinely wrong.

---

## 🎓 Certification Readiness

### Terraform Associate (003)
Covered completely:
- Core workflow
- State & backends
- Providers
- for_each / dynamic
- Modules
- Imports
- Locking
- Drift
- CLI usage

### Terraform Professional
This repo prepares you for:
- Authoring reusable modules
- Safe refactors
- CI‑driven Terraform
- Multi‑env promotion
- Testing strategy

To go further:
- Add policy‑as‑code (OPA / Sentinel)
- Add Terraform Cloud concepts (workspaces, runs)
- Add versioned module releases

---

## 🧠 How to Use This Repo Effectively

Recommended path:
1. Complete labs in order (01 → 09)
2. Pause and re‑run labs without notes
3. Complete multi‑env labs
4. Add/modify resources yourself
5. Do **12‑exam‑drills** with a timer
6. Review failures and retry

Do not rush. Terraform rewards precision.

---

## ⚠️ Notes

- LocalStack is not AWS — behavior differences are intentional teaching moments
- Never use `-auto-approve` in real prod without safeguards
- Never `force-unlock` unless you are **certain** the lock is stale

---

## ✅ Outcome

If you complete this repo honestly:

- Terraform Associate → **Pass**
- Terraform in production → **Comfortable**
- Terraform refactors → **Confident**
- Terraform state → **Respected, not feared**

---

Happy shipping infrastructure 🚀
