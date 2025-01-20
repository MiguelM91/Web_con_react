#VPC

# resource "aws_vpc" "lab_vpc" {
#   cidr_block = "10.0.0.0/16"
#   tags = {
#     Name = "lab_vpc"
#   }
# }

# #PUBLIC SUBNET
# resource "aws_subnet" "lab_public_subnet" {
#   vpc_id                  = aws_vpc.lab_vpc.id
#   cidr_block              = "10.0.1.0/24"
#   map_public_ip_on_launch = true
#   availability_zone       = "us-east-2a"
#   tags = {
#     Name = "lab_public_subnet"
#   }
# }

# #INTERNET GATEWAY
# resource "aws_internet_gateway" "lab_igw" {
#   vpc_id = aws_vpc.lab_vpc.id
#   tags = {
#     Name = "lab_igw"
#   }
# }

# #PUBLIC ROUTE TABLE
# resource "aws_route_table" "lab_public_rt" {
#   vpc_id = aws_vpc.lab_vpc.id
#   route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = aws_internet_gateway.lab_igw.id
#   }
#   tags = {
#     Name = "lab_public_rt"
#   }
# }

# #ROUTE TABLE ASSOCIATION WITH PUBLIC SUBNET
# resource "aws_route_table_association" "public_subnet_assoc" {
#   subnet_id      = aws_subnet.lab_public_subnet.id
#   route_table_id = aws_route_table.lab_public_rt.id
# }

# #ELASTIC IP
# resource "aws_eip" "lab_nat_eip" {
#   depends_on = [aws_internet_gateway.lab_igw]
# }

# #SECURITY GROUP
# resource "aws_security_group" "ReactApp_sg" {
#   name        = "ReactApp_sg"
#   description = "Allow SSH and HTTP"
#   vpc_id      = aws_vpc.lab_vpc.id

#   ingress {
#     from_port   = 22
#     to_port     = 22
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   ingress {
#     from_port   = 80
#     to_port     = 80
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   # Nueva regla para permitir el acceso al puerto 8081
#   ingress {
#     from_port   = 8081
#     to_port     = 8081
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   # Nueva regla para permitir el acceso al puerto 3000
#   ingress {
#     from_port   = 3000
#     to_port     = 3000
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"          # -1 significa todos los protocolos
#     cidr_blocks = ["0.0.0.0/0"] # Todo el tráfico hacia cualquier IP pública
#   }

#   tags = {
#     Name = "ReactApp-SG"
#   }
# }

#INSTANCE
resource "aws_instance" "ReactApp" {
  ami                         = "ami-036841078a4b68e14"
  associate_public_ip_address = true
  instance_type               = "t2.micro"
  subnet_id                   = var.subnet_id
  key_name                    = "NginxServerKP"
  vpc_security_group_ids      = [var.vpc_security_group_ids]

  user_data = <<-EOF
                  #!/bin/bash

                  # Redirigir salida y errores a un archivo de registro
                  exec > /var/log/user_data.log 2>&1

                  # Actualización e instalación de herramientas
                  sudo apt-get update -y
                  sudo apt-get upgrade -y
                  sudo apt-get install -y git
                  sudo apt-get install -y nginx                  
                  sudo apt-get install -y nodejs npm

                  # Clonar repositorio
                  cd /home/ubuntu
                  git clone https://github.com/MiguelM91/Web_con_react.git

                  cd Web_con_react

                  # Instalar dependencias del proyecto
                  sudo npm install

                  # Corregir error de compatibilidad por versión de Node con OpenSSL
                  export NODE_OPTIONS=--openssl-legacy-provider

                  # Iniciar proyecto en segundo plano
                  sudo npm start &

                  # Habilitar y arrancar Nginx y Docker
                  systemctl start nginx
                  systemctl enable nginx                  

                  # Verificar versiones instaladas
                  git --version > /home/ubuntu/installed_versions.txt
                  nginx -v >> /home/ubuntu/installed_versions.txt 2>&1                  
                  node --version >> /home/ubuntu/installed_versions.txt
                EOF


  root_block_device {
    delete_on_termination = true
    volume_size           = 10
    volume_type           = "gp2"
  }

  tags = {
    Name = "ReactApp-Instance"
  }
}