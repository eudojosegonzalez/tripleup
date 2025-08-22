# Schema de datos de Usuario
# se usa como interfaz de captura de Datos para luego
# pasar su contenido a el modelo de Usuario
from pydantic import BaseModel, Field
from typing import  Optional, List
from datetime import date



#clase que representa a un usuario en el sistema
class Aseguradora(BaseModel):
    descripcion : str = Field (min_length=5, max_length=150)
    logo : str  = Field (min_length=0, max_length=250)   
    verificado : int  = Field (min=0, max=1)
    emergencia : str  = Field (min_length=5, max_length=250)       
    soporte : str  = Field (min_length=5, max_length=250)  

    '''
	id	bigint(20) AI PK
	descripcion	varchar(150)
	logo	varchar(250)
	verificado	int(11)
	emergencia	text
	soporte	text
	created	datetime
	updated	datetime
	creator_user	bigint(20)
	updater_user	bigint(20)    
    '''

    model_config = {
        "json_schema_extra": {
            "examples": [
                {
                    "descripcion":"Aseguradora XYZ",
                    "logo":"imagen.png",
                    "verificado":1,
                    "emergencia":"04246007712",
                    "soporte":"04246007712",
                }
            ]
        }
    }    
