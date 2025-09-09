CLASS zcl_m_y_objetos_jpf DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  "atributos:
  data lv_nombre type string.
  data lv_raza type string.

  METHODS: ladrar RETURNING VALUE(rv_accion) type string.
  METHODS lanzar_pelota RETURNING VALUE(rv_accion) type string.





  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_m_y_objetos_jpf IMPLEMENTATION.

METHOD ladrar.
rv_accion = |{ lv_nombre } dice: guau guau|.
ENDMETHOD.

METHOD lanzar_pelota.
rv_accion = |{ lv_nombre } corre a por la pelota|.
ENDMETHOD.

ENDCLASS.
