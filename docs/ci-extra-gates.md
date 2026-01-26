# Optional CI gates: TFLint + Trivy (Terraform config scanning)

These are not required for the Associate exam, but they raise the repo to “professional hygiene.”

## TFLint
Checks Terraform syntax/style and provider-specific issues.

Example GitHub Actions steps:
```yaml
- name: Install tflint
  run: |
    curl -s https://raw.githubusercontent.com/terraform-linters/tflint/master/install_linux.sh | bash

- name: tflint
  run: |
    tflint --init
    tflint --recursive
```

## Trivy config
Runs IaC misconfiguration scanning.
```yaml
- name: Install trivy
  run: |
    sudo apt-get update
    sudo apt-get install -y wget
    wget -qO- https://github.com/aquasecurity/trivy/releases/latest/download/trivy_0.57.0_Linux-64bit.tar.gz | sudo tar zx -C /usr/local/bin trivy

- name: trivy config
  run: |
    trivy config --exit-code 1 --severity HIGH,CRITICAL .
```

## When to enable
- After labs are stable
- If you want “pro-level” CI checks
