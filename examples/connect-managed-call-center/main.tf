locals {
  instance_alias           = "connect-managed-example"
  identity_management_type = "CONNECT_MANAGED"

  tags = {
    project = "important-project"
  }

  # awscc modules prefer lists to maps
  tags_list = [for key, value in local.tags : { key = key, value = value }]
}

module "instance" {
  source = "./../.."

  enable_contact_instance  = true
  instance_alias           = local.instance_alias
  identity_management_type = local.identity_management_type
  inbound_calls            = true
  outbound_calls           = true
  use_custom_tts_voices    = false
  instance_storage_configs = local.instance_storage_configs

  tags = local.tags_list
}