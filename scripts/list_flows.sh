#!/bin/bash
instance_id=$1
output=$(aws connect list-contact-flows --instance-id $instance_id --no-paginate --output json)
# Create a map with Name as key
transformed_output=$(echo "$output" | jq -r '.ContactFlowSummaryList | map({ (.Name): { "arn": .Arn, "name": .Name, "type": .ContactFlowType, "state": .ContactFlowState } }) | add')
escaped_output=$(echo "$transformed_output" | jq @json)
echo "{\"data\": $escaped_output}"