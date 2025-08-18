terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# El provider de AWS tomará automáticamente las credenciales de las variables de entorno:
# - AWS_ACCESS_KEY_ID
# - AWS_SECRET_ACCESS_KEY
# - AWS_REGION
provider "aws" {
  region = var.aws_region
  # Las credenciales se proporcionan a través de variables de entorno
  # configuradas en el secret que monta tofu-controller
}

# Crear security group para la instancia EC2
resource "aws_security_group" "app_sg" {
  name        = "${var.app_name}-sg"
  description = "Security Group para instancia EC2 de despliegue manual"

  # Acceso SSH
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.allowed_ip_range]
    description = "SSH Access"
  }

  # Acceso a la aplicación Spring Boot
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = [var.allowed_ip_range]
    description = "Spring Boot Application"
  }

  # Tráfico de salida
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }

  tags = {
    Name        = "${var.app_name}-sg"
    Project     = var.app_name
    CreatedBy   = "backstage"
    Environment = "dev"
  }
}

# Obtener la última AMI de Amazon Linux 2
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# Crear la instancia EC2
resource "aws_instance" "app_instance" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = var.instance_type
  key_name               = var.key_pair_name
  vpc_security_group_ids = [aws_security_group.app_sg.id]

  user_data = <<-EOF
    #!/bin/bash -xe
    # Actualizar paquetes
    yum update -y
    
    # Instalar Java 11
    amazon-linux-extras install java-openjdk11 -y
    
    # Crear directorio para la aplicación
    mkdir -p /opt/${var.app_name}
    
    # Crear un script de servicio
    cat > /etc/systemd/system/${var.app_name}.service << 'EOT'
    [Unit]
    Description=${var.app_name} Service
    After=network.target
    
    [Service]
    User=ec2-user
    WorkingDirectory=/opt/${var.app_name}
    ExecStart=/usr/bin/java -jar /opt/${var.app_name}/${var.app_name}.jar
    SuccessExitStatus=143
    Restart=always
    
    [Install]
    WantedBy=multi-user.target
    EOT
    
    # Establecer permisos en el directorio de la aplicación
    chown -R ec2-user:ec2-user /opt/${var.app_name}
    chmod 755 /opt/${var.app_name}
    
    # Instalar herramientas útiles
    yum install -y htop git wget
  EOF

  tags = {
    Name            = "${var.app_name}-instance"
    Project         = var.app_name
    CreatedBy       = "backstage"
    DeploymentMethod = "manual"
  }
}

# Outputs
output "instance_id" {
  value = aws_instance.app_instance.id
}

output "public_ip" {
  value = aws_instance.app_instance.public_ip
}

output "public_dns" {
  value = aws_instance.app_instance.public_dns
}

output "ssh_command" {
  value = "ssh -i ${var.key_pair_name}.pem ec2-user@${aws_instance.app_instance.public_dns}"
}

output "application_url" {
  value = "http://${aws_instance.app_instance.public_dns}:8080"
}
