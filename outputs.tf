# TODO: remove, doesn't seem to be needed
# output "id" {
#   value       = var.enable_contact_instance ? awscc_connect_instance.this[0].id : null
#   description = "The ID of the AWS Connect instance."
# }

output "arn" {
  value       = var.enable_contact_instance ? awscc_connect_instance.this[0].arn : null
  description = "The ARN of the AWS Connect instance."
}

output "created_time" {
  value       = var.enable_contact_instance ? awscc_connect_instance.this[0].created_time : null
  description = "The timestamp of instance creation logged as part of instance creation."
}

output "service_role" {
  value       = var.enable_contact_instance ? awscc_connect_instance.this[0].service_role : null
  description = "The service linked role created as part of instance creation."
}

output "status" {
  value       = var.enable_contact_instance ? awscc_connect_instance.this[0].instance_status : null
  description = "Specifies the creation status of a new instance."
}

output "integrations" {
  value = var.enable_contact_instance ? {
    for idx, integration in awscc_connect_integration_association.this :
    idx => {
      arn = integration.integration_arn
    }
  } : null
  description = "All integrations with key and arn."

}

output "storage_configs" {
  value = var.enable_contact_instance ? {
    for idx, config in awscc_connect_instance_storage_config.this :
    idx => {
      storage_type  = config.storage_type
      resource_type = config.resource_type
    }
  } : null
  description = "All storage configs."
}

output "default_prompts" {
  value       = var.enable_contact_instance ? jsondecode(data.external.list_prompts[0].result.data) : null
  description = "Default prompts created with the instance."
}

output "default_security_profiles" {
  value       = var.enable_contact_instance ? jsondecode(data.external.list_security_profiles[0].result.data) : null
  description = "Default prompts created with the instance."
}

output "default_routing_profiles" {
  value       = var.enable_contact_instance ? jsondecode(data.external.list_routing_profiles[0].result.data) : null
  description = "Default prompts created with the instance."
}

output "default_flows" {
  value       = var.enable_contact_instance ? jsondecode(data.external.list_flows[0].result.data) : null
  description = "Default contact flows created with the instance."
}

output "tags" {
  value       = var.tags
  description = "Tags used for instance creation. Should be reused by other resouces."
}
