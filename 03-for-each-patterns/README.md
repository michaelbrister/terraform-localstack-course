
# Lab 03 — `for_each` Patterns and Stable Resource Addressing

## What this lab teaches you
This lab teaches how to **scale resources safely** using `for_each` instead of copy/paste.

Concepts covered:
- `for_each` with maps and sets
- Stable addressing vs `count`
- Filtering resources using expressions

## Why `for_each` matters
- Keys, not indexes, define identity
- Order changes do not cause replacement
- Essential for long-lived infrastructure

## Exercises
1. Add a new map entry and observe the plan
2. Remove an entry and observe destroy
3. Reorder entries and confirm no replacement

## Exam notes
Terraform exams strongly favor `for_each` over `count`.
