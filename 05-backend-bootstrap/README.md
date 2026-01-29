
# Lab 05 — Bootstrapping Remote State Infrastructure

## What this lab teaches you
This lab shows how to use Terraform to **create its own backend infrastructure**.

Concepts covered:
- S3 buckets for remote state
- DynamoDB for state locking
- Multi-environment backend patterns

## Why this matters
Terraform cannot manage remote state until the backend exists.
This lab teaches the safe bootstrapping pattern.

## Key warning
Backend infrastructure should be created once and rarely changed.

## Exam notes
Expect questions about:
- why remote state is important
- why locking matters
