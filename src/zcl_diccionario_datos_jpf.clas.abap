CLASS zcl_diccionario_datos_jpf DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_diccionario_datos_jpf IMPLEMENTATION.
METHOD if_oo_adt_classrun~main.


DATA lv_nombre TYPE zde_nombre_jpf.

lv_nombre = 'Jorge'.
out->write( lv_nombre ).

DATA ls_anidada type zst_anidada_jpf.
out->write( ls_anidada ).
"""""""

"estructura plana
    "Subestructura (plana)
    TYPES : BEGIN OF ty_addr,

              street TYPE c LENGTH 30,
              city  TYPE c LENGTH 20,
            END OF ty_addr.
*
*    "estructura ANIDADA: contiene ty_addr como un campo
*
*    TYPES: BEGIN OF ty_employee_nested,
*
*           id type i,
*           name type c LENGTH 20,
*           addr type ty_addr, " subestructura anidada  seria igual que decir prueba : include zst_empleados_der.
*        end of ty_employee_nested.
*
*
*data ls_prueba type ty_employee_nested.
* out->write( ls_prueba ).
*


" estructura profunda
" producto simple para la tabla interna
types: BEGIN OF ty_order_item,
        producto type c LENGTH 10,
        camion  type  i,
        end of TY_ORDER_ITEM.

  "estructura profunda: tiene tipos dinamicos (string, tablas, referencias)


    TYPES: BEGIN OF ty_customer_deep,
           id type i,
           name type string,  " profunda
           addr type ty_addr, " anidada ( plana )
           orders type STANDARD table of ty_order_item with empty key, "profunda ( tabala interna )
           refaddr type ref to ty_addr, " profunda ( esta haciendo una referencia)

           END OF TY_CUSTOMER_DEEP.



data ls_cust TYPE ty_customer_deep.

free ls_cust-orders .

*"EJERCICIO
*
*"Construimos toda la estructura de una vez con VALUE #( ... )
**    ls_cust = VALUE ty_customer_deep(
**      id      = 1001                                    "campo simple
**      name    = |Daniel García|                         "STRING (profundo)
**      addr    = VALUE ty_addr(                          "subestructura anidada (plana)
**                   steet = 'Calle Mayor 1'
**                   city  = 'Madrid' )
**      orders  = VALUE #(                                "tabla interna (profunda)
**                   ( producto = 'A123' camion = 10 )
**                   ( producto = 'B777' camion =  5 ) )
**      refaddr = NEW ty_addr(                            "referencia a datos (profunda)
**                   steet = 'Av. del Sol 9'
**                   city  = 'Madrid' )
**    ).
*
*
**    "se podrian añadir mas pedididos despues con el append
**    APPEND VALUE #( producto = 'C999' camion = 2 ) TO ls_cust-orders.
*"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*
*"--- Campos simples
**ls_cust-id   = 1.
**ls_cust-name = |Daniel|.          "string
**
**"--- Subestructura anidada (addr)
**ls_cust-addr-steet = 'Calle Mayor 1'.
**ls_cust-addr-city  = 'Madrid'.
**
**"--- Tabla interna (orders): añade filas
**APPEND VALUE #( producto = 'A123' camion = 10 ) TO ls_cust-orders.
**INSERT VALUE #( producto = 'B777' camion = 5 ) INTO TABLE ls_cust-orders.
**
**"--- Referencia a datos (refaddr): primero reserva memoria, luego asigna
**ls_cust-refaddr = NEW ty_addr( ).   "o: CREATE DATA ls_cust-refaddr.
**ls_cust-refaddr->steet = 'Av. del Sol 9'.
**ls_cust-refaddr->city  = 'Sevilla'.
*
*
*
*""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*
**
**
*    out->write( 'Cliente:' ).
*    out->write( |ID: { ls_cust-id }  Nombre: { ls_cust-name }| ).
*
*    "Campos de la subestructura anidada
*    out->write( |Dirección: { ls_cust-addr-steet }, { ls_cust-addr-city }| ).
*
*    "Número de pedidos (tabla interna)
*    out->write( |Pedidos: { lines( ls_cust-orders ) }| ).
*
*    "Recorrer e imprimir la tabla interna
*    LOOP AT ls_cust-orders INTO DATA(ls_item).
*      out->write( |  - { ls_item-producto } x { ls_item-camion }| ).
*    ENDLOOP.
*
*    "Acceder a la referencia (desreferenciar con ->)
*    out->write( |RefAddr: { ls_cust-refaddr->steet }, { ls_cust-refaddr->city }| ).
*
*
*    " Liberar memoria de la tabla interna (opcional)
*
**    FREE ls_cust-orders.                                "Libera memoria de pedidos
**    out->write( |Pedidos tras FREE: { lines( ls_cust-orders ) }| ).
*
*""""
*en el cds diccionario de datos no puedes meter "tablas internas" ni "referencias" dentro de una "define structure" o "difine table"
*"""""

data lt_tabla_dic_datos type ZTT_TIPO_TABLAS_JPF.
data ls_estructura_dic_datos type ZST_EMPLEADOS_JPF.

ls_estructura_dic_datos-employee_id = |00001|.
ls_estructura_dic_datos-category = 's'.
ls_estructura_dic_datos-fisrt_name = ' Pedro '.
ls_estructura_dic_datos-last_name = 'García'.
ls_estructura_dic_datos-start_date = '20250815'.

out->write( ls_estructura_dic_datos ).



ENDMETHOD.

ENDCLASS.
