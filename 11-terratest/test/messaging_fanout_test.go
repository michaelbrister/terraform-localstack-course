package test

import (
  "encoding/json"
  "fmt"
  "testing"
  "time"

  "github.com/gruntwork-io/terratest/modules/terraform"
  "github.com/stretchr/testify/require"
)

func TestMessagingFanout(t *testing.T) {
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

  topics := terraform.OutputMap(t, opts, "topics")
  queues := terraform.OutputMap(t, opts, "queues")

  require.NotEmpty(t, topics, "expected topics output map")
  require.GreaterOrEqual(t, len(queues), 2, "expected at least two queues for fan-out test")

  var topicArn string
  for _, arn := range topics { topicArn = arn; break }
  require.NotEmpty(t, topicArn)

  payload := fmt.Sprintf("{\"ts\":%d,\"msg\":\"hello\"}", time.Now().Unix())
  pubOut := awsCmd(t, "sns", "publish", "--topic-arn", topicArn, "--message", payload)
  require.Contains(t, pubOut, "MessageId")

  for name, url := range queues {
    got := false
    for i := 0; i < 10; i++ {
      out := awsCmd(t, "sqs", "receive-message", "--queue-url", url, "--max-number-of-messages", "1", "--wait-time-seconds", "1")
      if out == "" {
        continue
      }
      var parsed map[string]any
      _ = json.Unmarshal([]byte(out), &parsed)
      if parsed["Messages"] != nil {
        got = true
        break
      }
      time.Sleep(250 * time.Millisecond)
    }
    require.True(t, got, fmt.Sprintf("expected message to arrive in queue %s (%s)", name, url))
  }
}
