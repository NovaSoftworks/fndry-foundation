output "prd" {
  value = {
    shared_vpc_host_project_id = module.env_prd.shared_vpc_host_project_id
    shared_vpc_id              = module.env_prd.shared_vpc_id
    platforms_folder_id        = module.env_prd.platforms_folder_id
  }
}
