# vpc_module_new
Terraform Module VPC

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 4 |

## Resources

| Name | Type |
|------|------|
| [aws_vpc.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |
| [aws_internet_gateway.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_eip.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_nat_gateway.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway) | resource |
| [aws_subnet.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_route_table.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resouce |
| [aws_cloudwatch_log_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_s3_bucket_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy.html) | resource |
| [aws_iam_role.this](https://registry.terraform.io/providers/hashicorp/aws/3.8.0/docs/resources/iam_role) | resource |
| [aws_iam_policy.this](https://registry.terraform.io/providers/hashicorp/aws/3.2.0/docs/resources/iam_policy) | resource |
| [aws_iam_policy_attachment.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_cloudtrail.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudtrail) | resource |
| [aws_flow_log.this](https://registry.terraform.io/providers/hashicorp/aws/3.1.0/docs/resources/flow_log) | resource |



## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_region"></a> [region](#input\_region) | NA | `string` | n/a | yes |
| <a name="input_cidr_block"></a> [cidr\block](#input\_cidr\_block) | NA | `string` | n/a | yes |
| <a name="input_public_subnets_cidr"></a> [public\_subnets\cidr](#input\_public\_subnets\_cidr) | NA | `string` | n/a | yes |
  <a name="input_private_subnets_cidr"></a> [private\_subnets\cidr](#input\_private\_subnets\_cidr) | NA | `string` | n/a | yes | 
  <a name="input_private_subnets"></a> [private\_subnets](#input\_private\_subnets) | NA | `string` | n/a | yes | 
  <a name="input_public_subnets"></a> [public\_subnets](#input\_public\_subnets) | NA | `string` | n/a | yes | 
| <a name="input_availability_zones"></a> [availability\zones](#input\_availability\_zones) | NA | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | NA | `string` | n/a | yes |
| <a name="input_application"></a> [vpc\_application](#input\_application) | NA | `string` | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | NA | `string` | n/a | yes |
| <a name="input_s3_bucket_name"></a> [s3\_bucket\_name](#input\_s3\_bucket\_name) | NA | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="vpc_id"></a> [vpc_id](#output\_vpc\_id) | NA |
| <a name="region"></a> [region](#output\_region) | NA |
