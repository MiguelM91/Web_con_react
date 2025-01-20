output "instance_id" {
  description = "ID de la instancia EC2 creada"
  value       = aws_instance.ReactApp.id
}

output "public_ip" {
  description = "IP pública de la instancia EC2"
  value       = aws_instance.ReactApp.public_ip
}

output "security_group_id" {
  description = "ID del grupo de seguridad"
  value       = var.vpc_security_group_ids
}

output "subnet_id" {
  description = "ID de la subred utilizada"
  value       = var.subnet_id
}

output "ami_version" {
  description = "AMI utilizada para la instancia EC2"
  value       = aws_instance.ReactApp.ami
}

output "user_data_output" {
  description = "Salida del script User Data"
  value       = aws_instance.ReactApp.user_data
}
