provider "alicloud" {
    region = var.region != "" ? var.region: "cn-beijing"
    
}

resource "alicloud_cs_managed_kubernetes" "this" {
  count = length(local.vswitch_ids) > 0 ? 1 :0
  name = local.k8_name
  version = var.version_no
 }