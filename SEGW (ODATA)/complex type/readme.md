En OData, los **Complex Types** son tipos de datos que agrupan varias propiedades relacionadas pero **no tienen una clave primaria** como los **Entity Types**. Los Complex Types se usan para definir estructuras anidadas dentro de una entidad, lo que permite organizar los datos de manera más modular y estructurada.

### Características de los Complex Types:

1. **Sin clave primaria**: A diferencia de un **Entity Type**, un Complex Type no tiene una clave primaria y no existe de manera independiente. Siempre se utiliza como parte de otro Entity Type u otro Complex Type.

2. **Agrupación de propiedades**: Un Complex Type agrupa varias propiedades que pueden ser de tipos simples (`Edm.String`, `Edm.Int32`, etc.) o incluso de otros Complex Types. Es útil cuando varias propiedades están conceptualmente relacionadas y quieres evitar redundancia en los Entity Types.

3. **Anidación dentro de entidades**: Un Complex Type no se puede utilizar de forma independiente. Siempre debe estar incluido como una propiedad de un Entity Type u otro Complex Type. Sirve para estructurar mejor la información.

4. **Reusabilidad**: Puedes definir un Complex Type una vez y reutilizarlo en múltiples Entity Types, lo que facilita la consistencia y modularidad en el modelo de datos.

### Ejemplo de Complex Type:

Supongamos que tienes una entidad **Cliente**, y deseas modelar su dirección como un conjunto de propiedades. En lugar de incluir directamente los campos de la dirección en el Entity Type **Cliente**, puedes definir un Complex Type **Dirección** que luego puedes usar dentro de otros Entity Types también, como **Proveedor**, **Tienda**, etc.

```xml
<ComplexType Name="Dirección">
    <Property Name="Calle" Type="Edm.String" Nullable="false"/>
    <Property Name="Ciudad" Type="Edm.String" Nullable="false"/>
    <Property Name="CódigoPostal" Type="Edm.String" Nullable="false"/>
    <Property Name="País" Type="Edm.String" Nullable="false"/>
</ComplexType>

<EntityType Name="Cliente">
    <Key>
        <PropertyRef Name="ID"/>
    </Key>
    <Property Name="ID" Type="Edm.Int32" Nullable="false"/>
    <Property Name="Nombre" Type="Edm.String" Nullable="false"/>
    <Property Name="Dirección" Type="Namespace.Dirección"/>
</EntityType>
```

### Cómo se usa:

1. En este ejemplo, el Complex Type **Dirección** define las propiedades relacionadas con la dirección de un cliente, como `Calle`, `Ciudad`, `CódigoPostal` y `País`.
   
2. Luego, el Entity Type **Cliente** incluye una propiedad llamada `Dirección` de tipo **Dirección**, que agrupa todas esas propiedades bajo un solo campo.

### Ventajas de los Complex Types:
- **Modularidad**: Permiten separar y reutilizar conjuntos de propiedades relacionadas en diferentes Entity Types.
- **Legibilidad**: Hacen que el modelo de datos sea más claro y fácil de entender, especialmente cuando tienes múltiples entidades que comparten propiedades comunes.
- **Reutilización**: Un Complex Type definido una vez puede ser usado en varios Entity Types, reduciendo la duplicación de código.

### Diferencia con los Entity Types:
- **Complex Types** no tienen claves y no pueden existir por sí solos; son siempre parte de un Entity Type u otro Complex Type.
- **Entity Types** tienen claves primarias y pueden ser entidades independientes que se pueden crear, leer, actualizar o eliminar (CRUD).

En resumen, un **Complex Type** es una forma eficiente de estructurar y organizar datos complejos que no necesitan una identidad propia, pero que forman parte de un **Entity Type** mayor.