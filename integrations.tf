locals {
  integration_associations_map = var.enable_contact_instance ? { for idx, assoc in var.integration_associations : idx => assoc } : {}
}

resource "awscc_connect_integration_association" "this" {
  # Count prevents looking up instance id if it is not available, in case of enable_contact_instance = false
  count = var.enable_contact_instance ? length(var.integration_associations) : 0

  instance_id      = awscc_connect_instance.this[0].id
  integration_arn  = var.integration_associations[count.index].integration_arn
  integration_type = var.integration_associations[count.index].integration_type
}
