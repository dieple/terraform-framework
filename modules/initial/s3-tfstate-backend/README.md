# s3-tfstate-backend


Terraform module to provision an S3 bucket to store `terraform.tfstate` file and a DynamoDB table to lock the state file
to prevent concurrent modifications and state corruption.

The module supports the following:

1. Forced server-side encryption at rest for the S3 bucket
2. S3 bucket versioning to allow for Terraform state recovery in the case of accidental deletions and human errors
3. State locking and consistency checking via DynamoDB table to prevent concurrent operations
4. DynamoDB server-side encryption

## Usage

1. Define the module in your `.tf` file using local state:
   ```hcl
   terraform {
     required_version = ">= 0.12.0"
   }

   module "terraform_state_backend" {
     source        = "git::https://github.com/dieple/terraform-framework.git//modules/initial/s3-tfstate-backend.git?ref=master"
     product       = "cloud"
     customer      = "internal"
     environemnt   = "dev"
     attributes    = ["state"]
     region        = "eu-west-1"
   }
   ```

1. `terraform init`

1. `terraform apply`. This will create the state bucket and locking table.

1. Then add a `backend` that uses the new bucket and table:
   ```hcl
   terraform {
     required_version = ">= 0.11.3"

     backend "s3" {
       region         = "us-east-1"
       bucket         = "< the name of the S3 bucket >"
       key            = "terraform.tfstate"
       dynamodb_table = "< the name of the DynamoDB table >"
       encrypt        = true
     }
   }

   module "another_module" {
     source = "....."
   }
   ```

1. `terraform init`. Terraform will detect that you're trying to move your state into S3 and ask, 
"Do you want to copy existing state to the new backend?" 
Enter "yes". Now state is stored in the bucket and the DynamoDB table will be used to lock the 
state to prevent concurrent modifications.

<br/>

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| acl | The canned ACL to apply to the S3 bucket | string | `private` | no |
| attributes | Additional attributes (e.g. `state`) | list | `<list>` | no |
| block_public_acls | Whether Amazon S3 should block public ACLs for this bucket. | string | `false` | no |
| block_public_policy | Whether Amazon S3 should block public bucket policies for this bucket. | string | `false` | no |
| delimiter | Delimiter to be used between `namespace`, `environment`, `stage`, `name` and `attributes` | string | `-` | no |
| enable_server_side_encryption | Enable DynamoDB server-side encryption | string | `true` | no |
| environment | Environment, e.g. 'prod', 'staging', 'dev', 'pre-prod', 'UAT' | string | `` | no |
| force_destroy | A boolean that indicates the S3 bucket can be destroyed even if it contains objects. These objects are not recoverable | string | `false` | no |
| ignore_public_acls | Whether Amazon S3 should ignore public ACLs for this bucket. | string | `false` | no |
| mfa_delete | A boolean that indicates that versions of S3 objects can only be deleted with MFA. ( Terraform cannot apply changes of this value; https://github.com/terraform-providers/terraform-provider-aws/issues/629 ) | string | `false` | no |
| prevent_unencrypted_uploads | Prevent uploads of unencrypted objects to S3 | string | `true` | no |
| profile | AWS profile name as set in the shared credentials file | string | `` | no |
| read_capacity | DynamoDB read capacity units | string | `5` | no |
| regex_replace_chars | Regex to replace chars with empty string in `namespace`, `environment`, `stage` and `name`. By default only hyphens, letters and digits are allowed, all other chars are removed | string | `/[^a-zA-Z0-9-]/` | no |
| region | AWS Region the S3 bucket should reside in | string | - | yes |
| restrict_public_buckets | Whether Amazon S3 should restrict public bucket policies for this bucket. | string | `false` | no |
| role_arn | The role to be assumed | string | `` | no |
| tags | Additional tags (e.g. `map('BusinessUnit','XYZ')` | map | `<map>` | no |
| terraform_backend_config_file_name | Name of terraform backend config file | string | `terraform.tf` | no |
| terraform_backend_config_file_path | The path to terrafrom project directory | string | `` | no |
| terraform_state_file | The path to the state file inside the bucket | string | `terraform.tfstate` | no |
| terraform_version | The minimum required terraform version | string | `0.11.3` | no |
| write_capacity | DynamoDB write capacity units | string | `5` | no |

## Outputs

| Name | Description |
|------|-------------|
| dynamodb_table_arn | DynamoDB table ARN |
| dynamodb_table_id | DynamoDB table ID |
| dynamodb_table_name | DynamoDB table name |
| s3_bucket_arn | S3 bucket ARN |
| s3_bucket_domain_name | S3 bucket domain name |
| s3_bucket_id | S3 bucket ID |
| terraform_backend_config | Rendered Terraform backend config file |


