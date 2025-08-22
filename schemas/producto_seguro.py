# Schema de datos de Usuario
# se usa como interfaz de captura de Datos para luego
# pasar su contenido a el modelo de Usuario
from pydantic import BaseModel, Field
from typing import  Optional, List
from datetime import date



#clase que representa a un usuario en el sistema
class ProductoSeguro(BaseModel):
    nombre : str = Field (min_length=5, max_length=150)
    aseguradora_id : int = Field   
    tipo_poliza : str = Field (min_length=5, max_length=150)
    monto_cobertura : float = Field
    periodo_pago : str = Field (min_length=5, max_length=100)
    rating : int = Field (min=0, max= 5)
    costo : float = Field
    precio : float = Field
    cuotas : float = Field
    estado : int = Field (min=0, max=1)
    descripcion : str = Field (min_length=0, max_length= 250)
    plazo_espera : str = Field (min_length=0, max_length= 250)
    imagen : str = Field (min_length=0, max_length= 250)


    '''
	id	bigint(20) AI PK
	nombre	varchar(150)
	aseguradora_id	bigint(20)
	tipo_poliza	varchar(150)
	montoCobertura	decimal(18,2)
	periodoPago	varchar(100)
	rating	int(11)
	costo	decimal(13,4)
	precio	decimal(13,4)
	cuotas	decimal(13,4)
	estado	int(11)
	descripcion	text
	plazo_espera	varchar(250)
	imagen	varchar(250)
	created	datetime
	updated	datetime
	creator_user	bigint(20)
	updater_user	bigint(20)  
    '''

    model_config = {
        "json_schema_extra": {
            "examples": [
                {
                    "nombre" : "Producto ABC",
                    "aseguradora_id" : 1,
                    "tipo_poliza" : "Seguro de Salud",
                    "monto_cobertura" : 20000.00,
                    "periodo_pago" : "Mensual",
                    "rating" : 5,
                    "costo" : 250.00,
                    "precio" : 25.00,
                    "cuotas" : 35.00,
                    "estado" : 2,
                    "descripcion" : "Esto es un producto de prueba",
                    "plazo_espera" : "Esto son plazos de espera de prueba",
                    "imagen" : ""
                }
            ]
        }
    }    
