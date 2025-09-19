//"1. Definición de Vistas CDS Básicas
//Crear la vista CDS “ZDATA_MODELING_USER” que muestre la lista
//de clientes utilizando la tabla /dmo/customer. Declarando los
//siguientes campos en la vista CDS:
//● CUSTOMER_ID: Como campo clave.
//● FIRST_NAME.
//● LAST_NAME.
//Es opcional agregar un alias para cada componente.

//2. Uso de Variables de Sesión
//Agregar variables de sesión para obtener la fecha del sistema y el
//cliente en la CDS Previamente creada.

//3. Conversiones en CDS
//Utiliza la función CAST para convertir el campo
//CUSTOMER_ID_USER, que debe ser agregada también en la
//declaración de CDS a un tipo de dato abap.int8.
//4. Uso de Funciones CASE
//Utilizar la instrucción CASE para agregar el componente COUNTRY
//para categorizar a los clientes según país de origen “US” colocar
//“United States” ó “DE” colocar “Germany”. De lo contrario mostrar
//“Other Country”.


@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ejer 1 CDS'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
    
       

}
define view entity ZDATA_MODELING_JPF as select from /dmo/customer
{
    key customer_id as Customer_ID,
    key cast( customer_id as abap.int8 ) as Customer_ID_int8, //ejer 3
    first_name as Nombre,
    last_name as Apellido,
        //ejer 2. uso variables de sesión
    $session.system_date as Fecha_Sistema,
    $session.user as Cliente, 
            //ejer 4
    case country_code
    when 'US' then 'United States'
    when 'DE' then 'Germany'
    else 'other country'
    end as country_name
    
    
    }
    
