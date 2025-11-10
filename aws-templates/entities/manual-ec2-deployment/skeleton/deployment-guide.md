# Guía de Despliegue Manual en AWS EC2

Esta guía detalla el proceso paso a paso para desplegar manualmente una aplicación Spring Boot en una instancia EC2 de AWS.

## Acceso a la instancia EC2

Tu instancia EC2 ha sido aprovisionada con los siguientes detalles:

- **IP pública**: [Se mostrará después del despliegue]
- **Usuario por defecto**: ec2-user (Amazon Linux 2) o ubuntu (Ubuntu)
- **Key pair**: ${values.keyPairName}

## Paso 1: Preparar el archivo JAR

Primero, necesitas compilar la aplicación Spring Boot:

```bash
# Desde la raíz del proyecto
mvn clean package
```

Esto generará un archivo JAR en la carpeta `target/` con el nombre `${values.name}-0.0.1-SNAPSHOT.jar`.

## Paso 2: Transferir el archivo JAR a la instancia EC2

### Usando SCP (Línea de comandos)

```bash
scp -i /ruta/a/tu-clave.pem target/${values.name}-0.0.1-SNAPSHOT.jar ec2-user@[IP-DE-TU-INSTANCIA]:/home/ec2-user/
```

### Usando FileZilla (GUI)

1. Abre FileZilla
2. Ve a Archivo > Administrador de sitios
3. Haz clic en "Nuevo sitio" y configura:
   - Protocolo: SFTP
   - Servidor: [IP-DE-TU-INSTANCIA]
   - Modo de acceso: Archivo de clave
   - Usuario: ec2-user
   - Archivo de clave: Selecciona tu archivo .pem
4. Conecta y arrastra el archivo JAR desde tu sistema local al servidor

## Paso 3: Preparar la instancia EC2

Conéctate a la instancia:

```bash
ssh -i /ruta/a/tu-clave.pem ec2-user@[IP-DE-TU-INSTANCIA]
```

Instala Java 11 en la instancia:

**Amazon Linux 2:**
```bash
sudo amazon-linux-extras install java-openjdk11
java -version
```

**Ubuntu:**
```bash
sudo apt update
sudo apt install openjdk-11-jdk -y
java -version
```

## Paso 4: Ejecutar la aplicación

Una vez conectado y con Java instalado:

```bash
# Ejecutar en primer plano
java -jar ${values.name}-0.0.1-SNAPSHOT.jar

# O ejecutar en segundo plano
nohup java -jar ${values.name}-0.0.1-SNAPSHOT.jar > app.log 2>&1 &
```

Para verificar que la aplicación está en ejecución:
```bash
ps aux | grep java
```

## Paso 5: Configurar el acceso al puerto 8080

Tu aplicación Spring Boot se ejecuta en el puerto 8080 por defecto. Asegúrate de que el grupo de seguridad de la instancia EC2 permita el tráfico en este puerto:

1. Ve a la consola de AWS
2. Navega a EC2 > Instancias
3. Selecciona tu instancia
4. Ve a la pestaña "Seguridad"
5. Haz clic en el grupo de seguridad
6. En "Reglas de entrada", haz clic en "Editar reglas de entrada"
7. Añade una regla:
   - Tipo: TCP personalizado
   - Intervalo de puertos: 8080
   - Origen: 0.0.0.0/0 (o tu IP específica para mayor seguridad)
   - Descripción: Spring Boot Application

## Paso 6: Acceder a la aplicación

Una vez que la aplicación esté ejecutándose y el puerto 8080 esté abierto:

- Abre un navegador web y visita: `http://[IP-DE-TU-INSTANCIA]:8080`
- O usa curl: `curl http://[IP-DE-TU-INSTANCIA]:8080`

## Consideraciones sobre el despliegue manual

Este proceso de despliegue manual presenta varios inconvenientes:

1. **Tiempo consumido**: El proceso completo puede tomar entre 15-30 minutos cada vez.
2. **Propenso a errores**: Los comandos manuales pueden contener errores.
3. **Sin control de versiones**: Es difícil saber qué versión está desplegada.
4. **Sin rollback sencillo**: Volver a una versión anterior es complicado.
5. **Sin alta disponibilidad**: La aplicación se ejecuta en una única instancia.
6. **Dificultad para monitorear**: No hay integración automática con sistemas de monitoreo.

## Alternativas en Cloud Native

En un entorno Cloud Native, este mismo despliegue podría automatizarse mediante:

1. **Pipelines de CI/CD** con herramientas como Jenkins, GitHub Actions, o ArgoCD
2. **Despliegue en Kubernetes** para gestión de contenedores y escalabilidad
3. **Infrastructure as Code** con Terraform o CloudFormation
4. **Gestión de configuración** con Ansible, Puppet o Chef
5. **Monitoreo integrado** con Prometheus y Grafana

Estos enfoques modernos eliminarían la necesidad de acceso manual al servidor y reducirían significativamente el tiempo de despliegue y los errores humanos.

## Recursos adicionales

- [Documentación oficial de AWS EC2](https://docs.aws.amazon.com/ec2/)
- [Spring Boot - Production-ready Features](https://docs.spring.io/spring-boot/docs/current/reference/html/production-ready-features.html)
- [CNOE - Mejores prácticas de despliegue](https://cnoe.io/docs)
