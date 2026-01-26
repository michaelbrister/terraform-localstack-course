# CI snippet: Conftest gating

Add these steps to `.github/workflows/ci.yml` after terraform validate.

```yaml
- name: Install conftest
  run: |
    curl -L -o conftest.tar.gz https://github.com/open-policy-agent/conftest/releases/download/v0.56.0/conftest_0.56.0_Linux_x86_64.tar.gz
    tar -xzf conftest.tar.gz conftest
    sudo mv conftest /usr/local/bin/conftest
    conftest --version

- name: Policy check (conftest on plan JSON)
  run: |
    set -e
    dirs="03-for-each-patterns 04-dynamic-patterns 07-modules"
    for d in $dirs; do
      echo "== conftest $d =="
      terraform -chdir=$d init -backend=false
      terraform -chdir=$d plan -out=tfplan -lock=false
      terraform -chdir=$d show -json tfplan > tfplan.json
      conftest test $d/tfplan.json -p policy
    done
```
