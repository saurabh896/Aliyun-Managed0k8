provider "alicloud" {
    region = var.region != "" ? var.region: "cn-beijing"
    
}

resource "alicloud_cs_managed_kubernetes" "this" {
  count = length(local.vswitch_ids) > 0 ? 1 :0
  name = local.k8_name
  version = var.version_no
  worker_instance_types = var.worker_instance_types
  worker_number         = var.worker_number
  worker_vswitch_ids    = local.vswitch_ids
  new_nat_gateway       = var.new_vpc == true ? false : var.new_nat_gateway
 }

 data "alicloud_instance_types" "default" {
   cpu_core_count = var.cpu_core_count
   memory_size = var.memory_size
 }
#load vswitch on count basis

 data "alicloud_zones" "default" {
   available_instance_types = data.alicloud_instance_types.default.ids[0]
 }

