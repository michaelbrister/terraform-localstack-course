
# Lab 02 — Terraform Language Basics (Variables, Locals, Outputs)

## What this lab teaches you
This lab focuses on the **Terraform language itself**, independent of any cloud provider.
You will learn how Terraform evaluates expressions and passes data through a configuration.

Concepts covered:
- Input variables and defaults
- Type constraints
- Locals for reuse and clarity
- Outputs as public interfaces

## Key ideas
- Variables are inputs to a configuration
- Locals are computed values used internally
- Outputs expose selected values after apply

## What to pay attention to
- How changing a variable affects the plan
- How locals reduce duplication
- How outputs act like return values

## Exercises
1. Override a variable using `-var`
2. Override using a `.tfvars` file
3. Change a local and observe the plan

## Exam notes
Expect questions about:
- variable precedence
- when to use locals vs variables
- how outputs are consumed
