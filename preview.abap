METHOD CAUFPRUEBASET_GET_ENTITYSET.

    DATA: lr_filter                TYPE REF TO /iwbep/if_mgw_req_filter,
                 lt_filter_select_options TYPE /iwbep/t_mgw_select_option,
                 ls_filter_select_options TYPE /iwbep/s_mgw_select_option,
                 ls_select_option         TYPE /iwbep/s_cod_select_option,
                 lt_selparamproductid     TYPE STANDARD TABLE OF bapi_epm_product_id_range,
                 lt_selparamfecha         TYPE STANDARD TABLE OF bapi_epm_product_id_range,
                 ls_selparamproductid     TYPE bapi_epm_product_id_range,
                 ls_selparamfecha         TYPE bapi_epm_product_id_range.
           
      DATA: lt_data  TYPE TABLE OF caufv. 
      
        " Obtener los filtros de la entidad
           lr_filter = io_tech_request_context->get_filter( ).
           lt_filter_select_options = lr_filter->get_filter_select_options( ).
     
       " Procesar los filtros para obtener los rangos
       LOOP AT lt_filter_select_options INTO ls_filter_select_options.
         IF ls_filter_select_options-property = 'WERKS'. " Filtro por planta
           LOOP AT ls_filter_select_options-select_options INTO ls_select_option.
             ls_selparamproductid-sign   = ls_select_option-sign.
             ls_selparamproductid-option = ls_select_option-option.
             ls_selparamproductid-low    = ls_select_option-low.
             ls_selparamproductid-high   = ls_select_option-high.
             APPEND ls_selparamproductid TO lt_selparamproductid.
           ENDLOOP.
     
         ELSEIF ls_filter_select_options-property = 'ERDAT'. " Filtro por fecha
           LOOP AT ls_filter_select_options-select_options INTO ls_select_option.
             ls_selparamfecha-sign   = ls_select_option-sign.
             ls_selparamfecha-option = ls_select_option-option.
             ls_selparamfecha-low    = ls_select_option-low.
             ls_selparamfecha-high   = ls_select_option-high.
             APPEND ls_selparamfecha TO lt_selparamfecha.
           ENDLOOP.
         ENDIF.
       ENDLOOP.
     
       " Validar que al menos un filtro se haya procesado
       IF lt_selparamproductid IS INITIAL OR lt_selparamfecha IS INITIAL.
         RETURN. " Si no hay suficientes filtros, no ejecutamos la consulta
       ENDIF.
     
       " Primer SELECT para obtener datos
       SELECT stlnr, erdat, aufnr, ktext, werks
         FROM caufv
         WHERE werks = @ls_selparamproductid-low
           AND erdat BETWEEN @ls_selparamfecha-low AND @ls_selparamfecha-high
         INTO CORRESPONDING FIELDS OF TABLE @lt_data
         UP TO 200 ROWS.
     
       " Formatear los resultados en el formato esperado por el OData
       et_entityset = VALUE #(
         FOR ls_data IN lt_data
         ( stlnr = ls_data-stlnr
           erdat = ls_data-erdat
           aufnr = ls_data-aufnr
           ktext = ls_data-ktext
           werks = ls_data-werks )
       ).
     
     ENDMETHOD.
     