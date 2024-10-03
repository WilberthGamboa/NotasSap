METHOD reprocesoset_get_entityset.
  DATA: lr_filter                TYPE REF TO /iwbep/if_mgw_req_filter,
        lt_filter_select_options TYPE /iwbep/t_mgw_select_option,
        ls_filter_select_options TYPE /iwbep/s_mgw_select_option,
        ls_select_option         TYPE /iwbep/s_cod_select_option,
        lt_selparamproductid     TYPE STANDARD TABLE OF bapi_epm_product_id_range,
        ls_selparamproductid     TYPE bapi_epm_product_id_range.

  " Obtener los filtros de la entidad
  lr_filter = io_tech_request_context->get_filter( ).
  lt_filter_select_options = lr_filter->get_filter_select_options( ).

  DATA: ls_employee LIKE LINE OF et_entityset.

  " Procesar los filtros para obtener el rango de materiales
  LOOP AT lt_filter_select_options INTO ls_filter_select_options.
    IF ls_filter_select_options-property EQ 'IDNRK0'.
      LOOP AT ls_filter_select_options-select_options INTO ls_select_option.
        ls_selparamproductid-sign = ls_select_option-sign.
        ls_selparamproductid-option = ls_select_option-option.
        ls_selparamproductid-low = ls_select_option-low.
        ls_selparamproductid-high = ls_select_option-high.
        APPEND ls_selparamproductid TO lt_selparamproductid.
      ENDLOOP.
    ENDIF.
  ENDLOOP.

  " Tabla para almacenar los datos combinados
  DATA: lt_data TYPE TABLE OF caufv,
        lt_final TYPE TABLE OF resb, " Para almacenar los resultados finales incluyendo RESB
        ls_data  TYPE caufv,
        ls_final TYPE resb.

  " Primer JOIN entre STPO y CAUFV
  SELECT t1~stlnr, t2~PLNBEZ, t2~AUFNR, t2~KTEXT
    FROM stpo AS t1
    INNER JOIN caufv AS t2 ON t1~stlnr = t2~stlnr
    WHERE t1~IDNRK = @ls_selparamproductid-low
    INTO CORRESPONDING FIELDS OF TABLE @lt_data.

  " Segundo JOIN con la tabla RESB para obtener las cantidades de material
  LOOP AT lt_data INTO ls_data.
    SELECT r~aufnr, r~matnr, r~bdmng
      FROM resb AS r
      WHERE r~aufnr = @ls_data-aufnr " Filtrar por el número de orden de producción
      INTO CORRESPONDING FIELDS OF TABLE @lt_final.
  ENDLOOP.

  " Mapear los datos al entityset para la salida final
  et_entityset = VALUE #( 
    FOR ls_data IN lt_data 
    FOR ls_final IN lt_final WHERE ( aufnr = ls_data-aufnr ) " Combinar datos en base a AUFNR
    ( stlnr = ls_data-stlnr
      PLNBEZ = ls_data-PLNBEZ
      AUFNR = ls_data-AUFNR
      KTEXT = ls_data-KTEXT
      MATNR = ls_final-matnr
      BDMNG = ls_final-bdmng ) " Añadir cantidad del material de RESB
  ).
ENDMETHOD.
