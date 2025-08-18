# ${values.name}

${values.description}

## Propósito de este proyecto

Esta es una aplicación Spring Boot sencilla diseñada para demostrar el proceso de despliegue manual en una instancia AWS EC2. El objetivo es ilustrar las ineficiencias y complejidades asociadas con un proceso de despliegue manual, en contraste con las soluciones automatizadas de CI/CD.

## Requisitos previos

- Cliente SSH o SFTP (como FileZilla, WinSCP o la herramienta `scp`)
- Acceso a la clave privada (.pem) asociada con la instancia EC2
- JDK 11 o superior instalado en la instancia EC2
- Maven instalado en la instancia EC2 (opcional, si deseas compilar en el servidor)

## Instrucciones para el despliegue manual

### Paso 1: Compilar la aplicación

Desde la raíz del proyecto, ejecuta:

```bash
mvn clean package
```

Esto generará el archivo JAR en la carpeta `target/`.

### Paso 2: Transferir el archivo JAR a la instancia EC2

Usando SCP:

```bash
scp -i /ruta/a/tu-clave.pem target/${values.name}-0.0.1-SNAPSHOT.jar ec2-user@[DIRECCIÓN-IP-EC2]:/home/ec2-user/
```

Alternativamente, puedes usar un cliente SFTP con interfaz gráfica como FileZilla o WinSCP.

### Paso 3: Conectarse a la instancia EC2

```bash
ssh -i /ruta/a/tu-clave.pem ec2-user@[DIRECCIÓN-IP-EC2]
```

### Paso 4: Ejecutar la aplicación

Una vez conectado a la instancia EC2:

```bash
java -jar ${values.name}-0.0.1-SNAPSHOT.jar
```

Para ejecutar la aplicación en segundo plano:

```bash
nohup java -jar ${values.name}-0.0.1-SNAPSHOT.jar > app.log 2>&1 &
```

### Paso 5: Verificar que la aplicación esté funcionando

Accede a la aplicación a través del navegador:

```
http://[DIRECCIÓN-IP-EC2]:8080
```

O usando curl desde la línea de comandos:

```bash
curl http://[DIRECCIÓN-IP-EC2]:8080
```

## Consideraciones y limitaciones del despliegue manual

- **Sin alta disponibilidad**: Si la instancia falla, la aplicación no estará disponible.
- **Sin escalabilidad automática**: No hay forma de escalar automáticamente según la carga.
- **Sin gestión de secretos**: Las credenciales deben ser gestionadas manualmente.
- **Sin monitoreo integrado**: No hay dashboards ni alertas automáticas.
- **Proceso propenso a errores**: El despliegue manual puede llevar a problemas de configuración inconsistente.
- **Tiempo de inactividad durante actualizaciones**: Las actualizaciones requieren detener y reiniciar el servicio.

## Recursos adicionales

- [Documentación de Spring Boot](https://spring.io/projects/spring-boot)
- [Guía de AWS para instancias EC2](https://docs.aws.amazon.com/ec2/)
- [Mejores prácticas de CNOE para despliegue de aplicaciones](https://cnoe.io/docs)
