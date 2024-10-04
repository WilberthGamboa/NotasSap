METHOD reprocesoset_get_entityset.
  DATA: lr_filter                TYPE REF TO /iwbep/if_mgw_req_filter,
        lt_filter_select_options TYPE /iwbep/t_mgw_select_option,
        ls_filter_select_options TYPE /iwbep/s_mgw_select_option,
        ls_select_option         TYPE /iwbep/s_cod_select_option,
        lt_selparamproductid     TYPE STANDARD TABLE OF bapi_epm_product_id_range,
        lt_selparamfecha         TYPE STANDARD TABLE OF bapi_epm_product_id_range,
        ls_selparamproductid     TYPE bapi_epm_product_id_range,
        ls_selparamfecha         TYPE bapi_epm_product_id_range,
        ls_employee              LIKE LINE OF et_entityset.

  " Obtener los filtros de la entidad
  lr_filter = io_tech_request_context->get_filter( ).
  lt_filter_select_options = lr_filter->get_filter_select_options( ).

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

    IF ls_filter_select_options-property EQ 'DATS'.
      LOOP AT ls_filter_select_options-select_options INTO ls_select_option.
        CLEAR ls_selparamfecha.

        " Procesar los diferentes tipos de filtros de fecha
        CASE ls_select_option-sign.
          WHEN 'I'. " Include
            CASE ls_select_option-option.
              WHEN 'EQ'. " Igual
                ls_selparamfecha-sign = 'I'.
                ls_selparamfecha-option = 'EQ'.
                ls_selparamfecha-low = ls_select_option-low.
                ls_selparamfecha-high = ls_select_option-low.
                APPEND ls_selparamfecha TO lt_selparamfecha.

              WHEN 'BT'. " Between
                ls_selparamfecha-sign = 'I'.
                ls_selparamfecha-option = 'BT'.
                ls_selparamfecha-low = ls_select_option-low.
                ls_selparamfecha-high = ls_select_option-high.
                APPEND ls_selparamfecha TO lt_selparamfecha.

              WHEN 'GE'. " Mayor o igual
                ls_selparamfecha-sign = 'I'.
                ls_selparamfecha-option = 'GE'.
                ls_selparamfecha-low = ls_select_option-low.
                APPEND ls_selparamfecha TO lt_selparamfecha.

              WHEN 'LE'. " Menor o igual
                ls_selparamfecha-sign = 'I'.
                ls_selparamfecha-option = 'LE'.
                ls_selparamfecha-high = ls_select_option-high.
                APPEND ls_selparamfecha TO lt_selparamfecha.
            ENDCASE.
        ENDCASE.
      ENDLOOP.
    ENDIF.
  ENDLOOP.

  " Agregar a la entidad los rangos de fecha (puedes modificar esto según tu lógica)


    ls_employee-STLNR = ls_selparamfecha-low.
    ls_employee-AUFNR = ls_selparamfecha-high.
    ls_employee-CHARG =  ls_selparamproductid-low.
    APPEND ls_employee TO et_entityset.


ENDMETHOD.