package test

import (
  "path/filepath"
  "testing"

  "github.com/gruntwork-io/terratest/modules/files"
  "github.com/gruntwork-io/terratest/modules/shell"
  "github.com/stretchr/testify/require"
)

func copyToTemp(t *testing.T, relPath string) string {
  repoRoot, err := filepath.Abs(filepath.Join("..", ".."))
  require.NoError(t, err)
  src := filepath.Join(repoRoot, relPath)
  dst := files.CopyTerraformFolderToTemp(t, src, "")
  return dst
}

func awsCmd(t *testing.T, args ...string) string {
  cmd := shell.Command{
    Command: "aws",
    Args:    append([]string{"--endpoint-url=http://localhost:4566"}, args...),
    Env: map[string]string{
      "AWS_ACCESS_KEY_ID":     "test",
      "AWS_SECRET_ACCESS_KEY": "test",
      "AWS_DEFAULT_REGION":    "us-east-1",
    },
  }
  return shell.RunCommandAndGetOutput(t, cmd)
}
