En OData, un **Entity Set** representa una colección de entidades del mismo tipo y admite varias operaciones CRUD (Crear, Leer, Actualizar, Eliminar), además de ciertas capacidades para interactuar con los datos. Las anotaciones que controlan estas operaciones pueden incluir configuraciones como **pageable**, **creatable**, **searchable**, entre otras. A continuación, te explico las principales capacidades que se pueden definir para un **Entity Set**:

## 1. **Creatable**
- **Descripción:** Indica si se pueden crear nuevas entidades en el conjunto.
- **Uso:** Si es `true`, los clientes pueden agregar nuevas entidades a este conjunto.

### Ejemplo:
```xml
<EntitySet Name="Products" EntityType="Namespace.Product" sap:creatable="true" />
```

## 2. **Updatable**
- **Descripción:** Indica si se pueden actualizar las entidades existentes en el conjunto.
- **Uso:** Si es `true`, los clientes pueden modificar las entidades ya presentes en el conjunto.

### Ejemplo:
```xml
<EntitySet Name="Products" EntityType="Namespace.Product" sap:updatable="true" />
```

## 3. **Deletable**
- **Descripción:** Indica si se pueden eliminar entidades del conjunto.
- **Uso:** Si es `true`, los clientes pueden eliminar entidades del conjunto.

### Ejemplo:
```xml
<EntitySet Name="Products" EntityType="Namespace.Product" sap:deletable="true" />
```

## 4. **Pageable**
- **Descripción:** Permite la paginación de los resultados en las consultas, lo que es útil para manejar grandes volúmenes de datos.
- **Uso:** Si es `true`, los clientes pueden solicitar los resultados paginados.

### Ejemplo:
```xml
<EntitySet Name="Products" EntityType="Namespace.Product" sap:pageable="true" />
```

## 5. **Searchable**
- **Descripción:** Indica si se pueden realizar búsquedas en las entidades del conjunto.
- **Uso:** Si es `true`, los clientes pueden usar parámetros de búsqueda en sus consultas.

### Ejemplo:
```xml
<EntitySet Name="Products" EntityType="Namespace.Product" sap:searchable="true" />
```

## 6. **Sortable**
- **Descripción:** Permite a los clientes ordenar los resultados de las consultas por una o más propiedades.
- **Uso:** Si es `true`, los clientes pueden usar la propiedad para ordenar los resultados.

### Ejemplo:
```xml
<EntitySet Name="Products" EntityType="Namespace.Product" sap:sortable="true" />
```

## 7. **Filterable**
- **Descripción:** Indica si se pueden aplicar filtros a las consultas de este conjunto.
- **Uso:** Si es `true`, los clientes pueden especificar criterios de filtro en sus solicitudes.

### Ejemplo:
```xml
<EntitySet Name="Products" EntityType="Namespace.Product" sap:filterable="true" />
```

## 8. **Expand**
- **Descripción:** Permite a los clientes incluir entidades relacionadas en la respuesta de la consulta.
- **Uso:** Si es `true`, los clientes pueden usar la opción `$expand` para incluir propiedades de navegación en la respuesta.

### Ejemplo:
```xml
<NavigationProperty Name="Orders" Type="Collection(Namespace.Order)" sap:expandable="true" />
```

## Resumen de Capacidades del Entity Set
Aquí tienes un resumen de las capacidades que puedes definir para un **Entity Set**:

| Capacidades   | Descripción                                                                 |
|---------------|-----------------------------------------------------------------------------|
| `creatable`   | Permite la creación de nuevas entidades en el conjunto.                    |
| `updatable`   | Permite la actualización de entidades existentes.                           |
| `deletable`   | Permite la eliminación de entidades del conjunto.                          |
| `pageable`    | Permite la paginación de resultados en consultas.                          |
| `searchable`  | Permite realizar búsquedas en el conjunto.                                 |
| `sortable`    | Permite ordenar resultados por propiedades.                                 |
| `filterable`  | Permite aplicar filtros en las consultas.                                  |
| `expandable`  | Permite incluir entidades relacionadas en la respuesta.                     |

Estas capacidades permiten a los clientes interactuar con el **Entity Set** de manera efectiva y flexible, mejorando la experiencia de uso de la API OData.