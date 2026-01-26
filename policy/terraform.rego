package terraform.course

# Rego v1-compatible policy for Conftest.
# Guards:
# - Require tags Env/Stack when tags exist
# - S3 bucket names must start with tf-course-
# - Disallow public S3 ACLs

deny contains msg if {
  r := resources[_]
  is_aws_resource(r)

  tags := object.get(r.values, "tags", null)
  tags != null

  present := {k |
    k := required_tags[_]
    object.get(tags, k, null) != null
  }

  missing := required_tags - present
  count(missing) > 0

  msg := sprintf("Resource %s.%s is missing required tags: %v", [r.type, r.name, missing])
}

deny contains msg if {
  r := resources[_]
  r.type == "aws_s3_bucket"

  name := r.values.bucket
  not startswith(name, "tf-course-")

  msg := sprintf("S3 bucket %s.%s name '%s' must start with 'tf-course-'", [r.type, r.name, name])
}

deny contains msg if {
  r := resources[_]
  r.type == "aws_s3_bucket_acl"

  acl := r.values.acl
  acl in {"public-read", "public-read-write"}

  msg := sprintf("Public ACL not allowed: %s.%s acl=%s", [r.type, r.name, acl])
}

# ---- helpers ----

required_tags := {"Env", "Stack"}

is_aws_resource(r) if {
  startswith(r.type, "aws_")
}

# Recursively walk all modules to find resources (handles nested child modules).
modules contains m if {
  m := input.planned_values.root_module
}

modules contains m if {
  parent := modules[_]
  m := parent.child_modules[_]
}

resources contains r if {
  m := modules[_]
  r := m.resources[_]
}
