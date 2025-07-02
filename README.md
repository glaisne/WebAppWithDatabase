# %%PROJECT_TITLE%%

[![Terraform CI](https://github.com/%%GH_OWNER%%/%%REPO_SLUG%%/actions/workflows/ci.yml/badge.svg)](https://github.com/%%GH_OWNER%%/%%REPO_SLUG%%/actions/workflows/ci.yml)
[![Docs – GitHub Pages](https://img.shields.io/badge/docs-gh--pages-blue)](https://%%GH_OWNER%%.github.io/%%REPO_SLUG%%)

> *Replace* `%%PROJECT_TITLE%%`, `%%REPO_SLUG%%`, and `%%GH_OWNER%%` with real values.  
> If you use the automation script I shared, the title and slug are filled in automatically—edit the owner once or extend the script to inject it.

---

## 🌟 Overview

This repository contains a **mini-architecture** built with **Terraform 1.x** for Microsoft Azure.  
It serves both as:

1. A **working sample** you can deploy in minutes, and  
2. A **portfolio artifact** that demonstrates clean, production-minded Infrastructure-as-Code.

### Key features

- Remote backend (Azure Blob) with state locking  
- CI pipeline: `fmt → validate → tflint → tfsec → infracost`  
- Modular Terraform structure ready for reuse  
- Auto-generated architecture diagram & docs site (GitHub Pages)

---

## 🚀 Quick start

### Bash

```bash
# 1  move example variable values
mv envs/dev.example.tfvars__ envs/dev.tfvars

# 2 Update the values inside envs/dev.tfvars
sed -i "/<tenant_id>/YOUR_TENANT_ID/" envs/dev.tfvars
sed -i "/<subscription_id>/YOUR_SUBSCRIPTION_ID/" envs/dev.tfvars
sed -i "/<resource_group_name>/YOUR_RESOURCE_GROUP_NAME/" envs/dev.tfvars
sed -i "/<location>/YOUR_LOCATION/" envs/dev.tfvars

# 3 Create backend.hcl configuration file
mv ./backend.hcl.example /backend.hcl

# 4 Update backend.hcl file
## NOTE: THESE VALUES ARE FOR WHERE THE TFSTATE INFORMATION IS KEPT,
##       _NOT_ WHERE YOUR RESOURCES WILL BE
##
## NOTE: THE STORAGE ACCOUNT, CONTAINER NEED TO BE CREATED AHEAD OF TIME.
##       ADDITIONALLY, THE USER RUNNING COMMANDS MUST HAVE DATA CONTRIBUTOR
##       ACCESS TO THE CONTAINER
sed -i "/<tenant_id>/YOUR_TENANT_ID/" backend.hcl                           # Tenant where the tfstate info will be
sed -i "/<subscription_id>/YOUR_SUBSCRIPTION_ID/" backend.hcl               # Subscription where the tfstate info will be
sed -i "/<resource_group_name>/YOUR_RESOURCE_GROUP_NAME/" backend.hcl       # Resource Group where the tfstate will be
sed -i "/<storage_account_name>/YOUR_STORAGE_ACCOUNT_NAME/" backend.hcl     # Storage Account where the tfstate will be
sed -i "/<container_name>/YOUR_CONTAINER_NAME/" backend.hcl                 # Storage Container where the tfstate will be
sed -i "/<key>/KEY/" backend.hcl                                            # Path in the container where the tfstate will be

# 5  Initialise Terraform (local state first)
terraform init -backend-config=backend.hcl

# 6  Plan & apply
terraform plan -var-file=envs/dev.tfvars
terraform apply -var-file=envs/dev.tfvars

# 7  Destroy when finished
terraform destroy -var-file=envs/dev.tfvars
```

### PowerShell

```powershell
# 1  move example variable values
move-item .\envs\dev.example.tfvars__ .\envs\dev.tfvars

# 2 Update the values inside envs/dev.tfvars
(get-Content envs/dev.tfvars) -replace "<tenant_id>", "YOUR_TENANT_ID" `
                          -replace "<subscription_id>", "YOUR_SUBSCRIPTION_ID" `
                          -replace "<resource_group_name>", "YOUR_RESOURCE_GROUP_NAME" `
                          -replace "<location>", "YOUR_LOCATION" | `
    Set-Content envs/dev.tfvars

# 3 Create backend.hcl configuration file
move-item -path .\backend.hcl.example -destination .\backend.hcl -force

# 4 Update backend.hcl file
## NOTE: THESE VALUES ARE FOR WHERE THE TFSTATE INFORMATION IS KEPT,
##       _NOT_ WHERE YOUR RESOURCES WILL BE
##
## NOTE: THE STORAGE ACCOUNT, CONTAINER NEED TO BE CREATED AHEAD OF TIME.
##       ADDITIONALLY, THE USER RUNNING COMMANDS MUST HAVE DATA CRONTRIBUTOR
##       ACCESS TO THE CONTAINER
(get-Content backend.hcl) -replace "<tenant_id>", "YOUR_TENANT_ID" `                            # Tenant where the tfstate info will be
                          -replace "<subscription_id>", "YOUR_SUBSCRIPTION_ID" `                # Subscription where the tfstate info will be
                          -replace "<resource_group_name>", "YOUR_RESOURCE_GROUP_NAME" `        # Resource Group where the tfstate will be
                          -replace "<storage_account_name>", "YOUR_STORAGE_ACCOUNT_NAME" `      # Storage Account where the tfstate will be
                          -replace "<container_name>", "YOUR_CONTAINER_NAME" `                  # Storage Container where the tfstate will be
                          -replace "<key>", "KEY" |                                             # Path in the container where the tfstate will be
    Set-Content backend.hcl

# 5  Initialise Terraform (local state first)
terraform init -backend-config=backend.hcl

# 6  Plan & apply
terraform plan -var-file=envs/dev.tfvars
terraform apply -var-file=envs/dev.tfvars

# 7  Destroy when finished
terraform destroy -var-file=envs/dev.tfvars
```
