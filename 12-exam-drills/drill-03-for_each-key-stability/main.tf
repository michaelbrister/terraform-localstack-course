resource "aws_sns_topic" "t" {
  for_each = var.topics
  name     = "tf-course-drill03-${each.key}"
}

locals {
  flattened = flatten([
    for topic, cfg in var.topics : [
      for i, qname in cfg.queues : {
        key   = "${topic}-${i}" # BAD: unstable
        topic = topic
        qname = qname
      }
    ]
  ])
}

resource "aws_sqs_queue" "q" {
  for_each = { for x in local.flattened : x.key => x }
  name     = "tf-course-drill03-${each.value.topic}-${each.value.qname}"
}

resource "aws_sns_topic_subscription" "sub" {
  for_each  = aws_sqs_queue.q
  topic_arn = aws_sns_topic.t[split("-", each.key)[0]].arn
  protocol  = "sqs"
  endpoint  = each.value.arn
}
