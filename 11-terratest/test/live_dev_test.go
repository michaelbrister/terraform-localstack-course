package test

import (
  "testing"

  "github.com/gruntwork-io/terratest/modules/terraform"
  "github.com/stretchr/testify/require"
)

func TestForEachDynamicPatterns(t *testing.T) {
  t.Parallel()

  tfDir := copyToTemp(t, "03-for-each-patterns")

  opts := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
    TerraformDir: tfDir,
    NoColor:      true,
    EnvVars: map[string]string{
      "AWS_ACCESS_KEY_ID":     "test",
      "AWS_SECRET_ACCESS_KEY": "test",
      "AWS_DEFAULT_REGION":    "us-east-1",
    },
  })

  defer terraform.Destroy(t, opts)
  terraform.InitAndApply(t, opts)

  exitCode := terraform.PlanExitCode(t, opts)
  require.Equal(t, 0, exitCode, "expected clean plan after apply")
}
