
# Resumen 100
Un Entity Type en OData define la estructura de los datos que puede enviar o recibir un servicio OData. Es una representación formal de la entidad que el servicio maneja, como una especie de "contrato" que especifica qué datos y en qué formato se pueden procesar.

# Resumen rapido
Entity type es la estructura de la tabla
Entity type set nos permite agregar registro del mismo

En OData, un **Entity Type** (tipo de entidad) representa un objeto o entidad del dominio de datos en el modelo de servicio OData. Es un concepto fundamental en OData que se utiliza para definir la estructura de los datos expuestos por el servicio. A continuación te explico más detalladamente:

## 1. ¿Qué es un Entity Type en OData?

Un **Entity Type** es una plantilla que define las propiedades y características de un objeto específico en tu modelo de datos. Es como una clase en programación orientada a objetos (OOP), donde se describen los atributos y las relaciones del objeto.

Por ejemplo, en un sistema de gestión de empleados, podrías tener un Entity Type llamado `Employee`, que podría tener propiedades como:
- `EmployeeID` (ID del empleado)
- `FirstName` (Primer nombre)
- `LastName` (Apellido)
- `Position` (Posición)
- `HireDate` (Fecha de contratación)

### 2. Componentes de un Entity Type

Un **Entity Type** en OData se define utilizando las siguientes partes:

- **Nombre del Entity Type**: el nombre que describe la entidad (por ejemplo, `Employee`).
- **Propiedades**: son los atributos que describen a la entidad. Pueden ser de tipo primitivo (como `String`, `Integer`, `DateTime`, etc.) o complejas (compuestas de otros tipos).
- **Clave (Key)**: al menos una propiedad debe definirse como la clave primaria, que identifica de manera única a cada instancia de la entidad.
- **Relaciones (Navigation Properties)**: permiten modelar las asociaciones entre diferentes Entity Types, como las relaciones uno a muchos o muchos a muchos.

### 3. Ejemplo de un Entity Type

En OData, un Entity Type podría definirse en el formato de un modelo en XML o anotaciones EDM. Un ejemplo en XML sería:

```xml
<EntityType Name="Employee">
  <Key>
    <PropertyRef Name="EmployeeID" />
  </Key>
  <Property Name="EmployeeID" Type="Edm.Int32" Nullable="false" />
  <Property Name="FirstName" Type="Edm.String" Nullable="false" />
  <Property Name="LastName" Type="Edm.String" Nullable="false" />
  <Property Name="Position" Type="Edm.String" />
  <Property Name="HireDate" Type="Edm.DateTimeOffset" />
</EntityType>
```

Aquí:
- `EmployeeID` es la clave primaria.
- `FirstName`, `LastName`, `Position` y `HireDate` son las propiedades que describen a la entidad `Employee`.

### 4. ¿Cómo se utiliza un Entity Type?

En un servicio OData, los **Entity Types** definen las entidades expuestas en las rutas de la API. Las instancias de un Entity Type se gestionan a través de operaciones CRUD (Create, Read, Update, Delete), permitiendo interactuar con los datos a través de las convenciones de OData.

Por ejemplo:
- Para obtener todos los empleados: `GET /Employees`
- Para obtener un empleado específico: `GET /Employees(1)`

### 5. Relación con Entity Set

Un **Entity Set** es una colección de entidades de un **Entity Type**. Por ejemplo, si `Employee` es un **Entity Type**, entonces `Employees` sería un **Entity Set** que contiene múltiples instancias de `Employee`.

### 6. Entity Type en el contexto de SAP OData

En un servicio OData expuesto por SAP (como en SAP Gateway), los **Entity Types** son una forma de estructurar los datos que provienen de los módulos de SAP (como los datos maestros o transaccionales). Los desarrolladores ABAP crean servicios OData que exponen **Entity Types** para que puedan ser consumidos por aplicaciones externas.


##
