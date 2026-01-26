package terraform.course

default deny = []

is_aws_resource(r) {
  startswith(r.type, "aws_")
}

resources[r] {
  r := input.planned_values.root_module.resources[_]
}
resources[r] {
  child := input.planned_values.root_module.child_modules[_]
  r := child.resources[_]
}

required_tags := {"Env", "Stack"}

deny[msg] {
  r := resources[_]
  is_aws_resource(r)
  tags := r.values.tags
  tags != null

  missing := required_tags - {k | tags[k] != null}
  count(missing) > 0

  msg := sprintf("Resource %s.%s is missing required tags: %v", [r.type, r.name, missing])
}

deny[msg] {
  r := resources[_]
  r.type == "aws_s3_bucket"
  name := r.values.bucket
  not startswith(name, "tf-course-")

  msg := sprintf("S3 bucket %s.%s name '%s' must start with 'tf-course-'", [r.type, r.name, name])
}

deny[msg] {
  r := resources[_]
  r.type == "aws_s3_bucket_acl"
  acl := r.values.acl
  acl == "public-read" or acl == "public-read-write"

  msg := sprintf("Public ACL not allowed: %s.%s acl=%s", [r.type, r.name, acl])
}
