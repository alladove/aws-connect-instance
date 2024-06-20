locals {
  instance_storage_configs = [
    {
      storage_type  = "S3"
      resource_type = "CALL_RECORDINGS"
      s3_config = {
        bucket_name   = aws_s3_bucket.connect.id
        bucket_prefix = "connect/${local.instance_alias}/CallRecordings/"
      }
    },
    {
      storage_type  = "S3"
      resource_type = "CHAT_TRANSCRIPTS"
      s3_config = {
        bucket_name   = aws_s3_bucket.connect.id
        bucket_prefix = "connect/${local.instance_alias}/ChatTranscripts/"
      }
    },
    {
      storage_type  = "S3"
      resource_type = "SCHEDULED_REPORTS"
      s3_config = {
        bucket_name   = aws_s3_bucket.connect.id
        bucket_prefix = "connect/${local.instance_alias}/Reports/"
      }
    },
    # This is required for Voicemail streaming: at least 1 hour retension
    # Deploy a Kinesis Stream if necessary
    # {
    #   storage_type = "KINESIS_VIDEO_STREAM"
    #   resource_type = "MEDIA_STREAMS"
    #   kinesis_video_stream_config = {
    #     prefix = "amazon-connect-ivr-${local.instance_alias}"
    #     retention_period_hours = 1
    #   }
    # },
    # {
    #   storage_type = "KINESIS_STREAM"
    #   resource_type = "CONTACT_TRACE_RECORDS"
    #   kinesis_stream_config = {
    #     stream_arn = "DEPLOY-AND-REPLACE-WITH-STREAM-ARN"
    #   }
    # },
    # {
    #   storage_type = "KINESIS_STREAM"
    #   resource_type = "AGENT_EVENTS"
    #   kinesis_stream_config = {
    #     stream_arn = "DEPLOY-AND-REPLACE-WITH-STREAM-ARN"
    #   }
    # }
  ]
}
