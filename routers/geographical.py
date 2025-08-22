'''
Rutas de datos Geográficos
Created: 2025-08
'''
import os

#importamos la libreria para cargar los archivos de entorno
import dotenv

from fastapi import APIRouter,Body,Path,Query, Depends
# dependencia que coinvierte los objetos tipo Bd a json
from fastapi.encoders import jsonable_encoder
#from fastapi import Path,Query, Depends
from fastapi.responses import JSONResponse
from fastapi import  Request
from fastapi import File, UploadFile
import hashlib
import random

import pdb

# import all you need from fastapi-pagination
from sqlalchemy import select


from sqlalchemy import or_,and_
from datetime import datetime,timedelta


#from typing import  Optional, List
from typing import  List
# importamos desde la configuracion de la Base de datos las clases
from config.database import Session



#importamos la libreria para generar el token y validarlo
import jwt 
from utils.jwt_managr import create_token,validate_token

# importamos la utilidad para generar el hash del password
from utils.hasher import hash_password,verify_password


# importamos el controlador 
from controller.geographical import GeographicalController 


#from middleware.error_handler import ErrorHandler
from middleware.jwt_bearer import JWTBearer

# importamos la configuracion de la base de datos
from config.database import Session

#cargamos las variables de entorno
dotenv.load_dotenv()


# esta variable define al router
geographical_router = APIRouter(prefix="/V1.0/geographical")


'''
Rutas para datos geográficos
'''
# Funcion para consultar los estados en el sistema
@geographical_router.get ('/get_estados',
tags=['Geographical'],
dependencies=[Depends(JWTBearer())], 
responses=
    { 
        200: {
                "description": "Estados Encontrados",
                "content": { 
                    "application/json":
                        { 
                            "example":
                                {
                                    "message":"Estados Encontrados",
                                    "data": " {'id': 1,'nomestado': 'DTTO. CAPITAL'}",
                                }
                        } 
                    
                } 
                    
            },         
        403: {
            "description": "Forbiden",
            "content": { 
                "application/json":{ 
                    "example":
                        {
                            "message":"Not authenticated"
                        }
                    } 
                }       
            },  
        404: {
            "description": "No se han encontrado Estados en el sistema",
            "content": { 
                "application/json":{ 
                    "example":
                        {
                            "message":"No se han encontrado Estados en el sistema"
                        }
                    } 
                }       
            },   
        500: {
            "description": "Su session ha expirado",
            "content": { 
                "application/json":
                    { "example":
                        {
                            "message":"Su session ha expirado",
                            "estado":"Signature has expired"
                        }
                    } 
                }       
            },   
        520: {
            "description": "Ocurrió un Error que no pudo ser controlado",
            "content": { 
                "application/json":
                    { "example":
                        {
                            "message":"Ocurrió un Error que no pudo ser controlado",
                            "estado":"Ocurrió un Error que no pudo ser controlado"
                        }
                    } 
                }       
            },                                                                     
    }    
)
def get_estados()->dict:
    db = Session()
    # almacenamos el listado de usarios en un resultset
    result = GeographicalController(db).get_estados()
    # debemnos convertir los objetos tipo BD a Json
    if (result):
        if (result["result"]=="1"):
            data=result['data']
            return JSONResponse(status_code=200,content=jsonable_encoder(data))    
        elif (result["result"]=="-1"):
            return JSONResponse(status_code=404,content={"message":"No se han encontrado Estados en el sistema"})     
    return JSONResponse(status_code=520,content={"message":"Usuario no encontrado"})  



# Funcion para consultar los estados en el sistema
@geographical_router.get ('/{id}/get_muinicipios',
tags=['Geographical'],
dependencies=[Depends(JWTBearer())], 
responses=
    { 
        200: {
                "description": "Municipios Encontrados",
                "content": { 
                    "application/json":
                        { 
                            "example":
                                {
                                    "message":"Municipios Encontrados",
                                    "data": "{'id': 1,'estado_id': 7,'nommunicipio': 'MP. BEJUMA'},{'id': 2,'estado_id': 7,'nommunicipio': 'MP. CARLOS ARVELO'},{'id': 3,'estado_id': 7,'nommunicipio': 'MP. DIEGO IBARRA'},",
                                }
                        } 
                } 
            },         
        403: {
            "description": "Forbiden",
            "content": { 
                "application/json":{ 
                    "example":
                        {
                            "message":"Not authenticated"
                        }
                    } 
                }       
            },  
        404: {
            "description": "No se han encontrado Municipios en el sistema",
            "content": { 
                "application/json":{ 
                    "example":
                        {
                            "message":"No se han encontrado Municipios en el sistema"
                        }
                    } 
                }       
            },   
        500: {
            "description": "Su session ha expirado",
            "content": { 
                "application/json":
                    { "example":
                        {
                            "message":"Su session ha expirado",
                            "estado":"Signature has expired"
                        }
                    } 
                }       
            },  
        520: {
            "description": "Ocurrió un Error que no pudo ser controlado",
            "content": { 
                "application/json":
                    { "example":
                        {
                            "message":"Ocurrió un Error que no pudo ser controlado",
                            "estado":"Ocurrió un Error que no pudo ser controlado"
                        }
                    } 
                }       
            },                                                                      
    }    
)
def get_municipio(id:int = Path(ge=1))->dict:
    db = Session()
    # almacenamos el listado de usarios en un resultset
    result = GeographicalController(db).get_municipios(id)
    # debemnos convertir los objetos tipo BD a Json
    if (result):
        if (result["result"]=="1"):
            data=result['data']
            return JSONResponse(status_code=200,content=jsonable_encoder(data))    
        elif (result["result"]=="-1"):
            return JSONResponse(status_code=404,content={"message":"No se han encontrado Municipios para este estado en el sistema"})     
    return JSONResponse(status_code=520,content={"message":"Ocurrió un error que no pudo ser controlado"})  