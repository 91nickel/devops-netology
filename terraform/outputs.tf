output "account_id" {
  value = data.aws_caller_identity.current.account_id
}

output "caller_user" {
  value = data.aws_caller_identity.current.user_id
}

output "region_name" {
  value = data.aws_region.current.name
}

output "private_ip" {
  value = data.aws_instance.web.private_ip
}

output "subnet_id" {
  value = data.aws_instance.web.subnet_id
}
