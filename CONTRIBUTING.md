# 🤝 Guía de Contribución al IDP Educativo

¡Gracias por tu interés en contribuir a la plataforma educativa! Esta guía te ayudará a contribuir de manera efectiva.

## 📋 Tabla de Contenidos

1. [Para Profesores: Crear un Nuevo Laboratorio](#para-profesores-crear-un-nuevo-laboratorio)
2. [Para Desarrolladores: Mejorar la Plataforma](#para-desarrolladores-mejorar-la-plataforma)
3. [Proceso de Revisión](#proceso-de-revisión)
4. [Estándares y Convenciones](#estándares-y-convenciones)
5. [Obtener Ayuda](#obtener-ayuda)

---

## 🎓 Para Profesores: Crear un Nuevo Laboratorio

### Opción 1: Usar Backstage Template (⭐ Recomendado)

**La forma más fácil de contribuir con un nuevo laboratorio**:

1. **Accede a Backstage**
   - Ve a: `https://backstage.eci-idp.click`
   - Inicia sesión con tu cuenta institucional

2. **Crea tu laboratorio**
   - Click en **"Create"** en el sidebar izquierdo
   - Busca: **"🤝 Contribuir Nuevo Laboratorio al Catálogo"**
   - Click en **"Choose"**

3. **Completa el formulario**
   
   **Paso 1 - Tu información**:
   - Nombre completo
   - Email institucional
   - Usuario de GitHub
   
   **Paso 2 - Información del laboratorio**:
   - Nombre (formato: `mi-nuevo-lab`)
   - Título descriptivo
   - Descripción clara
   - Nivel de dificultad
   - Duración estimada
   - Tags relevantes
   - Objetivos de aprendizaje

   **Paso 3 - Sistema Padre** (opcional):
   - Selección de sistema padre si aplica

4. **Confirma la creación**
   - Click en **"Create"**
   - El sistema genera:
     - Branch dedicada para tu laboratorio
     - Estructura base completa
     - Draft Pull Request

5. **Desarrolla tu laboratorio**
   
   Clona el repositorio y trabaja en tu branch:
   
   ```bash
   # Clona el repositorio (si no lo has hecho)
   git clone https://github.com/educational-idp-MR/idp-stacks.git
   cd idp-stacks
   
   # Fetch y checkout a tu branch
   git fetch origin
   git checkout feature/lab-[tu-nombre]-by-[tu-usuario]
   
   # Navega a tu laboratorio
   cd aws-templates/entities/[tu-laboratorio]
   ```
   
   **Estructura generada**:
   ```
   aws-templates/entities/[tu-laboratorio]/
   ├── README.md                 # ⚠️ Principal: Contenido del lab
   ├── PROFESSOR_GUIDE.md        # 📖 Guía detallada para crear labs
   ├── CONTRIBUTING.md           # 🤝 Cómo otros pueden contribuir
   ├── catalog-info.yaml         # 📋 Metadata para Backstage
   ├── LAB_METADATA.yaml         # 📊 Info de creación (no modificar)
   ├── docs/                     # 📚 Documentación adicional
   │   ├── guides/              # Guías paso a paso
   │   └── resources/           # Diagramas, screenshots
   ├── src/                      # 💻 Código de la aplicación
   ├── config/                   # ⚙️ Archivos de configuración
   ├── scripts/                  # 🛠️ Scripts de utilidad
   └── kustomize/               # ☸️ Manifiestos K8s (si aplica)
   ```

6. **Haz commits según avances**
   
   ```bash
   # Haz cambios en los archivos
   git add .
   git commit -m "docs: add laboratory objectives and prerequisites"
   git push origin feature/lab-[tu-nombre]-by-[tu-usuario]
   ```
   
   Usa commits semánticos: `docs:`, `feat:`, `fix:`

7. **Prueba tu laboratorio**
   
   Antes de marcar como "Ready for Review":
   - [ ] Sigue tu propio lab completo como si fueras estudiante
   - [ ] Verifica que todos los comandos funcionan
   - [ ] Pide a un colega que lo pruebe
   - [ ] Considera una prueba piloto con 1-2 estudiantes
   - [ ] Revisa el checklist en el PR

8. **Solicita revisión**
   
   1. Ve a tu Pull Request en GitHub
   2. Marca el PR como **"Ready for Review"**
   3. Los owners revisarán y proporcionarán feedback
   4. Una vez aprobado, se hará merge a `main`

---

### Opción 2: Fork y PR Manual (Para usuarios avanzados)

1. Haz fork del repositorio
2. Clona y crea una branch: `git checkout -b feature/lab-mi-nuevo-lab`
3. Copia el skeleton: `cp -r aws-templates/entities/contribute-new-lab/skeleton aws-templates/entities/mi-nuevo-lab`
4. Personaliza los archivos (reemplaza variables `${{values.xxx}}`)
5. Desarrolla tu contenido
6. Commit y push: `git commit -m "feat: add laboratory" && git push`
7. Crea Pull Request en GitHub

---

## 💻 Para Desarrolladores: Mejorar la Plataforma

### Tipos de Contribuciones

#### 1. Mejoras a Templates Existentes

Si encuentras un error o mejora en un template existente:

```bash
git checkout -b fix/improve-java-lab
# Haz tus cambios
git commit -m "fix: correct Docker command in java-monitoring-lab"
git push origin fix/improve-java-lab
# Crea PR
```

#### 2. Nuevos Templates de Infraestructura

Para agregar nuevos tipos de templates (no laboratorios educativos):

```bash
git checkout -b feature/new-template-type
# Crea tu template en aws-templates/entities/
git commit -m "feat: add new template for X"
git push origin feature/new-template-type
# Crea PR con descripción detallada
```

#### 3. Mejoras a la Documentación

```bash
git checkout -b docs/improve-contributing-guide
# Edita documentación
git commit -m "docs: clarify contribution process"
git push origin docs/improve-contributing-guide
# Crea PR
```

#### 4. Mejoras a Scripts y Automatización

```bash
git checkout -b feat/add-verification-script
# Agrega o mejora scripts
git commit -m "feat: add automated lab verification"
git push origin feat/add-verification-script
# Crea PR
```

---

## 🔍 Proceso de Revisión

### Para Contribuidores

1. **Crea tu PR**
   - Usa títulos descriptivos
   - Completa el template del PR
   - Marca como Draft si aún no está listo

2. **Espera feedback** (2-5 días hábiles)

3. **Implementa cambios** si se solicitan

4. **Merge** - Los owners hacen merge una vez aprobado

### Para Reviewers (Owners)

Cuando revises un PR de laboratorio:

**Checklist de Revisión**:

#### Contenido Pedagógico
- [ ] Los objetivos de aprendizaje son claros y medibles
- [ ] La progresión es lógica (simple → complejo)
- [ ] Las instrucciones son claras y completas
- [ ] Los ejercicios están bien diseñados
- [ ] Hay soluciones verificadas para todos los ejercicios

#### Calidad Técnica
- [ ] Todos los comandos funcionan correctamente
- [ ] El código está bien comentado
- [ ] No hay información sensible (passwords, API keys)
- [ ] La estructura sigue las convenciones
- [ ] Los scripts de verificación funcionan

#### Documentación
- [ ] El README está completo
- [ ] Los prerrequisitos están documentados
- [ ] La estimación de tiempo es realista
- [ ] Hay troubleshooting para problemas comunes
- [ ] Las referencias externas son válidas

#### Metadata
- [ ] `catalog-info.yaml` está correctamente configurado
- [ ] Los tags son apropiados
- [ ] El nivel de dificultad es correcto
- [ ] Se agregó al `catalog-info.yaml` principal (si aplica)

**Proceso**:

1. **Review inicial** (1-2 días)
   - Lee el contenido completo
   - Identifica issues mayores
   - Proporciona feedback constructivo

2. **Testing** (1-2 días)
   - Ejecuta el laboratorio completo
   - Verifica que todos los pasos funcionan
   - Prueba en diferentes entornos si es posible

3. **Approval o Request Changes**
   - Si hay issues: solicita cambios específicos
   - Si está listo: aprueba y merge

4. **Post-merge**
   - Verifica que aparece en Backstage
   - Monitorea por issues de usuarios

---

## 📏 Estándares y Convenciones

### Commits

Usa [Conventional Commits](https://www.conventionalcommits.org/):

```bash
feat: add new laboratory about Docker
fix: correct command in kubernetes lab
docs: improve README instructions
style: format code consistently
refactor: reorganize lab structure
test: add verification scripts
chore: update dependencies
```

### Branch Naming

```
feature/lab-[nombre]-by-[usuario]    # Nuevo laboratorio
fix/[descripcion]                     # Corrección de bug
docs/[descripcion]                    # Mejora de documentación
refactor/[descripcion]                # Refactorización
```

### Estructura de Directorios

```
aws-templates/entities/[nombre-lab]/
├── README.md                  # Obligatorio
├── catalog-info.yaml          # Obligatorio
├── PROFESSOR_GUIDE.md         # Opcional
├── CONTRIBUTING.md            # Opcional
├── docs/                      # Recomendado
├── src/                       # Si incluye código
├── config/                    # Si incluye configuración
├── scripts/                   # Si incluye scripts
└── kustomize/                 # Si despliega en K8s
```

### Documentación

**Markdown**:
- Usa headers jerárquicos (H1, H2, H3)
- Incluye tabla de contenidos para docs largos
- Usa code blocks con sintaxis highlight
- Incluye emojis para mejor UX: 🎯 ✅ ⚠️ 💡

**Code Comments**:
```python
# ✅ BIEN: Comentario que explica el "por qué"
# Usamos un timeout de 30s porque el servicio puede tardar
# en inicializar completamente después del deploy
timeout = 30

# ❌ MAL: Comentario que repite el código
# Establece el timeout a 30
timeout = 30
```

### Naming Conventions

- **Laboratorios**: `kebab-case` (ej: `kubernetes-deployments-lab`)
- **Archivos**: `kebab-case.md` o `PascalCase.yaml`
- **Variables**: `camelCase` en código, `UPPER_SNAKE_CASE` para env vars

---

## 🆘 Obtener Ayuda

### Canales de Soporte

1. **GitHub Discussions**
   - Preguntas generales sobre la plataforma
   - Ideas para nuevos laboratorios
   - Mejores prácticas
   - URL: `https://github.com/educational-idp-MR/idp-stacks/discussions`

2. **GitHub Issues**
   - Reportar bugs
   - Solicitar features
   - Problemas técnicos
   - URL: `https://github.com/educational-idp-MR/idp-stacks/issues`

3. **Pull Request Comments**
   - Preguntas sobre tu PR específico
   - Clarificaciones sobre feedback
   - Discusión técnica de implementación

4. **Slack** (si disponible)
   - Canal: `#profesores-labs`
   - Chat en tiempo real
   - Networking con otros profesores

5. **Email**
   - Para asuntos privados o sensibles
   - Contacto: [email institucional]

### FAQ

**¿Cuánto tiempo toma revisar un PR?**  
2-5 días hábiles. Si no hay respuesta en 1 semana, menciona a los owners.

**¿Puedo modificar un laboratorio después del merge?**  
Sí. Crea una nueva branch y haz un PR con las mejoras.

**¿Cómo se reconocen las contribuciones?**  
Apareces en GitHub Contributors y en el `LAB_METADATA.yaml` del laboratorio.

---

## 📊 Métricas de Contribución

Puedes ver estadísticas de contribuciones:

```bash
# Tus contribuciones
git log --author="tu-email@escuelaing.edu.co" --oneline

# Laboratorios por autor
grep -r "professorName:" aws-templates/entities/*/LAB_METADATA.yaml

# Contribuciones por mes
git log --since="1 month ago" --pretty=format:"%an" | sort | uniq -c
```

---

## 🎉 Reconocimientos

Gracias a todos los profesores y colaboradores que han contribuido:

- Ver lista completa: [Contributors](https://github.com/educational-idp-MR/idp-stacks/graphs/contributors)

---

## 📄 Licencia

Al contribuir a este proyecto, aceptas que tus contribuciones serán
licenciadas bajo la misma licencia que el proyecto principal.

---

## 🚀 ¡Empieza a Contribuir!

**¿Listo para crear tu primer laboratorio?**

1. Ve a [Backstage](https://backstage.eci-idp.click)
2. Click en "Create"
3. Selecciona "🤝 Contribuir Nuevo Laboratorio"
4. ¡Sigue las instrucciones!

**¿Tienes preguntas?**

- 💬 Abre un [Discussion](https://github.com/educational-idp-MR/idp-stacks/discussions)
- 🐛 Reporta un [Issue](https://github.com/educational-idp-MR/idp-stacks/issues)
- 📧 Escribe a: [email institucional]

---

**¡Gracias por hacer que esta plataforma educativa sea mejor para todos! 🎓✨**
