# Lab 09 — Refactor without replacement (moved blocks, state mv, import)

This lab is three parts:
1) Rename a resource and prevent replacement using a `moved` block
2) Move a resource between modules using `moved` block or `terraform state mv`
3) Import a resource created out-of-band

Part 1: Create initial resource
- Apply `step1/`
- Then rename resource in `step2/` and use `moved` to avoid replace

Part 2: Module move
- Apply `step3/` (resource in root)
- Move into `modules/s3_bucket` and apply `step4/` with `moved`

Part 3: Import
- Create a bucket using AWS CLI and import it into `step5/`

Each step folder has commands and expected outputs.
