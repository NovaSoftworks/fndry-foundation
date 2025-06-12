output "prd" {
  value = {
    shared_vpc_host_project_id = module.env_prd.shared_vpc_host_project_id
    shared_vpc_id              = module.env_prd.shared_vpc_id
    runtimes_folder_id        = module.env_prd.runtimes_folder_id
  }
}
