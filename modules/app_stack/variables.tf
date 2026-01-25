variable "env" { type = string }
variable "name_prefix" { type = string }

variable "topics" {
  description = "SNS topics each with a list of SQS queues to subscribe"
  type = map(object({
    queues = list(object({
      name              = string
      create_dlq        = bool
      max_receive_count = number
      tags              = optional(map(string), {})
    }))
    tags = optional(map(string), {})
  }))
  default = {}
}

variable "buckets" {
  description = "S3 buckets with optional lifecycle rules"
  type = map(object({
    versioning      = bool
    force_destroy   = bool
    lifecycle_rules = optional(list(object({
      id          = string
      enabled     = bool
      prefix      = optional(string)
      expire_days = optional(number)
    })), [])
    tags = optional(map(string), {})
  }))
  default = {}
}

variable "tables" {
  description = "DynamoDB tables"
  type = map(object({
    hash_key = string
    attributes = list(object({
      name = string
      type = string
    }))
    ttl_attribute = optional(string)
    tags          = optional(map(string), {})
  }))
  default = {}
}
