provider "alicloud" {
  version              = ">=1.56.0"
  region               = var.region != "" ? var.region : null
  
}

resource "random_uuid" "name" { }

locals {
  name = var.name != "" ? var.name : substr("ram-user-${replace(random_uuid.name.result,"-","")}",0,32)
}
#####################################################################
                                # RAM #
#####################################################################
resource "alicloud_ram_user" "this" {
  name = local.name

}

resource "alicloud_ram_login_profile" "this" {
    user_name = alicloud_ram_user.this.name
    password = random_uuid.name.result
}

#####################################################################
                                # RAM GROUP #
#####################################################################
resource "alicloud_ram_group" "kl_group_reader" {
    name = var.group_name != "" ? var.group_name: "Reader_group"
    comments = local.comments
    force = true
    }

#####################################################################
                                # Policies #
#####################################################################

data "alicloud_ram_policies" "read_user_policies_kl" {
  output_file = "kl_policies.txt"
  group_name  = "group1"
  type        = "Custom"
}

#####################################################################
                            # Groups-RAM #
#####################################################################
resource "alicloud_ram_group_membership" "membership1" {
    group_name = var.group_name
    user_names = var.user_name_membership_group1

}

#####################################################################
                            # Policy Attachment #
#####################################################################

data "template_file" "read_policy_docs" {
    template = file("read_policy.json")
}

resource "alicloud_ram_policy" "policy" {
  name     = "policyName_read"
  document = data.template_file.read_policy_docs.rendered
  description = "this is a Read policy test"
  force = true
}