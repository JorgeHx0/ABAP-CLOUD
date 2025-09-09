CLASS zcl_clase_creadora_jpf DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

 "Definiciones:
       "Instancia: Objeto creado a partir de una clase

       "Atributos de dependencia de instancia y los estaticos :

            "Atributos de dependencia de instancia-> Depende de la instancia de la clase, el contenido es especifico para
            "cada objeto. Se declaran usando la sentencia data

            "resumen - "" son variables que pertenecen a cada objeto, no a la clase. Cada instancia tiene su propia copia

            "Atributos estaticos->  El contenido de los atributos estaticos definen el estado de la clase y es valido para todas las instancias de la clase,
*            se declaran usando class-data.  Son accesible desde todo el entorno de ejecucion de la clase. Todos los objetos de una clase pueden acceder a sus atributos estaticos.
*            Si se cambia un atributo estatico en un objeto, el cambio es visible en todos los demas objetos de la clase.
*
*            resumen- Variables de la clase, NO del objeto. Hay una sola copia por clase en la sesion. todas las instancias lo comparten

" Metodos estaticos o de instancia
        "los metodos estaticos-> No dependen de la instancia
        "los metodos de instancia-> Dependen de cada instancia que se va a realizar en el contenxto de la memoria de ejecucion

  "  los metodos de instancia ->
  "  los metodos estaticos  =>

  PUBLIC SECTION."todos los atributos y métodos son públicos y accesibles. A evitar preferiblemente.


TYPES:BEGIN OF ty_address,
      country type string,
      city type string,
      postal_code type string,
      region type string,
      street type string,
      number type string,
      END OF ty_address,
      tty_address type table of ty_address.

      METHODS set_address importing it_address type tty_address.



  CLASS-DATA currency type c LENGTH 3. "atributo estático
  DATA region TYPE STRING. "atributo de instancia

 "declsración de método/función de instancia
  METHODS set_client
  IMPORTING iv_client type string "parámetros de entrada
            iv_location type string
 EXPORTING ev_status type string "parámetros de salida
 changing cv_process type string. "parámetros de cambio

 "declaración de método de estática
 METHODS get_client
 EXPORTING ev_client TYPE string.

 CLASS-METHODS:
 set_cntr_type
 IMPORTING iv_cntr_type type string,
 get_cntr_type exporting ev_cntr_type type string.
"................
METHODS: get_client_name IMPORTING iv_client_id TYPE string RETURNING VALUE(rv_client_name) TYPE string.
"...............


  PROTECTED SECTION."sólo accesible para esta clase y las clases hijas
  DATA creation_date type sydate. "atributo instancia (se crea con DATA)

  PRIVATE SECTION."accesible sólo para esta clase y las clases "friends".

  DATA client TYPE string.
  CLASS-DATA cntr_type type string.


ENDCLASS.



CLASS zcl_clase_creadora_jpf IMPLEMENTATION.

METHOD set_client.
      client = iv_client.
      ev_status = 'Ok'.
      cv_process = 'Started'.

  ENDMETHOD.

  METHOD get_client.

    ev_client = client.

  ENDMETHOD.

  METHOD get_cntr_type.

    ev_cntr_type = cntr_type.
  ENDMETHOD.

  METHOD set_cntr_type.
        cntr_type = iv_cntr_type.
  ENDMETHOD.

  METHOD get_client_name.
  CASE iv_client_id.
  when'01'.
  rv_client_name = 'client name 01'.
  when '02'.
  rv_client_name = 'Client name 02'.
  endcase.

  ENDMETHOD.

  METHOD set_address.

  ENDMETHOD.

ENDCLASS.
