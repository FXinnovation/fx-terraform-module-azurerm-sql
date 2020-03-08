module "example" {
  source = "../test/module"

  enabled                                 = false
  resource_group_name                     = "boo"
  location                                = "West US"
  sql_server_names                        = ["fxtest"]
  sql_server_versions                     = ["2.0"]
  sql_server_administrator_login          = ["test"]
  sql_server_administrator_login_password = ["test123"]
}
