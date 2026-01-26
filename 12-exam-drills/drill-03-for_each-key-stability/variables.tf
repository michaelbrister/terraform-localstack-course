variable "topics" {
  type    = map(object({ queues = list(string) }))
  default = { events = { queues = ["worker", "audit"] } }
}
