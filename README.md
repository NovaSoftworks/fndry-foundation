# Nova Cloud Foundation Infrastructure

This repository contains the Terraform configurations for the Nova Crafting Platform's foundation infrastructure layer. The foundation layer establishes the core organizational structure, networking, and security components in Google Cloud.

## Important Notes

This foundation layer creates the following resources in Google Cloud:
- Environment folders (`prd`, `tst`, etc.) under the `novacp` folder
- Shared VPC networks for each environment
- Platforms folders to organize landing zones
- IAM configurations for foundation resources

This is a configuration repository (not a reusable module) that defines a specific deployment of novacp's foundation infrastructure.

## Prerequisites

For the deployments to work, ensure that:
- The [bootstrap layer](https://github.com/NovaSoftworks/fndry-bootstrap) has been successfully deployed
- The `foundation-infra-sa` service account has been created with appropriate permissions and Workload Identity Federation granting access from this repository

