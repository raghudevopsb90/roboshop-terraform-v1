# roboshop-terraform-v1

Multi-environment Terraform for the 13 RoboShop EC2 instances. No Terraform modules. The root `Makefile` is the reference file from `19-multi-env-code-structure` and is not modified.

## Plan and apply

`terraform init` uses the local backend so validation can run in this account. Pass both environment files explicitly. Nested `.auto.tfvars` files are not loaded automatically.

```bash
terraform init

terraform plan \
  -var-file="env-dev/ec2.auto.tfvars" \
  -var-file="env-dev/route53.auto.tfvars"

terraform apply \
  -var-file="env-dev/ec2.auto.tfvars" \
  -var-file="env-dev/route53.auto.tfvars"
```

Do not apply until the Route53 and Ansible hostname conflicts below are resolved.

## Makefile conflict

The copied Makefile still runs:

```make
terraform init -backend-config=env-$(env)/state.tfvars
terraform plan -var-file=env-$(env)/main.tfvars
```

This project does not include `env-dev/state.tfvars`, an S3 backend, or `env-dev/main.tfvars`. EC2 and Route53 inputs stay in separate files, so `make plan` cannot load them. `make apply` would copy `env-dev/*.auto.tfvars` into the root and Terraform would auto-load those copies, but only after `make init` succeeds. Use the commands above.

## Known conflicts

- Ansible roles call hosts such as `mysql.rdevopsb90.online`. These records are `mysql-dev.rdevopsb90.online`, as required. Catalogue, shipping, and the other service units will not resolve their backends until unsuffixed records exist in the same zone.
- SSH provisioning uses the instance public IP. The private IP is used only for Route53. Terraform runs outside the VPC, so a private-IP SSH target is not reachable.
- The Ansible frontend listens on port 80. The security group opens 3000, which is the required application port, and SSH 22.
- `ami-0eec78ea4cbaaf5bd` is available in `us-east-1` only. That is the region in `env-dev/ec2.auto.tfvars`.
- Hosted zone `Z05126561EI2V4JVVXVBY` is not visible to IAM user `skalluru` in account `973714476881`. The only zone in this account is `learndevopsonline.com` (`Z01881573D6X7ZJV76YYR`). Apply will fail on the Route53 records until this account can change `rdevopsb90.online`.
