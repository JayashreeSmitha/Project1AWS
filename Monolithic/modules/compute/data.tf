# data "aws_subnets" "example" {
#   filter {
#     name   = "vpc-id"
#     values = ["vpc-042f5effb2d734b58"]
#   }
# }

# data "aws_subnet" "example" {
#   for_each = toset(data.aws_subnets.example.ids)
#   id       = each.value
# }

# # Assuming we tag private subnets with 'subnet-type=private'
# data "aws_subnet" "private_subnets" {
#   for_each = {
#     for s in data.aws_subnets.example.ids : 
#     s => s if length([for tag in data.aws_subnet.example : tag.value if tag.key == "subnet-type" && tag.value == "private"]) > 0
#   }
#   id = each.value
# }

# # Output the CIDR blocks of the private subnets
# output "private_subnet_cidr_blocks" {
#   value = [for s in data.aws_subnet.private_subnets : s.cidr_block]
# }