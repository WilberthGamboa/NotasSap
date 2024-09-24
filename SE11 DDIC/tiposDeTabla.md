# Clases de Entrega en SAP

En SAP, las **clases de entrega** (Delivery Classes) son un atributo importante que se asigna a las tablas cuando se crean en el diccionario de datos (Data Dictionary - SE11). Este atributo determina **cómo** se gestionarán los datos dentro de la tabla en diferentes situaciones, como transporte entre sistemas, actualización de datos durante actualizaciones de versiones y en la importación/exportación de datos.

## Función de las Clases de Entrega
Las clases de entrega definen principalmente dos aspectos clave:

1. **El comportamiento de la tabla en los transportes de SAP**: Determinan si los datos de una tabla deben ser transportados desde un sistema a otro (por ejemplo, desde un sistema de desarrollo a uno productivo) cuando se realizan cambios en el diccionario de datos o cuando se aplican transportes.

2. **El tratamiento de los datos durante las actualizaciones de versiones**: Indican si los datos de la tabla se conservan o se sobreescriben cuando se aplica una nueva versión de SAP o durante la instalación de parches.

## Clases de Entrega Comunes
Aquí se enumeran las clases de entrega más usadas y su descripción:

### 1. A (Application table, master and transaction data)
- Se utiliza para tablas que almacenan **datos maestros** (como clientes, proveedores, materiales) y **datos de transacciones** (como pedidos de compra, facturas, movimientos de stock).
- **Los datos no se transportan**, solo se transporta la estructura de la tabla. Los datos no se sobrescriben durante actualizaciones de versiones.

### 2. C (Customizing table, data is transportable)
- Para tablas que contienen datos de **customizing** (ajustes de configuración específicos del cliente).
- **Los datos se transportan** entre sistemas (por ejemplo, de desarrollo a producción).
- Los datos no se sobrescriben automáticamente durante actualizaciones de versiones.

### 3. L (Table for storing temporary data)
- Se usa para tablas que almacenan **datos temporales** o de trabajo.
- No se transportan los datos ni se conservan durante actualizaciones. Solo la estructura es transportada.

### 4. G (Customizing table, data is not transportable)
- Similar a la clase de entrega C, pero los **datos no se transportan** automáticamente entre sistemas.
- Generalmente, estas tablas se utilizan para datos de configuración que son locales a un sistema específico.

### 5. E (System table, SAP internal use)
- Para tablas utilizadas por el **sistema SAP** de forma interna.
- Estas tablas contienen datos internos del sistema que son gestionados por SAP, y no están pensadas para ser manipuladas por el cliente.

### 6. S (System table, data is transportable)
- Similar a la clase E, pero en este caso, **los datos se transportan**.
- Se utiliza principalmente para tablas que contienen datos de control del sistema que deben estar alineados entre diferentes entornos.

## Importancia
Al definir correctamente la clase de entrega de una tabla, aseguras que los datos sean tratados adecuadamente durante actualizaciones, transportes y migraciones, lo que evita errores y garantiza la estabilidad del sistema SAP.

## Ejemplo
Si defines una tabla personalizada que contiene configuraciones del cliente (como reglas de precios), podrías asignarle la clase de entrega **C**, lo que permitiría transportar los datos de esa tabla entre sistemas.

## Resumen
- Las clases de entrega especifican cómo se comportan los datos de una tabla durante transportes y actualizaciones.
- Existen diferentes clases de entrega según el tipo de datos que almacena la tabla (datos maestros, customizing, datos temporales, etc.).
