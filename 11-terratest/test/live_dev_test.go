package test

import (
  "testing"
  "github.com/gruntwork-io/terratest/modules/terraform"
)

// Note: CI uses init -backend=false for validation. This test applies a lab that uses local backend.
func TestForEachDynamicPatterns(t *testing.T) {
  t.Parallel()

  opts := &terraform.Options{
    TerraformDir: "../../03-for-each-patterns",
    NoColor:      true,
    EnvVars: map[string]string{
      "AWS_ACCESS_KEY_ID":     "test",
      "AWS_SECRET_ACCESS_KEY": "test",
      "AWS_DEFAULT_REGION":    "us-east-1",
    },
  }

  defer terraform.Destroy(t, opts)
  terraform.InitAndApply(t, opts)
}
