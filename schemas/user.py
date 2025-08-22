# Schema de datos de Usuario
# se usa como interfaz de captura de Datos para luego
# pasar su contenido a el modelo de Usuario
from pydantic import BaseModel, Field
from typing import  Optional, List
from datetime import date



#clase que representa a un usuario en el sistema
class User(BaseModel):
    username : str  = Field (min_length=5, max_length=150)   
    password : str = Field (min_length=8, max_length=150)
    codigo : str = Field (min_length=0, max_length=150)

    model_config = {
        "json_schema_extra": {
            "examples": [
                {
                    "username":"pperez@gmail.com",
                    "password":"12345678",
                    "codigo":"ABCDEFGHI",
                }
            ]
        }
    }    
