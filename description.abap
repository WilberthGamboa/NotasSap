method MATERIALDESCRIPT_GET_ENTITYSET.
    DATA: lr_filter                TYPE REF TO /iwbep/if_mgw_req_filter,
           lt_filter_select_options TYPE /iwbep/t_mgw_select_option,
           ls_filter_select_options TYPE /iwbep/s_mgw_select_option,
           ls_select_option         TYPE /iwbep/s_cod_select_option,
           lt_materialDescription     TYPE STANDARD TABLE OF bapi_epm_product_id_range,
           ls_materialDescription     TYPE bapi_epm_product_id_range,
        
   
     " Obtener los filtros de la entidad
     lr_filter = io_tech_request_context->get_filter( ).
     lt_filter_select_options = lr_filter->get_filter_select_options( ).
     " ERROR
   
   
     DATA: ls_employee LIKE LINE OF et_entityset.
   
     " Procesar los filtros para obtener el rango de materiales
     LOOP AT lt_filter_select_options INTO ls_filter_select_options.
       IF ls_filter_select_options-property EQ 'MATNR'.
         LOOP AT ls_filter_select_options-select_options INTO ls_select_option.
           ls_materialDescription-sign = ls_select_option-sign.
           ls_materialDescription-option = ls_select_option-option.
           ls_materialDescription-low = ls_select_option-low.
           ls_materialDescription-high = ls_select_option-high.
           APPEND ls_materialDescription TO lt_materialDescription.
         ENDLOOP.
       ENDIF.
     ENDLOOP.
     DATA: lt_data  TYPE TABLE OF makt.

     SELECT matnr,maktx
     FROM makt 
     WHERE matnr = @ls_materialDescription-low 
     INTO CORRESPONDING FIELDS OF TABLE @lt_data
     UP TO 1 ROWS.


     et_entityset = VALUE #(
        FOR ls_data IN lt_data
        ( makt = ls_data-makt
        maktx = ls_data-maktx
         )
      ).

   endmethod.