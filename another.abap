METHOD reprocesoset_get_entityset.
  DATA: lr_filter                TYPE REF TO /iwbep/if_mgw_req_filter,
        lt_filter_select_options TYPE /iwbep/t_mgw_select_option,
        ls_filter_select_options TYPE /iwbep/s_mgw_select_option,
        ls_select_option         TYPE /iwbep/s_cod_select_option,
        lt_selparamproductid     TYPE STANDARD TABLE OF bapi_epm_product_id_range,
        lt_selparamfecha          TYPE STANDARD TABLE OF bapi_epm_product_id_range,
        ls_selparamproductid     TYPE bapi_epm_product_id_range,
        ls_selparamfecha    TYPE bapi_epm_product_id_range.

  " Obtener los filtros de la entidad
  lr_filter = io_tech_request_context->get_filter( ).
  lt_filter_select_options = lr_filter->get_filter_select_options( ).
" ERROR


  DATA: ls_employee LIKE LINE OF et_entityset.

  " Procesar los filtros para obtener el rango de materiales
  LOOP AT lt_filter_select_options INTO ls_filter_select_options.
    IF ls_filter_select_options-property EQ 'IDNRK'.
      LOOP AT ls_filter_select_options-select_options INTO ls_select_option.
        ls_selparamproductid-sign = ls_select_option-sign.
        ls_selparamproductid-option = ls_select_option-option.
        ls_selparamproductid-low = ls_select_option-low.
        ls_selparamproductid-high = ls_select_option-high.
        APPEND ls_selparamproductid TO lt_selparamproductid.
      ENDLOOP.


    ELSEIF ls_filter_select_options-property EQ 'DATS'.
      LOOP AT ls_filter_select_options-select_options INTO ls_select_option.
        ls_selparamfecha-sign = ls_select_option-sign.
        ls_selparamfecha-option = ls_select_option-option.
        ls_selparamfecha-low = ls_select_option-low.
        ls_selparamfecha-high = ls_select_option-high.
        APPEND ls_selparamfecha TO lt_selparamfecha.
      ENDLOOP.
    ENDIF.
  ENDLOOP.


  IF ls_selparamproductid-low IS INITIAL.
    RAISE EXCEPTION TYPE /IWBEP/CX_MGW_BUSI_EXCEPTION
      EXPORTING
        textid = /iwbep/cx_mgw_busi_exception=>business_error
        message = 'El material es obligatorio'
        http_status_code = 400.
  ENDIF.

  IF ls_selparamfecha-low IS INITIAL OR ls_selparamfecha-high IS INITIAL.
    RAISE EXCEPTION TYPE /IWBEP/CX_MGW_BUSI_EXCEPTION
      EXPORTING
        textid = /iwbep/cx_mgw_busi_exception=>business_error
        message = 'El rango de fecha es obligatorio'
        http_status_code = 400.
  ENDIF.


  " Tabla para almacenar los datos combinados
  DATA: lt_data TYPE TABLE OF caufv,
        lt_final TYPE TABLE OF resb,  " Para almacenar los resultados finales incluyendo RESB
        ls_data  TYPE caufv,
        ls_final TYPE resb.

  " Primer JOIN entre STPO y CAUFV
  SELECT t1~stlnr, t2~PLNBEZ, t2~AUFNR, t2~KTEXT
    FROM stpo AS t1
    INNER JOIN caufv AS t2 ON t1~stlnr = t2~stlnr
    WHERE t1~IDNRK = @ls_selparamproductid-low AND t2~AUART ='Z012' AND t2~ERDAT BETWEEN @ls_selparamfecha-low AND @ls_selparamfecha-high 
    ORDER BY t1~stlnr
    INTO CORRESPONDING FIELDS OF TABLE @lt_data
    UP TO 200 ROWS.
    
  

  " Segundo JOIN con la tabla RESB para obtener las cantidades de material y otros datos
  LOOP AT lt_data INTO ls_data.
    SELECT r~aufnr, r~matnr, r~bdmng, r~meins, r~charg  " Campos adicionales: BDMNG, MEINS, CHARG
      FROM resb AS r
      WHERE r~aufnr = @ls_data-aufnr AND r~matnr = @ls_selparamproductid-low  " Filtrar por el número de orden de producción
      INTO CORRESPONDING FIELDS OF TABLE @lt_final.
  ENDLOOP.

  " Mapear los datos al entityset para la salida final, incluyendo campos adicionales de RESB
  et_entityset = VALUE #(
    FOR ls1_data IN lt_data
    FOR ls1_final IN lt_final WHERE ( aufnr = ls_data-aufnr )  " Combinar datos en base a AUFNR
    ( stlnr  = ls1_data-stlnr
      PLNBEZ = ls1_data-PLNBEZ
      AUFNR  = ls1_data-AUFNR
      KTEXT  = ls1_data-KTEXT

      BDMNG  = ls1_final-bdmng  " Cantidad de material requerida
      MEINS  = ls1_final-meins  " Unidad de medida del material
      CHARG  = ls1_final-charg  " Lote del material
      IDNRK = ls1_final-IDNRK
    )
  ).
ENDMETHOD.