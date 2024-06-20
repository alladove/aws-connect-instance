#!/bin/bash
instance_id=$1
output=$(aws connect list-security-profiles --instance-id $instance_id --no-paginate --output json)
# Create a map with Name as key
transformed_output=$(echo "$output" | jq -r '.SecurityProfileSummaryList | map({ (.Name): { "arn": .Arn } }) | add')
escaped_output=$(echo "$transformed_output" | jq @json)
echo "{\"data\": $escaped_output}"