# Workspaces vs folder-per-environment

Associate exam expects you to understand both.

## Workspaces
Workspaces are alternative states for the same configuration:
- `terraform workspace new dev`
- `terraform workspace select prod`

Same code, different state.

## Why teams often avoid workspaces for dev/stage/prod
- Easy to apply to wrong workspace
- Separates state but not configuration
- Naming isolation is still required
- Reviews are less explicit (PR doesn’t scream “prod change”)
- Backend/variables can become confusing

Exam phrasing:
> Workspaces separate state, not configuration; you must still ensure isolation.

## Folder-per-env (common production approach)
```
live/dev
live/stage
live/prod
```

Benefits:
- clear separation of config + variables + state keys
- simpler promotion workflows
- clearer PR review and auditing

## When workspaces are OK
- per-developer sandboxes
- ephemeral preview environments
- small projects with strict guardrails

## Repo recommendation
Default to folder-per-env for long-lived envs. Introduce workspaces later (optional) for ephemeral envs.
