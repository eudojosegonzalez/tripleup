# Schema de datos de Usuario
# se usa como interfaz de captura de Datos para luego
# pasar su contenido a el modelo de Usuario
from pydantic import BaseModel, Field
from typing import  Optional, List
from datetime import date, time

#clase que representa a un usuario en el sistema
class Bitacora(BaseModel):
    user_id : int = Field (ge=1)
    nombre : str = Field(min_length=3, max_length=100)
    accion : str = Field(min_length=3, max_length=250)
    fecha_ingreso : date
    fecha_egreso : date
    delta : time

    model_config = {
        "json_schema_extra": {
            "examples": [
                {
                    "user_id": 1,                 
                    "nombre": "Pedro ",
                    "accion" : "login",
                    "fecha_ingreso": "1990-01-01 08:00",
                    "fecha_egreso": "1990-01-01 08:01",
                    "delta":"00:01"
                }
            ]
        }
    }     

       
