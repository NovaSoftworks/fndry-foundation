# Nova Cloud Foundation Infrastructure

This repository contains the Terraform configurations for Nova Cloud's foundation infrastructure layer. The foundation layer establishes the core organizational structure, networking, and security components in Google Cloud.

## Important Notes

This foundation layer creates the following resources in Google Cloud:
- Environment folders (`prd`, `tst`, etc.) under the Nova Cloud organization
- Shared VPC networks for each environment
- Platforms folders to organize landing zones
- IAM configurations for foundation resources

This is a configuration repository (not a reusable module) that defines a specific deployment of Nova Cloud's foundation infrastructure.

## Prerequisites

For the deployments to work, ensure that:
- The [bootstrap layer](/NovaSoftworks/fndry-bootstrap) has been successfully deployed
- The `nvcld-foundation-infra-sa` service account has been created with appropriate permissions and Workload Identity Federation granting access from this repository
- `The backend.tf` file has been updated with the terraform state bucket created at bootstrap time

