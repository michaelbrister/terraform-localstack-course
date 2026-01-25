# Lab 10 — Break/Fix Drills (Certification-grade)

These are intentional failure modes you must learn to diagnose quickly.

## Drill A — Bad bucket name (invalid chars)
Folder: `drill-a-bad-name`
- Fix invalid bucket name characters, re-run plan/apply.

## Drill B — for_each key instability (index-based keys)
Folder: `drill-b-key-instability`
- You will see replacements when order changes.
- Fix by switching to stable keys.

## Drill C — State lock contention
Folder: `drill-c-lock`
- Two terminals contending on lock table.
- Identify and resolve safe unlock procedure.

## Drill D — Drift detection
Folder: `drill-d-drift`
- Modify tags out-of-band and reconcile.

Each drill has expected error messages and remediation steps.
