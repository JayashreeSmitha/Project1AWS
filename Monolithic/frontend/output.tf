output "vpc_id" {
  value = module.network.vpc_id
}

output "public_subnet_ids" {
  value = module.network.public_subnet_ids
}

# output "web_server_id" {
#   value = module.compute.web_server_id
# }

# output "db_instance_id" {
#   value = module.database.db_instance_id
# }

# output "alb_arn" {
#   value = module.alb.alb_arn
# }
