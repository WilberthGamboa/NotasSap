En SAP OData, los filtros enviados en la URL (como $filter=material eq 'fds') se procesan y se almacenan en estructuras llamadas select-options. Estas select-options tienen varios componentes, y uno de ellos es el campo LOW. Este campo es clave porque en SAP, las estructuras select-options están diseñadas para manejar condiciones de filtrado de manera flexible.

Vamos a desglosar por qué el campo LOW contiene el valor 'fds' en este contexto:

1. Select-Options en SAP
En SAP, las select-options son estructuras que permiten definir condiciones de filtrado sobre datos. Cada select-option tiene los siguientes campos clave:

SIGN: Determina si el valor es para incluir (I) o excluir (E) registros.
OPTION: Define el operador de comparación (por ejemplo, EQ para igual, GT para mayor que, etc.).
LOW: Contiene el valor más bajo o el valor específico para la comparación. En el caso de un operador como EQ (igual), LOW contiene el valor a comparar.
HIGH: Se usa si hay un rango de valores, pero en el caso de EQ, no se usa.