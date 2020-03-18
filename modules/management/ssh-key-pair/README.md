# ssh-key-pair


Terraform module for generating or importing an SSH public key file into AWS.


---
## Usage



```hcl
module "ssh_key_pair" {
  source                = "git::https://github.com/dieple/terraform-framework.git//ssh-key-pair.git?ref=master"
  key_name              = "app-ssh"
  ssh_public_key_path   = "/secrets"
  generate_ssh_key      = "true"
  private_key_extension = ".pem"
  public_key_extension  = ".pub"
}
```



```
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| generate_ssh_key | If set to `true`, new SSH key pair will be created | bool | `false` | no |
| key_name | ssh key name | string | `` | yes |
| private_key_extension | Private key extension | string | `` | no |
| public_key_extension | Public key extension | string | `.pub` | no |
| ssh_key_algorithm | SSH key algorithm | string | `RSA` | no |
| ssh_public_key_path | Path to SSH public key directory (e.g. `/secrets`) | string | - | yes |
| tags | Additional tags (e.g. `map('BusinessUnit','XYZ')` | map(string) | `<map>` | no |

## Outputs

| Name | Description |
|------|-------------|
| key_name | Name of SSH key |
| private_key | Content of the generated private key |
| private_key_filename | Private Key Filename |
| public_key | Content of the generated public key |
| public_key_filename | Public Key Filename |

