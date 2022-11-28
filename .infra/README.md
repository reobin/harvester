# Infrastructure

## Requirements

- [AWS CLI](https://aws.amazon.com/cli/)
- [terraform](https://developer.hashicorp.com/terraform/downloads)
- `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` defined in environment.

Lastly, create a `env.tfvars` file at `./infra/` with the following values:

```tfvars
aws_account_id     = "example"
aws_vpc_id         = "vpc-example"
aws_subnet_ids     = ["subnet-example", "subnet-example"]
harvest_account_id = "example"
harvest_api_token  = "example"
```

## Deploy

Create a `env.tfvars` file and fill with the variables listed in `variables.tf`.

Initialize terraform:

```sh
terraform init
```

Plan the deployment:

```sh
terraform plan -env-file env.tfvars -out=tfplan
```

Apply the changes:

```sh
terraform apply tfplan
```
