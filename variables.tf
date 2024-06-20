
# Volatile!
# Changing values of the following variables will cause the Amazon Connect instance to be destroyed and recreated.
variable "enable_contact_instance" {
  description = "Enable the creation of the AWS Connect instance."
  type        = bool
  default     = true
}

variable "instance_alias" {
  description = "The alias of the instance."
  type        = string
}

variable "identity_management_type" {
  description = "The type of identity management for the instance. Possible values: `SAML`, `CONNECT_MANAGED`, `EXISTING_DIRECTORY`"
  type        = string
}

variable "directory_id" {
  description = "Refers to the identifier for the directory (e.g., AWS Managed Microsoft AD, AD Connector) used for identity management."
  type        = string
  default     = null
}

variable "inbound_calls" {
  description = "Specifies whether inbound calls are enabled."
  type        = bool
}

variable "outbound_calls" {
  description = "Specifies whether outbound calls are enabled."
  type        = bool
}

variable "auto_resolve_best_voices" {
  description = "Automatically selects the best available voices for text-to-speech."
  type        = bool
  default     = true
}

variable "contactflow_logs" {
  description = "Specifies whether to enable contact flow logs for debugging and monitoring."
  type        = bool
  default     = true
}

variable "contact_lens" {
  description = "Specifies whether to enable Contact Lens for speech analytics."
  type        = bool
  default     = true
}

variable "early_media" {
  description = "Specifies whether to enable early media, allowing customers to hear audio prompts before the call is answered."
  type        = bool
  default     = true
}

variable "use_custom_tts_voices" {
  description = "Specifies whether to use custom text-to-speech voices."
  type        = bool
  default     = true
}

# Non-volitale
variable "integration_associations" {
  description = "List of integration ARNs and their types for the Amazon Connect instance."
  type = list(object({
    integration_arn  = string
    integration_type = string
  }))
  default = []
}

variable "instance_storage_configs" {
  description = "List of configuration for the storage associated with the AWS Connect instance."
  type = list(object({
    storage_type : string  #'S3', 'KINESIS_VIDEO_STREAM', 'KINESIS_STREAM', 'KINESIS_FIREHOSE'
    resource_type : string # 'CALL_RECORDINGS', 'CHAT_TRANSCRIPTS', 'SCHEDULED_REPORTS', 'MEDIA_STREAMS', 'CONTACT_TRACE_RECORDS', 'AGENT_EVENTS'
    s3_config : optional(object({
      bucket_name : string
      bucket_prefix : string
      encryption_config : optional(object({
        encryption_type : string
        key_id : string
      }))
    }))
    kinesis_video_stream_config : optional(object({
      prefix : string
      retention_period_hours : number
      encryption_config : optional(object({
        encryption_type : string
        key_id : string
      }))
    }))
    kinesis_stream_config : optional(object({
      stream_arn : string
    }))
    kinesis_firehose_config : optional(object({
      firehose_arn : string
    }))
  }))
  default = []
}

# Other
variable "tags" {
  description = "A list of tags, where each tag is an object with a key and a value."
  type = list(object({
    key   = string
    value = string
  }))
  default = []
}