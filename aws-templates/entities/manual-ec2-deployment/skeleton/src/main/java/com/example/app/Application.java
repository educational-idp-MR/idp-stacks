package com.example.app;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@SpringBootApplication
public class Application {

    public static void main(String[] args) {
        SpringApplication.run(Application.class, args);
    }

    @RestController
    static class HelloController {
        
        @GetMapping("/")
        public String hello() {
            return "¡Bienvenido a la aplicación ${values.name}!\n\n"
                 + "Esta aplicación ha sido desplegada manualmente en una instancia EC2.\n"
                 + "Podría estar desplegada automáticamente a través de CI/CD si usáramos herramientas adecuadas.\n\n"
                 + "Fecha y hora actual del servidor: " + java.time.LocalDateTime.now();
        }
        
        @GetMapping("/health")
        public String health() {
            return "OK";
        }
    }
}
