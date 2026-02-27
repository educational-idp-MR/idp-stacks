# Estructura del Laboratorio

## Vista General

Cada laboratorio tiene una estructura de **dos niveles**. Entender esta separación es clave para contribuir correctamente.

## Los Dos Niveles

**Nivel 1 — Profesor (raíz del laboratorio):** es lo que tú desarrollas y mantienes. Aquí van los archivos que definen y documentan el laboratorio, pero que el estudiante **nunca** recibe directamente.

- `template.yaml` — Define el formulario que el estudiante completa en Backstage.
- `README.md` — Documentación del laboratorio para el catálogo.
- `catalog-info.yaml` — Metadata para Backstage.
- `docs/` — Documentación pedagógica adicional.

**Nivel 2 — Estudiante (directorio `skeleton/`):** es lo que los estudiantes **reciben** cuando usan el template. Todo lo que pongas dentro de `skeleton/` se copia tal cual al nuevo repositorio del estudiante.

- `skeleton/README.md` — Lo primero que ve el estudiante.
- `skeleton/catalog-info.yaml` — Metadata de su proyecto.
- `skeleton/.gitignore` — Archivos a ignorar en Git.
- `skeleton/mkdocs.yml` — Configuración de documentación.
- `skeleton/docs/` — Docs del proyecto.
- `skeleton/[tu-código]/` — Código y recursos del laboratorio.

> **Regla simple:** si el estudiante necesita el archivo en su proyecto, va en `skeleton/`. Si no, va en la raíz.

## Ejemplo: Laboratorio de Docker

Supongamos que creas un lab llamado `docker-basics-lab`. La estructura de este proyecto en el repositorio de idp-stacks se vería así:

```
docker-basics-lab/
├── template.yaml              ← Formulario: nombre del proyecto, lenguaje, etc.
├── README.md                  ← Descripción del lab para el catálogo
├── skeleton/                  ← Lo que recibe el estudiante
    ├── README.md              ← Instrucciones del proyecto
    ├── Dockerfile
    ├── app.py
    └── docker-compose.yml
```

Cuando un estudiante usa el template, se crea un repositorio nuevo con el contenido de `skeleton/`:

```
juan-docker-project/
├── README.md
├── Dockerfile
├── app.py
└── docker-compose.yml
```

## Qué editar

### `template.yaml`

Define el formulario que el estudiante completa en Backstage. Editalo cuando necesites agregar o cambiar los datos que se le piden al estudiante.

```yaml
parameters:
  - title: Configuración
    properties:
      name:
        type: string
        title: Nombre del Proyecto
```

### `skeleton/`

Todo lo que pongas aquí termina en el repositorio del estudiante: código base, configuración, tests, scripts, documentación.

### `README.md` (raíz)

Documenta el laboratorio para el catálogo de Backstage: descripción, objetivos, prerrequisitos, ejercicios.

## Variables ``

Son placeholders que Backstage reemplaza automáticamente con los valores que el estudiante ingresa en el formulario.

Por ejemplo, si en `skeleton/README.md` escribes:

```markdown
# Proyecto: java-21-codespaces-lab
```

Y el estudiante ingresa "mi-proyecto", el archivo resultante tendrá:

```markdown
# Proyecto: mi-proyecto
```

## Workflow de desarrollo

1. Crea la estructura dentro de `skeleton/` con el código y recursos que recibirá el estudiante.
2. Configura `template.yaml` con los campos del formulario y los pasos de creación.
3. Documenta el laboratorio en el `README.md` de la raíz (y en el del skeleton en caso de que sea necesario documentar algo que el estudiante necesita).
4. Prueba el template si es posible: verifica que los archivos se copian y las variables se reemplazan correctamente.
