# Sistema Backend de Gestión de Inventario, Ventas y Usuarios

## 1. Descripción General

Este repositorio contiene el **backend del Sistema de Gestión de Inventario, Ventas y Usuarios**, desarrollado como una **API RESTful** utilizando **Spring Boot 4.0.1 y Java 21**.

El proyecto está orientado exclusivamente al **backend**, y su objetivo es servir como base sólida, segura y mantenible para la gestión de inventario, ventas, usuarios y roles, siguiendo metodologías ágiles (SCRUM) y prácticas profesionales de ingeniería de software.

---

## 2. Objetivo del Proyecto

* Centralizar la gestión de inventario y ventas.
* Aplicar metodologías profesionales usadas en entornos reales de desarrollo.
* Facilitar el trabajo colaborativo y el seguimiento del progreso mediante herramientas ágiles.

---

## 3. Alcance del Sistema (Backend)

Incluye:

* Gestión de usuarios y roles.
* Gestión de productos e inventario.
* Registro de ventas y clientes.
* Persistencia en base de datos relacional.
* Auditoría básica de operaciones.

---

## 4. Stack Tecnológico

| Capa                 | Tecnologías            |
| -------------------- | ---------------------- |
| Lenguaje             | Java 21                |
| Framework            | Spring Boot 4.0.1      |
| Persistencia         | Spring Data JPA        |
| Base de datos        | PostgreSQL 16 (Docker) |
| Migraciones          | Flyway                 |
| Seguridad            | Spring Security        |
| Testing              | JUnit 5, Mockito       |
| Gestión del proyecto | Jira (SCRUM)           |

---

## 5. Diagramas del Sistema

Los siguientes diagramas representan el diseño actual del backend y sirven como referencia común para todo el equipo.

### 5.1 Diagrama de Casos de Uso

![Diagrama de Casos de Uso](<img width="1135" height="622" alt="Diagrama Casos de Uso drawio" src="https://github.com/user-attachments/assets/34ef2256-8aff-46cc-8572-dabfbbe59bfa" />)


**Descripción:**
Define las interacciones entre los distintos roles del sistema y las funcionalidades del backend.

---

### 5.2 Diagrama de Secuencia

![Diagrama de Secuencia](<img width="1126" height="721" alt="Diagrama de Secuencia drawio" src="https://github.com/user-attachments/assets/8e5729b3-7e80-49bc-9763-e4ff0cc5c9dd" />
)

**Descripción:**
Representa el flujo de una operación típica desde la solicitud HTTP hasta la persistencia en base de datos.

---

### 5.3 Diagrama de Clases

![Diagrama de Clases](<img width="721" height="544" alt="DiagramadeClases drawio" src="https://github.com/user-attachments/assets/8bc7735f-268e-4894-afb6-666a5d4112a0" />)

**Descripción:**
Muestra las entidades principales del dominio y sus relaciones.

---

### 5.4 Diagrama de Base de Datos

![Diagrama de Base de Datos](<img width="2500" height="2143" alt="Diagrama DB-Diagrama ER drawio" src="https://github.com/user-attachments/assets/a0b48436-cfa7-499b-b8c4-76a55d0b17c2" />
)

**Descripción:**
Refleja el modelo físico de datos implementado mediante migraciones Flyway.

---

## 6. Organización del Equipo y Roles

### 6.1 Roles de Proyecto (SCRUM)

| Rol           | Responsable       |
| ------------- | ----------------- |
| Product Owner | Santiago Chávez   |
| SCRUM Máster  | David Carreño     |
| Líder Técnico | Santiago Avendaño |
| Programador   | Andrés Monroy     |

### 6.2 Roles de Codificación

| Área               | Responsable       |
| ------------------ | ----------------- |
| Backend            | Santiago Avendaño |
| Base de Datos      | David Carreño     |
| Frontend           | Santiago Chávez   |
| Apoyo Codificación | Andrés Monroy     |

**Nota:** Aunque cada rol tiene responsabilidades claras, se espera colaboración entre todos los miembros. El responsable de cada sección actúa como líder técnico de dicha área.

---

## 7. Metodología de Trabajo

El proyecto sigue **SCRUM**, con revisiones de avance cada **3 días**, basadas en:

* Backlog del producto
* Historias de usuario
* Tickets y asignaciones en Jira

Los sprints y prioridades se ajustarán de forma iterativa según el avance del proyecto.

---

## 8. Decisiones Pendientes (Opciones Profesionales)

Las siguientes decisiones **aún no han sido definidas**. Se presentan opciones comúnmente usadas en proyectos profesionales para ser discutidas y seleccionadas por el equipo.

### 8.1 Arquitectura del Backend

| Opción                 | Descripción                                                    |
| ---------------------- | -------------------------------------------------------------- |
| Arquitectura en capas  | Controller, Service, Repository tradicionales                  |
| Clean Architecture     | Separación estricta de dominio, casos de uso e infraestructura |
| Arquitectura Hexagonal | Uso de puertos y adaptadores                                   |

---

### 8.2 Estrategia de Control de Versiones

| Estrategia              | Características                                         |
| ----------------------- | ------------------------------------------------------- |
| Git Flow                | Ramas `main`, `develop`, `feature`, `release`, `hotfix` |
| Trunk Based Development | Desarrollo sobre una rama principal                     |
| GitHub Flow             | Ramas cortas + pull requests                            |

---

### 8.3 Convención de Commits

| Convención                        | Uso                                       |
| --------------------------------- | ----------------------------------------- |
| Commits libres                    | Sin estructura fija                       |
| Conventional Commits              | `feat`, `fix`, `refactor`, `test`, `docs` |
| Commits semánticos personalizados | Reglas definidas por el equipo            |

---

### 8.4 Nomenclatura y Estilo de Código

| Aspecto           | Opciones comunes                                   |
| ----------------- | -------------------------------------------------- |
| Naming            | camelCase, PascalCase, snake_case                  |
| Paquetes          | Por capa / Por dominio                             |
| Manejo de errores | Excepciones genéricas / Excepciones personalizadas |

---

### 8.5 Estrategia de Testing

| Estrategia | Descripción                           |
| ---------- | ------------------------------------- |
| Test after | Tests escritos después del código     |
| TDD        | Tests antes de la implementación      |
| Mixta      | TDD para core, test after para bordes |

---

### 8.6 Gestión de Historias y Tickets (Jira)

| Elemento             | Opciones                               |
| -------------------- | -------------------------------------- |
| Historias de usuario | Plantilla simple / Gherkin             |
| Bugs                 | Tickets separados / integrados         |
| Sprints              | Cortos (1 semana) / Medios (2 semanas) |

---

## 9. Estructura del Repositorio

```text
inventory_system_backend/
├── README.md
├── docs/
│   ├── architecture.md
│   ├── security.md
│   ├── project_plan.md
│   ├── tdd_strategy.md
│   ├── coding_guidelines.md
│   └── diagrams/
├── src/
│   ├── main/
│   └── test/
├── docker-compose.yml
├── pom.xml
└── .gitignore
```

---

## 10. Estado del Proyecto

**Fase actual:** Definición y documentación

No se ha iniciado el desarrollo de lógica de negocio hasta cerrar las decisiones pendientes.

---

## 11. Documentación Complementaria

Toda la documentación detallada del proyecto se encuentra en la carpeta `/docs`.

---

## 12. Licencia

Licencia pendiente de definición.

---

## 13. Nota Final

Este README actúa como **documento base del proyecto**. Ninguna decisión técnica o de proceso debe implementarse sin haber sido previamente discutida y documentada.
