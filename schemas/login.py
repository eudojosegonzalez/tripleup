# Schema de datos de Usuario
# se usa como interfaz de captura de Datos para luego
# pasar su contenido a el modelo de Usuario
from pydantic import BaseModel, Field
from typing import  Optional, List
from datetime import date, datetime

#clase que representa los datos de acceso del usuario en el sistema
class Login(BaseModel):
    username : str  = Field (min_length=4, max_length=200)   
    password : str = Field (min_length=8, max_length=200)

    model_config = {
        "json_schema_extra": {
            "examples": [
                {
                    "username":"pperez",
                    "password":"12345678",
                }
            ]
        }
    }    
