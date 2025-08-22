# Schema de datos de Contacto del Usuario
# se usa como interfaz de captura de Datos para luego
# pasar su contenido a el modelo de Usuario
from pydantic import BaseModel, Field
from typing import  Optional, List
from datetime import date

#clase que representa a un usuario en el sistema
class DatosContacto(BaseModel):
    nacionalidad : str =Field (min_length=1, max_length=1)
    numero: str =Field (min_length=6, max_length=30)
    identidad : str =Field (min_length=1, max_length=1) # se trata de se es J,G, N
    apellido : str = Field (min_length=2, max_length=100)
    nombre : str = Field (min_length=2, max_length=100)
    fecha_nac : date 
    sexo : int = Field (min=0,max=1)

    model_config = {
        "json_schema_extra": {
            "examples": [
                {
                    'nacionalidad': 'V',
                    'numero': '99999999',
                    'identidad': 'N',
                    'apellido': 'Perez',
                    'nombre': 'Pedro',
                    'fecha_nac': '1999-01-01',
                    'sexo': '1',
                }
            ]
        }
    }    
