variable "env" { type = string default = "dev" }

variable "buckets" {
  type = map(object({
    force_destroy = bool
    lifecycle_rules = list(object({
      id          = string
      enabled     = bool
      prefix      = optional(string)
      expire_days = optional(number)
    }))
  }))
}
