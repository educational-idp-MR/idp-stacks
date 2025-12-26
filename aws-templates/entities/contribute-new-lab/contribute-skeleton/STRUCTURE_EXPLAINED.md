# 🏗️ Entendiendo la Estructura del Laboratorio

## 📊 Vista General

Este laboratorio tiene una estructura de **DOS NIVELES** que puede parecer confusa al principio. Esta guía te ayudará a entender cada parte.

## 🎭 Los Dos Niveles

```
┌─────────────────────────────────────────────────────────────┐
│  NIVEL 1: PROFESOR (este directorio)                        │
│  → Lo que TÚ desarrollas y mantienes                        │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│  📄 template.yaml         ← Define el formulario para       │
│                              estudiantes                     │
│  📄 README.md             ← Documentación del laboratorio   │
│  📄 PROFESSOR_GUIDE.md    ← Guía para crear contenido       │
│  📄 CONTRIBUTING.md       ← Cómo contribuir                  │
│  📄 catalog-info.yaml     ← Metadata en Backstage           │
│  📁 docs/                 ← Documentación pedagógica        │
│                                                              │
│  ┌───────────────────────────────────────────────────────┐ │
│  │ NIVEL 2: ESTUDIANTE (directorio skeleton/)            │ │
│  │ → Lo que RECIBEN los estudiantes cuando usan el       │ │
│  │   template                                             │ │
│  ├───────────────────────────────────────────────────────┤ │
│  │                                                        │ │
│  │ 📁 skeleton/                                           │ │
│  │   ├── 📄 README.md         ← Lo primero que ven       │ │
│  │   ├── 📄 catalog-info.yaml ← Metadata de su proyecto  │ │
│  │   ├── 📄 .gitignore                                   │ │
│  │   ├── 📄 mkdocs.yml        ← Config de documentación  │ │
│  │   ├── 📁 docs/             ← Docs del proyecto        │ │
│  │   └── 📁 [tu-código]       ← Código del laboratorio   │ │
│  │                                                        │ │
│  └────────────────────────────────────────────────────────┘ │
│                                                              │
└──────────────────────────────────────────────────────────────┘
```

## 🔄 Flujo Completo

### Paso 1: Profesor Desarrolla

```
Profesor trabaja en: aws-templates/entities/mi-nuevo-lab/
│
├── Edita template.yaml    → Define qué preguntarle al estudiante
├── Edita README.md        → Documenta el laboratorio
├── Desarrolla skeleton/   → Crea el código/contenido
    │
    ├── skeleton/README.md           → Instrucciones para el estudiante
    ├── skeleton/src/app.py          → Código que modificarán
    ├── skeleton/config/settings.yml → Configuración
    └── skeleton/...                 → Más archivos
```

### Paso 2: Laboratorio se Publica

```
PR se aprueba → Merge a main → Lab en Backstage

Aparece en el catálogo como:
"🎓 Mi Nuevo Laboratorio" (el template.yaml)
```

### Paso 3: Estudiante Usa el Template

```
Estudiante en Backstage:
│
├── Ve "🎓 Mi Nuevo Laboratorio"
├── Click en "Choose"
├── Completa formulario (definido en template.yaml)
├── Click en "Create"
│
└→ Se crea NUEVO repositorio con contenido de skeleton/
    │
    ├── README.md            ← De skeleton/README.md
    ├── catalog-info.yaml    ← De skeleton/catalog-info.yaml
    ├── src/app.py           ← De skeleton/src/app.py
    └── ...                  ← Todo lo que estaba en skeleton/
```

## 📝 Ejemplo Práctico

### Ejemplo: Laboratorio de Docker

#### Nivel Profesor (lo que desarrollas):

```
docker-basics-lab/
├── template.yaml              ← "¿Nombre del proyecto? ¿Qué lenguaje?"
├── README.md                  ← "Este lab enseña Docker básico"
├── skeleton/                  ← ⬇️ Lo que recibe el estudiante ⬇️
    ├── README.md              ← "Bienvenido a tu proyecto Docker"
    ├── Dockerfile             ← Dockerfile pre-configurado
    ├── app.py                 ← Aplicación Python de ejemplo
    └── docker-compose.yml     ← Compose file
```

#### Nivel Estudiante (lo que reciben):

Cuando Juan usa el template y pone "juan-docker-project":

