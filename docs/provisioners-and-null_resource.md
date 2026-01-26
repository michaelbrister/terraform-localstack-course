# Provisioners and `null_resource` (Exam coverage + real-world guidance)

Terraform Associate exams often include questions about **provisioners** and **`null_resource`**.
The correct mindset is:

- Prefer **native provider resources**.
- Use provisioners only when you **must** bridge a gap.
- Treat provisioners as a **last resort**, and design them to be **idempotent** and **safe**.

## Provisioners
Provisioners execute actions outside Terraform’s declarative model:
- `local-exec` runs a command locally
- `remote-exec` runs commands remotely (SSH/WinRM)
- `file` uploads files to a remote host

Example (discouraged unless unavoidable):

```hcl
resource "aws_instance" "web" {
  # ...

  provisioner "local-exec" {
    command = "echo Created ${self.id}"
  }
}
```

## Why provisioners are risky
- Not declarative: Terraform can’t model side effects
- Often not idempotent: reruns can duplicate actions
- Failures can leave resources partially configured
- Depend on local tooling/environment
- Create drift Terraform can’t see

Exam phrasing:
> Provisioners should be used as a last resort because they introduce non-declarative side effects.

## `null_resource`
`null_resource` manages no real infrastructure. It’s often used to run provisioners with triggers.

```hcl
resource "null_resource" "notify" {
  triggers = {
    version = var.release_version
  }

  provisioner "local-exec" {
    command = "echo Deploying ${self.triggers.version}"
  }
}
```

Key: `triggers` controls re-runs (changing triggers replaces the resource and re-runs provisioners).

## Preferred alternatives
1. Provider resources (best)
2. CI/CD pipeline steps (GitHub Actions / ADO)
3. Config mgmt (Ansible, etc.)
4. cloud-init/userdata
5. Immutable images (Packer)

## When provisioners are acceptable
- No provider support exists for a required action
- You can make it fully idempotent
- You can tolerate/recover from partial failures

If you use them:
- Keep actions small and idempotent
- Avoid destroy-time provisioners unless necessary
- Don’t use provisioners for core production logic
