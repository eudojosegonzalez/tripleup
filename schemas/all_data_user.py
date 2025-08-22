# Schema de datos de Ubicacion del Usuario
# se usa como interfaz de captura de Datos para luego
# pasar su contenido a el modelo de Usuario
from pydantic import BaseModel, Field
from typing import  Optional, List
from datetime import date

#clase que representa a un usuario en el sistema
class AllDataUser(BaseModel):
    identidad: str = Field (min_length=1, max_length=1)
    nacionalidad: str = Field (min_length=1, max_length=1)
    numeroCedula :str = Field (min_length=6, max_length=50)
    nombre: str = Field (min_length=2, max_length=100)
    apellido: str = Field (min_length=2, max_length=100)
    sexo : int = Field (min=0,max=1)
    fechaNacimiento:  date
    celular: str = Field (min_length=9, max_length=50)
    celularAlternativo: str = Field (min_length=0, max_length=50)
    direccion: str = Field (min_length=9, max_length=250)
    estado: int =Field (min=1, max=99)
    municipio: int =Field (min=1, max=99)

    model_config = {
        "json_schema_extra": {
            "examples": [
                {
                    'apellido': 'Perez',
                    'celular': '+589999999999',
                    'celularAlternativo': '',
                    'direccion': 'Direccion de Prueba',
                    'estado': 1,
                    'fechaNacimiento': '1999-01-01',
                    'identidad': 'N',
                    'municipio': 1,
                    'nacionalidad': 'V',
                    'nombre': 'Pedro',
                    'numeroCedula': '9999999',
                    'sexo':1
                }
            ]
        }
    }    