```
juan-docker-project/           ← Repositorio nuevo
├── README.md                  ← Copiado de skeleton/README.md
├── Dockerfile                 ← Copiado de skeleton/Dockerfile
├── app.py                     ← Copiado de skeleton/app.py
└── docker-compose.yml         ← Copiado de skeleton/docker-compose.yml
```

## 🎯 Qué Editar Como Profesor

### 1. `template.yaml` (Raíz)

**Propósito**: Define el formulario para estudiantes

```yaml
parameters:
  - title: Configuración
    properties:
      name:
        type: string
        title: Nombre del Proyecto
      # Agrega más campos según necesites
```

**Cuándo editar**: Cuando necesites preguntar algo al estudiante

### 2. `skeleton/` (Subdirectorio)

**Propósito**: Todo lo que los estudiantes recibirán

**Qué poner aquí**:
- ✅ Código base de la aplicación
- ✅ Archivos de configuración
- ✅ Tests de ejemplo
- ✅ Scripts de utilidad
- ✅ README con instrucciones para el estudiante

**Estructura recomendada dentro de skeleton/**:
```
skeleton/
├── README.md              ← Instrucciones paso a paso
├── catalog-info.yaml      ← Metadata
├── src/                   ← Código fuente
├── tests/                 ← Tests
├── config/                ← Configuración
└── docs/                  ← Documentación
```

### 3. `README.md` (Raíz)

**Propósito**: Documentar el laboratorio para el catálogo

**Incluye**:
- Descripción del laboratorio
- Objetivos de aprendizaje
- Prerrequisitos
- Guía paso a paso
- Ejercicios y soluciones

## ❓ Preguntas Frecuentes

### ¿Por qué hay dos README.md?

1. **README.md (raíz)**: Documenta el LABORATORIO (para profesores y el catálogo)
2. **skeleton/README.md**: Instrucciones para el ESTUDIANTE (lo que ven en su proyecto)

### ¿Dónde pongo el código de la aplicación?

En `skeleton/` y subdirectorios. Todo lo que esté ahí se copiará al proyecto del estudiante.

### ¿Cómo sé si algo va en la raíz o en skeleton/?

Pregúntate: **¿El estudiante necesita este archivo en su proyecto?**

- ✅ SÍ → Va en `skeleton/`
- ❌ NO → Va en la raíz (es documentación del lab)

### ¿Qué son las variables `${{values.xxx}}`?

Son placeholders que se reemplazan automáticamente:

- En `template.yaml`: Los valores que el estudiante ingresa
- En `skeleton/*`: Se reemplazan al crear el proyecto

Ejemplo:
```markdown
# skeleton/README.md
# Proyecto: ${{values.name}}

Cuando el estudiante pone "mi-proyecto", se convierte en:
# Proyecto: mi-proyecto
```

## ✅ Checklist de Desarrollo

Cuando desarrolles tu laboratorio, asegúrate de:

- [ ] `template.yaml` tiene todos los campos necesarios
- [ ] `skeleton/README.md` tiene instrucciones claras para estudiantes
- [ ] `skeleton/` tiene todo el código/archivos necesarios
- [ ] `README.md` (raíz) documenta bien el laboratorio
- [ ] Probaste crear un proyecto desde el template
- [ ] Las variables `${{values.xxx}}` se reemplazan correctamente

## 🚀 Workflow de Desarrollo

1. **Crea el esqueleto básico**:
   ```bash
   cd skeleton/
   # Crea la estructura que recibirá el estudiante
   mkdir -p src tests config docs
   ```

2. **Desarrolla el contenido en `skeleton/`**:
   - Código de la aplicación
   - Tests de ejemplo
   - Configuración
   - Documentación para estudiantes

3. **Configura `template.yaml`**:
   - Define qué preguntarle al estudiante
   - Configura los pasos de creación

4. **Documenta en `README.md` (raíz)**:
   - Explica el laboratorio
   - Objetivos y ejercicios

5. **Prueba localmente** (si es posible):
   - Usa el template
   - Verifica que todo se copia correctamente
   - Valida las variables

## 💡 Tips

- **Mantén `skeleton/` simple**: No sobrecargues con demasiados archivos
- **Usa comentarios**: En el código de `skeleton/`, guía al estudiante
- **README claro**: El `skeleton/README.md` es crítico
- **Variables estratégicas**: Usa `${{values.xxx}}` para personalización

---

**¿Aún confundido?** Revisa el laboratorio de ejemplo: `java-monitoring-lab`

**¿Necesitas ayuda?** Abre un Discussion en GitHub o contacta al equipo
