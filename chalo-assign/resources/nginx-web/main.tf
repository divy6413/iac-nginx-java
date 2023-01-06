module "nginx-web" {
	source: "../../modules/nginx-web"
	count=var.count
	region=var.region
	publickey=var.publickey
	key=var.key
	amis=var.amis
}