locals {
  common_tags = {
    company      = var.company
    project      = "${var.company}-${var.project}"
    billing_code = var.billing_code
    environment  = terraform.workspace == "default" ? "" : "${terraform.workspace}"
    # Apply the current az user as the owner tag
    owner = "kristoju"
  }

  workspaces_suffix = terraform.workspace == "default" ? "" : "${terraform.workspace}"
  web_suffix        = "<h1>${terraform.workspace}</h1>"
}
