En ABAP, los Core Data Services (CDS) son un marco de modelado de datos que permite definir estructuras de datos avanzadas directamente en el entorno SAP. Están diseñados para facilitar el acceso a datos en sistemas SAP HANA, proporcionando un enfoque más moderno, eficiente y orientado a la base de datos.



ABAP
@AbapCatalog.sqlViewName: 'ZMYVIEW'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Mi primera vista CDS'
define view Z_MY_VIEW as select from my_table
{
    key my_table.field1,
        my_table.field2,
        my_table.field3
}
