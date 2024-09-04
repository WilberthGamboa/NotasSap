# Convenciones para el Nombre de Variables en ABAP

En ABAP, existen convenciones comunes para nombrar variables y otros elementos en el código. Seguir estas convenciones ayuda a mantener el código legible y consistente.

## 1. Prefijo según el tipo de variable

- **`lv_`**: Variables locales  
  Ejemplo: `lv_numero`
  
- **`gv_`**: Variables globales  
  Ejemplo: `gv_contador`
  
- **`lt_`**: Tablas internas  
  Ejemplo: `lt_datos`
  
- **`ls_`**: Estructuras  
  Ejemplo: `ls_persona`
  
- **`gt_`**: Tablas internas globales  
  Ejemplo: `gt_datos`
  
- **`gs_`**: Estructuras globales  
  Ejemplo: `gs_datos`

## 2. Uso de guiones bajos (`_`) para separar palabras

- Mejora la legibilidad.
- Ejemplo: `lv_total_suma` en lugar de `lvtotalsuma`.

## 3. Nombres descriptivos

- Utiliza nombres que describan claramente su propósito o el tipo de datos.
- Ejemplo: `lv_precio_total` es más claro que `lv_pt`.

## 4. Prefijos para constantes

- **`lc_`**: Para constantes  
  Ejemplo: `lc_maximo_valor`.

## 5. Prefijos para parámetros y select-options

- **`p_`**: Parámetros de selección  
  Ejemplo: `p_fecha`.
  
- **`s_`**: Rango de selección (select-options)  
  Ejemplo: `s_material`.

## 6. Nombres de clases y métodos

- **Clases**: Utilizar `ZCL_` o `YCL_` como prefijo para clases personalizadas.  
  Ejemplo: `ZCL_GESTION_MATERIALES`.
  
- **Métodos**: Utilizar un nombre que refleje la acción del método, usualmente en formato verbo-sustantivo.  
  Ejemplo: `calcular_total`, `actualizar_datos`.

## Ejemplo de Convención

```abap
DATA: lv_numero_material TYPE matnr,
      lt_materiales TYPE TABLE OF mara,
      ls_material TYPE mara,
      lc_maximo_valor TYPE I VALUE 100.

SELECT * FROM mara INTO TABLE lt_materiales WHERE matnr LIKE '000000000001%'.

LOOP AT lt_materiales INTO ls_material.
  WRITE: / ls_material-matnr, ls_material-maktx.
ENDLOOP.
