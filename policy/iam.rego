package terraform.course

# Guardrail: detect overly-broad IAM policies (best-effort).
# This does not catch everything, but it teaches the right instinct.

deny contains msg if {
  r := resources[_]
  r.type == "aws_iam_policy"
  doc := json.unmarshal(r.values.policy)

  stmt := doc.Statement[_]

  # Action is "*" or includes "*"
  action_is_wild(stmt.Action)

  # Resource is "*" or includes "*"
  resource_is_wild(stmt.Resource)

  msg := sprintf("Overly broad IAM policy: %s.%s has Action=%v and Resource=%v", [r.type, r.name, stmt.Action, stmt.Resource])
}

# ---- helpers ----

action_is_wild(a) if {
  a == "*"
}
action_is_wild(a) if {
  is_array(a)
  "*" in a
}

resource_is_wild(r) if {
  r == "*"
}
resource_is_wild(r) if {
  is_array(r)
  "*" in r
}

is_array(x) if {
  type_name(x) == "array"
}
