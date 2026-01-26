package test

import (
  "strings"
  "testing"

  "github.com/gruntwork-io/terratest/modules/shell"
  "github.com/gruntwork-io/terratest/modules/terraform"
  "github.com/stretchr/testify/require"
)

// Tailored default: assumes you have a stack folder that outputs "buckets" as a map.
// Update TerraformDir/output name if your repo differs.
func TestModulesStack(t *testing.T) {
  t.Parallel()

  opts := &terraform.Options{
    TerraformDir: "../../07-modules",
    NoColor:      true,
    EnvVars: map[string]string{
      "AWS_ACCESS_KEY_ID":     "test",
      "AWS_SECRET_ACCESS_KEY": "test",
      "AWS_DEFAULT_REGION":    "us-east-1",
    },
  }

  defer terraform.Destroy(t, opts)
  terraform.InitAndApply(t, opts)

  buckets := terraform.OutputMap(t, opts, "buckets")
  require.NotEmpty(t, buckets, "expected non-empty buckets output")

  // Verify at least one bucket exists in LocalStack
  ls := shell.RunCommandAndGetOutput(t, shell.Command{
    Command: "aws",
    Args:    []string{"--endpoint-url=http://localhost:4566", "s3", "ls"},
    Env: map[string]string{
      "AWS_ACCESS_KEY_ID":     "test",
      "AWS_SECRET_ACCESS_KEY": "test",
      "AWS_DEFAULT_REGION":    "us-east-1",
    },
  })

  found := false
  for _, b := range buckets {
    if strings.Contains(ls, b) {
      found = true
      break
    }
  }
  require.True(t, found, "expected at least one output bucket to appear in aws s3 ls")
}
