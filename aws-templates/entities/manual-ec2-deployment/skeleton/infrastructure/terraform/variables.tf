variable "aws_region" {
  description = "Región de AWS donde se desplegará la infraestructura"
  type        = string
  default     = "${values.awsRegion}"
}

variable "app_name" {
  description = "Nombre de la aplicación, se utilizará para etiquetar los recursos"
  type        = string
  default     = "${values.name}"
}

variable "instance_type" {
  description = "Tipo de instancia EC2 a utilizar"
  type        = string
  default     = "${values.ec2InstanceType}"
}

variable "key_pair_name" {
  description = "Nombre del par de claves para acceso SSH"
  type        = string
  default     = "${values.keyPairName}"
}

variable "allowed_ip_range" {
  description = "Rango CIDR permitido para acceso SSH y a la aplicación"
  type        = string
  default     = "${values.allowedIpRange}"
}
