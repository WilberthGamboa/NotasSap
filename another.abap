METHOD reprocesoset_get_entityset.
    DATA: lr_filter                TYPE REF TO /iwbep/if_mgw_req_filter,
          lt_filter_select_options TYPE /iwbep/t_mgw_select_option,
          ls_filter_select_options TYPE /iwbep/s_mgw_select_option,
          ls_select_option         TYPE /iwbep/s_cod_select_option,
          lt_selparamproductid     TYPE STANDARD TABLE OF bapi_epm_product_id_range,
          ls_selparamproductid     TYPE bapi_epm_product_id_range.
  
    lr_filter = io_tech_request_context->get_filter( ).
    lt_filter_select_options = lr_filter->get_filter_select_options( ).
  
    DATA:  ls_employee LIKE LINE OF et_entityset.
  
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
    
  TYPES: BEGIN OF ty_stpo_mast,
           stlnr TYPE mast-stlnr,  " Asegúrate de que los tipos sean correctos según tu modelo de datos
           matnr TYPE mast-matnr,
         END OF ty_stpo_mast.
         
    DATA: lt_data  TYPE TABLE OF stpo_mast,     " Tabla interna para almacenar resultados del primer JOIN
          lt_final TYPE TABLE OF caufv.   " Tabla interna para almacenar resultados finales
    
    SELECT t1~stlnr, t2~matnr
    FROM stpo AS t1
    INNER JOIN mast AS t2 ON t1~stlnr = t2~stlnr
    WHERE t1~IDNRK = @ls_selparamproductid-low 
    INTO CORRESPONDING FIELDS OF TABLE @lt_data.
  
    " Asumiendo que ls_employee tiene la misma estructura que lt_data
    et_entityset = VALUE #( FOR ls_data IN lt_data ( stlnr  = ls_data-stlnr idnrk1 = ls_data-matnr ) ).
  ENDMETHOD.