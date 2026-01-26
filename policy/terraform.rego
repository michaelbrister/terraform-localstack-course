package terraform.course

# Deny messages returned by conftest.
deny contains msg if {
  r := resources[_]
  is_aws_resource(r)

  # Only enforce when tags exist on the resource.
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

resources contains r if {
  r := input.planned_values.root_module.resources[_]
}

resources contains r if {
  child := input.planned_values.root_module.child_modules[_]
  r := child.resources[_]
}