variable "env" { type = string default = "dev" }

variable "buckets" {
  description = "Map of bucket configs"
  type = map(object({
    versioning = bool
    tags       = map(string)
  }))
}
