locals {
  default_encryption_type      = "KMS"
  instance_storage_configs_map = var.enable_contact_instance ? { for idx, cfg in var.instance_storage_configs : idx => cfg } : {}
}

# Uses default keys if none provided 
data "aws_kms_key" "connect" {
  key_id = "alias/aws/connect"
}

data "aws_kms_key" "kinesisvideo" {
  key_id = "alias/aws/kinesisvideo"
}

resource "awscc_connect_instance_storage_config" "this" {
  for_each     = local.instance_storage_configs_map
  instance_arn = length(awscc_connect_instance.this) > 0 ? awscc_connect_instance.this[0].arn : ""

  storage_type  = each.value.storage_type
  resource_type = each.value.resource_type

  s3_config = each.value.s3_config != null ? {
    bucket_name   = each.value.s3_config.bucket_name
    bucket_prefix = each.value.s3_config.bucket_prefix
    encryption_config = each.value.s3_config.encryption_config != null ? {
      encryption_type = each.value.s3_config.encryption_config.encryption_type
      key_id          = each.value.s3_config.encryption_config.key_id
      } : {
      encryption_type = local.default_encryption_type,
      key_id          = data.aws_kms_key.connect.arn
    }
  } : null

  kinesis_video_stream_config = each.value.kinesis_video_stream_config != null ? {
    prefix                 = each.value.kinesis_video_stream_config.prefix
    retention_period_hours = each.value.kinesis_video_stream_config.retention_period_hours
    encryption_config = each.value.kinesis_video_stream_config.encryption_config != null ? {
      encryption_type = each.value.kinesis_video_stream_config.encryption_config.encryption_type
      key_id          = each.value.kinesis_video_stream_config.encryption_config.key_id
      } : {
      encryption_type = local.default_encryption_type,
      key_id          = data.aws_kms_key.kinesisvideo.arn
    }
  } : null

  kinesis_stream_config = each.value.kinesis_stream_config != null ? {
    stream_arn = each.value.kinesis_stream_config.stream_arn
  } : null

  kinesis_firehose_config = each.value.kinesis_firehose_config != null ? {
    firehose_arn = each.value.kinesis_firehose_config.firehose_arn
  } : null
}
