module "database" {
	source: "../../modules/database"
	identifier: var.name
	password: var.db_password
}