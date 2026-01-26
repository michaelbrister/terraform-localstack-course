locals {
  common_tags = { Env = var.env, Stack = var.name_prefix }
}

# -----------------
# S3 buckets
# -----------------
resource "aws_s3_bucket" "buckets" {
  for_each      = var.buckets
  bucket        = "${var.name_prefix}-${var.env}-${each.key}"
  force_destroy = each.value.force_destroy
  tags          = merge(local.common_tags, each.value.tags, { Name = each.key })
}

resource "aws_s3_bucket_versioning" "buckets" {
  for_each = { for k, v in var.buckets : k => v if v.versioning }
  bucket   = aws_s3_bucket.buckets[each.key].id
  versioning_configuration { status = "Enabled" }
}

resource "aws_s3_bucket_lifecycle_configuration" "buckets" {
  for_each = { for k, v in var.buckets : k => v if length(try(v.lifecycle_rules, [])) > 0 }
  bucket   = aws_s3_bucket.buckets[each.key].id

  dynamic "rule" {
    for_each = each.value.lifecycle_rules
    content {
      id     = rule.value.id
      status = rule.value.enabled ? "Enabled" : "Disabled"

      dynamic "filter" {
        for_each = try(rule.value.prefix, null) != null ? [true] : []
        content { prefix = rule.value.prefix }
      }

      dynamic "expiration" {
        for_each = try(rule.value.expire_days, null) != null ? [true] : []
        content { days = rule.value.expire_days }
      }
    }
  }
}

# -----------------
# DynamoDB tables
# -----------------
resource "aws_dynamodb_table" "tables" {
  for_each     = var.tables
  name         = "${var.name_prefix}-${var.env}-${each.key}"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = each.value.hash_key

  dynamic "attribute" {
    for_each = each.value.attributes
    content {
      name = attribute.value.name
      type = attribute.value.type
    }
  }

  dynamic "ttl" {
    for_each = try(each.value.ttl_attribute, null) != null ? [true] : []
    content {
      attribute_name = each.value.ttl_attribute
      enabled        = true
    }
  }

  tags = merge(local.common_tags, each.value.tags, { Name = each.key })
}

# -----------------
# SNS + SQS fanout (LocalStack-friendly advanced patterns)
# -----------------
resource "aws_sns_topic" "topic" {
  for_each = var.topics
  name     = "${var.name_prefix}-${var.env}-${each.key}"
  tags     = merge(local.common_tags, each.value.tags, { Name = each.key })
}

# Flatten topic->queues list into a stable map key
locals {
  topic_queue_list = flatten([
    for topic_name, cfg in var.topics : [
      for q in cfg.queues : {
        key   = "${topic_name}|${q.name}"
        topic = topic_name
        q     = q
      }
    ]
  ])

  topic_queue_map = {
    for x in local.topic_queue_list : x.key => {
      topic = x.topic
      q     = x.q
    }
  }
}

resource "aws_sqs_queue" "dlq" {
  for_each = {
    for k, v in local.topic_queue_map : k => v
    if v.q.create_dlq
  }
  name = "${var.name_prefix}-${var.env}-${each.value.topic}-${each.value.q.name}-dlq"
  tags = merge(local.common_tags, try(each.value.q.tags, {}), { Name = "${each.value.topic}-${each.value.q.name}-dlq" })
}

resource "aws_sqs_queue" "queue" {
  for_each = local.topic_queue_map
  name     = "${var.name_prefix}-${var.env}-${each.value.topic}-${each.value.q.name}"

  redrive_policy = each.value.q.create_dlq ? jsonencode({
    deadLetterTargetArn = aws_sqs_queue.dlq[each.key].arn
    maxReceiveCount     = each.value.q.max_receive_count
  }) : null

  tags = merge(local.common_tags, try(each.value.q.tags, {}), { Name = "${each.value.topic}-${each.value.q.name}" })
}

resource "aws_sns_topic_subscription" "subs" {
  for_each  = local.topic_queue_map
  topic_arn = aws_sns_topic.topic[each.value.topic].arn
  protocol  = "sqs"
  endpoint  = aws_sqs_queue.queue[each.key].arn
}
