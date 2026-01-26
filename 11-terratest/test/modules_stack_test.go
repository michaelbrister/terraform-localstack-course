package test

import (
  "encoding/json"
  "fmt"
  "strings"
  "testing"

  "github.com/gruntwork-io/terratest/modules/terraform"
  "github.com/stretchr/testify/require"
)

func TestModulesStack(t *testing.T) {
  t.Parallel()

  tfDir := copyToTemp(t, "07-modules")

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

  buckets := terraform.OutputMap(t, opts, "buckets")
  require.NotEmpty(t, buckets, "expected non-empty buckets output map")

  queues, _ := terraform.OutputMapE(t, opts, "queues")
  topics, _ := terraform.OutputMapE(t, opts, "topics")

  ls := awsCmd(t, "s3", "ls")
  found := false
  for _, b := range buckets {
    if strings.Contains(ls, b) {
      found = true
      break
    }
  }
  require.True(t, found, "expected at least one output bucket to appear in aws s3 ls")

  # Tag assertion for at least one bucket
  checked := 0
  for _, b := range buckets {
    out := awsCmd(t, "s3api", "get-bucket-tagging", "--bucket", b)
    var parsed map[string]any
    require.NoError(t, json.Unmarshal([]byte(out), &parsed))

    tagset, ok := parsed["TagSet"].([]any)
    require.True(t, ok && len(tagset) > 0, fmt.Sprintf("expected TagSet for bucket %s", b))

    hasEnv, hasStack := false, false
    for _, tv := range tagset {
      m := tv.(map[string]any)
      if m["Key"] == "Env" { hasEnv = true }
      if m["Key"] == "Stack" { hasStack = true }
    }
    require.True(t, hasEnv && hasStack, fmt.Sprintf("bucket %s missing Env/Stack tags", b))
    checked += 1
    if checked >= 1 { break }
  }

  # No-replacement guard
  exitCode := terraform.PlanExitCode(t, opts)
  require.Equal(t, 0, exitCode, "expected clean plan (exitcode 0) after apply")

  if len(topics) > 0 {
    out := awsCmd(t, "sns", "list-topics")
    ok := false
    for _, arn := range topics {
      if strings.Contains(out, arn) { ok = true; break }
    }
    require.True(t, ok, "expected at least one topic ARN from outputs to exist")
  }

  if len(queues) > 0 {
    out := awsCmd(t, "sqs", "list-queues")
    ok := false
    for _, url := range queues {
      if strings.Contains(out, url) { ok = true; break }
    }
    require.True(t, ok, "expected at least one queue URL from outputs to exist")
  }
}
