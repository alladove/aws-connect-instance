# Connect Instance Module

This module is responsible for deploying the Amazon Connect instance, storage configurations, and integrations.

See other related projects, deployed on top of AWS connect instance:

* [aws-connect-resources](https://github.com/alladove/aws-connect-resources)
* [aws-connect-users](https://github.com/alladove/aws-connect-users)
* [aws-connect-flows](https://github.com/alladove/aws-connect-flows)


> **Note:** To be able to accept phone calls, after you deployed phone numbers and flows with terraform, log into your contact center and associate the phone numbers with flows. To undeploy, disassociate the phone numbers.

## Why AWSCC instead of AWS provider?

The AWSCC provider is preferred for deploying Amazon Connect instances due to its more frequent updates and inclusion of resources not available in the standard AWS provider, such as prompts.

## Resources

- `awscc_connect_instance`
- `awscc_connect_instance_storage_config`
- `awscc_connect_integration_association`

## Prerequisites

* S3 bucket: if you want to setup recordings, to be passed with instance_storage_configs.
* Kinesis stream: for kinesis data streaming (required for voicemail support).

## Dependencies

None

## Other

For Voicemail support, use this solution:

https://github.com/amazon-connect/voicemail-express-amazon-connect