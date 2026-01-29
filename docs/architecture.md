# Arquitectura del Sistema

## 1. Propósito del Documento

Este documento define la **arquitectura del backend** del *Sistema de Gestión de Inventario, Ventas y Usuarios*. Su objetivo es establecer una **base técnica común** para todo el equipo antes de iniciar el desarrollo, asegurando coherencia, mantenibilidad y escalabilidad.

Este documento **no implementa decisiones finales**, sino que presenta **opciones de arquitectura utilizadas profesionalmente**, las cuales deberán ser discutidas y seleccionadas por el equipo.

---

## 2. Contexto del Sistema

El sistema es una **API RESTful**, responsable de:

* Gestión de inventario
* Registro de ventas y clientes
* Gestión de usuarios y roles
* Persistencia de datos
* Control de acceso y auditoría



---

## 3. Opciones de Arquitectura Backend

### 3.1 Arquitectura en Capas Tradicional (Layered Architecture)

**Descripción:**

Separación del sistema en capas técnicas bien definidas.

**Capas comunes:**

* Controller (API / REST)
* Service (lógica de negocio)
* Repository (persistencia)
* Model / Entity

**Características:**

* Alta adopción en proyectos Spring
* Curva de aprendizaje baja
* Dependencia directa entre capas

---

### 3.2 Clean Architecture

**Descripción:**

Arquitectura centrada en el dominio y los casos de uso, con dependencias dirigidas hacia el núcleo del sistema.

**Capas comunes:**

* Domain (entidades y reglas de negocio)
* Application / Use Cases
* Infrastructure
* Interfaces (controllers, adapters)

**Características:**

* Dominio independiente de frameworks
* Alta mantenibilidad
* Mayor complejidad inicial

---

### 3.3 Arquitectura Hexagonal (Ports and Adapters)

**Descripción:**

Variación de Clean Architecture enfocada en el desacoplamiento mediante puertos y adaptadores.

**Componentes clave:**

* Puertos de entrada (casos de uso)
* Puertos de salida (repositorios, servicios externos)
* Adaptadores

**Características:**

* Alta testabilidad
* Fácil sustitución de infraestructura
* Estructura más estricta

---

## 4. Comparación de Arquitecturas

| Criterio                 | Capas Tradicional | Clean Architecture | Hexagonal  |
| ------------------------ | ----------------- | ------------------ | ---------- |
| Complejidad inicial      | Baja              | Media              | Media-Alta |
| Testabilidad             | Media             | Alta               | Alta       |
| Acoplamiento a framework | Alto              | Bajo               | Bajo       |
| Escalabilidad            | Media             | Alta               | Alta       |
| Uso en industria         | Muy alto          | Alto               | Alto       |

---

## 5. Organización de Paquetes (Opciones)

### 5.1 Organización por Capas

```
controller/
service/
repository/
entity/
```

---

### 5.2 Organización por Dominio

```
user/
product/
sale/
customer/
```

---

## 6. Flujo General de una Request

Opciones de flujo comúnmente utilizadas:

1. Cliente → Controller
2. Validación de request
3. Autorización / Seguridad
4. Lógica de negocio
5. Persistencia
6. Auditoría
7. Respuesta

La ubicación exacta de cada paso dependerá de la arquitectura seleccionada.

---

## 7. Integración con Seguridad

Aspectos arquitectónicos a definir:

* Ubicación de filtros de seguridad
* Separación entre autenticación y autorización
* Validación de roles a nivel de casos de uso o controladores
* Manejo de sesiones o tokens

---

## 8. Integración con Persistencia

Opciones comunes:

* Acceso a base de datos mediante repositorios JPA
* Uso de DTOs para desacoplar entidades
* Separación entre modelo de dominio y modelo de persistencia

---

## 9. Arquitectura y Testing

Relación entre arquitectura y pruebas:

* Arquitectura en capas: tests unitarios + integración
* Clean / Hexagonal: tests de casos de uso independientes del framework

---

## 10. Decisiones Pendientes

Las siguientes decisiones deberán tomarse en reunión de equipo:

* Arquitectura definitiva
* Organización de paquetes
* Nivel de desacoplamiento del dominio
* Estrategia de testing asociada

Una vez definidas, este documento deberá actualizarse para reflejar las decisiones finales.

---

## 11. Relación con Otros Documentos

* `security.md`
* `project_plan.md`
* `coding_guidelines.md`
* `tdd_strategy.md`

Este documento actúa como **base estructural** del backend.
