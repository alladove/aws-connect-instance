resource "awscc_connect_instance" "this" {
  count = var.enable_contact_instance ? 1 : 0

  instance_alias           = var.instance_alias
  identity_management_type = var.identity_management_type
  directory_id             = var.directory_id

  attributes = {
    inbound_calls            = var.inbound_calls
    outbound_calls           = var.outbound_calls
    auto_resolve_best_voices = var.auto_resolve_best_voices
    contactflow_logs         = var.contactflow_logs
    contact_lens             = var.contact_lens
    early_media              = var.early_media
    use_custom_tts_voices    = var.use_custom_tts_voices
  }

  tags = var.tags
}

data "external" "list_prompts" {
  count      = var.enable_contact_instance ? 1 : 0
  program    = ["bash", "${path.module}/scripts/list_prompts.sh", awscc_connect_instance.this[0].id]
  depends_on = [awscc_connect_instance.this]
}

data "external" "list_security_profiles" {
  count      = var.enable_contact_instance ? 1 : 0
  program    = ["bash", "${path.module}/scripts/list_security_profiles.sh", awscc_connect_instance.this[0].id]
  depends_on = [awscc_connect_instance.this]
}

data "external" "list_routing_profiles" {
  count      = var.enable_contact_instance ? 1 : 0
  program    = ["bash", "${path.module}/scripts/list_routing_profiles.sh", awscc_connect_instance.this[0].id]
  depends_on = [awscc_connect_instance.this]
}

data "external" "list_flows" {
  count      = var.enable_contact_instance ? 1 : 0
  program    = ["bash", "${path.module}/scripts/list_flows.sh", awscc_connect_instance.this[0].id]
  depends_on = [awscc_connect_instance.this]
}
