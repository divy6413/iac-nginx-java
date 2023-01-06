module "java-app" {
	source: "../../modules/java-app"
	count=var.count
	region=var.region
	publickey=var.publickey
	key=var.key
	amis=var.amis
}