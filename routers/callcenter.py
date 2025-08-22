'''
Rutas de usuario
Created: 2025-05
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



# importamos el controlador 
from controller.users import userController


# importamos la utilidad para generar el hash del password
from utils.hasher import hash_password,verify_password


# esto importa la tabla desde la definiciones de modelos
from models.user import Usuario as UsuarioModel
from models.bitacora import Bitacora as BitacoraModel


#importamos el esquema de datos para utilizarlo como referencia de datos a la hora de capturar data
from schemas.user import User
from schemas.login import Login

#from middleware.error_handler import ErrorHandler
from middleware.jwt_bearer import JWTBearer

# importamos la configuracion de la base de datos
from config.database import Session

#cargamos las variables de entorno
dotenv.load_dotenv()


# esta variable define al router
callcenter_router = APIRouter(prefix="/V1.0/CallCenter")

def get_client_ip(request: Request):
    client_ip = request.client.host

    # Handle cases where a proxy server is involved
    if request.headers.get("X-Forwarded-For"):
        forwarded_ips = request.headers.get("X-Forwarded-For").split(",")
        client_ip = forwarded_ips[0].strip()

    return {client_ip}



'''
============================ rutas POST =================================================================
'''
# Funcion para crear los datos personles de un usuario
@callcenter_router.post ('/register',
tags=['CallCenter'],
dependencies=[Depends(JWTBearer())], 
responses=
    { 
        201: {
            "description": "Se creo el usuario en el sistema",
            "content": { 
                "application/json":{
                    "example":
                        {
                            "message":"Se creo el usuario en el sistema",
                            "data": "{'id': 5,  'rut': '1-9',  'nombres': 'PEDRO',  'apellidos': 'PEREZ',  'fecha_nacimiento': '1990-01-01',  'sexo_id': 1,  'username': 'pperez',  'password':'$2b$12$MezOQMNr0zBUIhH.XDTH0.lQc65qifjkPDec8FTyGQGfZSPDvf5de',  'activo': true,  'nivel': 1,  'created': '2024-06-22T10:38:06',  'updated': '2024-06-22T10:38:06',  'creator_user': 1, 'updater_user': 1}",
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
        409: {
            "description": "Este Username ya fue registrado en el sistema, no puede volver a insertarlo",
            "content": { 
                "application/json":{ 
                    "example":
                        {
                            "message":"Este Username ya fue registrado en el sistema, no puede volver a insertarlo",
                            "userId":"1",
                             "userName":"anyUsername"
                        }
                    } 
                }       
            },
        422: {
            "description": "Este RUT ya fue registrado en el sistema, no puede volver a insertarlo",
            "content": { 
                "application/json":
                    { "example":
                        {
                            "message":"Este RUT ya fue registrado en el sistema, no puede volver a insertarlo",
                            "userId":"1",
                            "rut":"123456789"
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
            "description": "Ocurrió un error que no pudo ser controlado",
            "content": { 
                "application/json":
                    { "example":
                        {
                            "message":"Ocurrió un error que no pudo ser controlado",
                            "estado":"System Error"
                        }
                    } 
                }       
            },
    }
)
def registro(usuario:User,creatorUserId : int = Query (ge=1, le=os.getenv("MAX_ID_USERS")))->dict:
    db = Session()
    result=userController(db).create_user(usuario,creatorUserId)
    # evaluamos el resultado
    estado=result['result']

    if (estado=="1") :
        # se inserto el registro sin problemas
        data=result["data"]
        return JSONResponse (status_code=201,content={"message":"Se creo el usuario en el sistema","data":jsonable_encoder(data)})     
    elif  (estado=="-2"):
        # el username ya existe no puede volver a insertarlo
        userId=result["userId"]
        userName=result["userName"]
        return JSONResponse (status_code=409,content={"message":"Este Username ya fue registrado en el sistema, no puede volver a insertarlo","userId":userId,"userName":userName})     
    elif (estado=="-3"):
        userId=result["userId"]
        rut=result["rut"]
        return JSONResponse (status_code=422,content={"message":"Este RUT ya fue registrado en el sistema, no puede volver a insertarlo","userId":userId,"rut":rut})     
    elif (estado=="-6"):
        cadenaError=result['cadenaError']
        return JSONResponse (status_code=422,content={"message":f"{cadenaError}"})     

    else:
        codigo=result['result']
        cadenaError=result['cadenaError']
        return JSONResponse(status_code=520,content={"message":f"Ocurrió un error que no pudo ser controlado {codigo} {cadenaError} "})              


'''
============================ rutas GET =================================================================
'''
# Funcion para consultar los datos personales de un usuario
@callcenter_router.get ('/affiliate/{id}/query',
tags=['CallCenter'],
dependencies=[Depends(JWTBearer())], 
responses=
    { 
        200: {
                "description": "Usuario encontrado",
                "content": { 
                    "application/json":
                        { 
                            "example":
                                {
                                    "message":"Usuario encontrado",
                                    "data": "{'id': 5,  'rut': '1-9',  'nombres': 'PEDRO',  'apellidos': 'PEREZ',  'fecha_nacimiento': '1990-01-01',  'sexo_id': 1,  'username': 'pperez',  'password':'$2b$12$MezOQMNr0zBUIhH.XDTH0.lQc65qifjkPDec8FTyGQGfZSPDvf5de',  'activo': true,  'nivel': 1,  'created': '2024-06-22T10:38:06',  'updated': '2024-06-22T10:38:06',  'creator_user': 1, 'updater_user': 1}",
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
            "description": "Usuario no encontrado",
            "content": { 
                "application/json":{ 
                    "example":
                        {
                            "message":"Usuario no encontrado"
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
    }    
)
def get_user(id:int = Path(ge=1, le=os.getenv("MAX_ID_USERS")))->dict:
    db = Session()
    # almacenamos el listado de usarios en un resultset
    result = userController(db).get_user(id)
    # debemnos convertir los objetos tipo BD a Json
    if (result):
        if (result["result"]=="1"):
            data=result['data']
            return JSONResponse(status_code=200,content=jsonable_encoder(data))    
        else:
            return JSONResponse(status_code=404,content={"message":"Usuario no encontrado"})     
    
    
    return JSONResponse(status_code=404,content={"message":"Usuario no encontrado"})  


'''
============================ rutas PUT =================================================================
'''
# Función para actualizar  los datos personales un usuario
@callcenter_router.put ('/affiliate/{id}/admin_update',
tags=['CallCenter'],
dependencies=[Depends(JWTBearer())],
responses=
    { 
        201: {
                "description": "Usuario actualizado",
                "content": { 
                    "application/json":
                        { 
                            "example":
                                {
                                    "message":"Usuario actualizado",
                                    "data": "{'id': 5,  'rut': '1-9',  'nombres': 'PEDRO',  'apellidos': 'PEREZ',  'fecha_nacimiento': '1990-01-01',  'sexo_id': 1,  'username': 'pperez',  'password':'$2b$12$MezOQMNr0zBUIhH.XDTH0.lQc65qifjkPDec8FTyGQGfZSPDvf5de',  'activo': true,  'nivel': 1,  'created': '2024-06-22T10:38:06',  'updated': '2024-06-22T10:38:06',  'creator_user': 1, 'updater_user': 1}",
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
            "description": "Ocurrió un error que no pudo ser controlado",
            "content": { 
                "application/json":
                    { "example":
                        {
                            "message":"Ocurrió un error que no pudo ser controlado",
                            "estado":"System Error"
                        }
                    } 
                }       
            },                       
    }
)
def update_user(usuario:User, user_updater: int = Query(ge=1, le=os.getenv('MAX_ID_USERS')),id : int =Path(ge=1, le=os.getenv('MAX_ID_USERS')))->dict:
    db = Session()
    # buscamos el registro
    result = userController(db).update_user(user_updater,usuario,id) 
    if (result['result']=="1"):
        data=result['data']
        return JSONResponse(status_code=200,content={"message":"Usuario actualizado","Usuario":jsonable_encoder(data)})    
    elif (result['result']=="-1"):
        return JSONResponse(status_code=404,content={"message":"Usuario no encontrado"}) 
    elif (result['result']=="-2"):
        return JSONResponse(status_code=521,content={"message":f"Este Username esta siendo usado por otro usuario, userId={result['UserId']}, por favor rectifique los datos"})     
    elif (result['result']=="-4"):
        return JSONResponse(status_code=522,content={"message":f"Este RUT está registrado a nombre de otro usuario, userId={result['UserId']}, por favor rectifique los datos"})       
    elif (result['result']=="-5"):
        return JSONResponse(status_code=522,content={"message":f"Este RUT  provisorio está registrado a nombre de otro usuario, userId={result['UserId']}, por favor rectifique los datos"})       
    elif (result['result']=="-6"):
        cadenaError=result['cadenaError']
        return JSONResponse (status_code=523,content={"message":cadenaError})      
    else:
        codigo=result['result']
        cadenaError=result['cadenaError']
        return JSONResponse(status_code=520,content={"message":f"Ocurrió un error que no pudo ser controlado {codigo} {cadenaError} "})         


# Función para activar al usuario
@callcenter_router.put ('/affiliate/{id}/activate',
tags=['CallCenter'],
dependencies=[Depends(JWTBearer())], 
responses=
    { 
        201: {
                "description": "Usuario activado",
                "content": { 
                    "application/json":
                        { 
                            "example":
                                {
                                    "message":"Usuario activadp",
                                    "data": "{'id': 5,  'rut': '1-9',  'nombres': 'PEDRO',  'apellidos': 'PEREZ',  'fecha_nacimiento': '1990-01-01',  'sexo_id': 1,  'username': 'pperez',  'password':'$2b$12$MezOQMNr0zBUIhH.XDTH0.lQc65qifjkPDec8FTyGQGfZSPDvf5de',  'activo': true,  'nivel': 1,  'created': '2024-06-22T10:38:06',  'updated': '2024-06-22T10:38:06',  'creator_user': 1, 'updater_user': 1}",
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
            "description": "Ocurrió un error que no pudo ser controlado",
            "content": { 
                "application/json":
                    { "example":
                        {
                            "message":"Ocurrió un error que no pudo ser controlado",
                            "estado":"System Error"
                        }
                    } 
                }       
            },                       
    }
)
def activate_user(user_updater: int = Query (ge=1, le=os.getenv('MAX_ID_USERS')), id : int = Path (ge=1, le=os.getenv('MAX_ID_USERS'))):
    db = Session()
    # buscamos el registro
    result = userController(db).activate_user(user_updater,id) 
    if (result['result']=="1"):
        data=result['data']
        return JSONResponse(status_code=201,content={"message":"Usuario activado","data":jsonable_encoder(data)})    
    elif (result['result']=="-1"):
        return JSONResponse(status_code=404,content={"message":"Usuario no encontrado"}) 
    else:
        return JSONResponse(status_code=520,content={"message":"Ocurrió un error que no pudo ser controlado"})  


# Función para desactivar al usuario
@callcenter_router.put ('/affiliate/{id}/deactivate',
tags=['CallCenter'],
dependencies=[Depends(JWTBearer())], 
responses=
    { 
        201: {
                "description": "Usuario desactivado",
                "content": { 
                    "application/json":
                        { 
                            "example":
                                {
                                    "message":"Usuario desactivadp",
                                    "data": "{'id': 5,  'rut': '1-9',  'nombres': 'PEDRO',  'apellidos': 'PEREZ',  'fecha_nacimiento': '1990-01-01',  'sexo_id': 1,  'username': 'pperez',  'password':'$2b$12$MezOQMNr0zBUIhH.XDTH0.lQc65qifjkPDec8FTyGQGfZSPDvf5de',  'activo': false,  'nivel': 1,  'created': '2024-06-22T10:38:06',  'updated': '2024-06-22T10:38:06',  'creator_user': 1, 'updater_user': 1}",
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
            "description": "Ocurrió un error que no pudo ser controlado",
            "content": { 
                "application/json":
                    { "example":
                        {
                            "message":"Ocurrió un error que no pudo ser controlado",
                            "estado":"System Error"
                        }
                    } 
                }       
            },                       
    }
)
def deactivate_user(user_updater: int = Query (ge=1, le=os.getenv('MAX_ID_USERS')), id : int = Path (ge=1, le=os.getenv('MAX_ID_USERS'))):
    db = Session()
    # buscamos el registro
    result = userController(db).deactivate_user(user_updater,id) 
    if (result['result']=="1"):
        data=result['data']
        return JSONResponse(status_code=201,content={"message":"Usuario desactivado","data":jsonable_encoder(data)})    
    elif (result['result']=="-1"):
        return JSONResponse(status_code=404,content={"message":"Usuario no encontrado"}) 
    else:
        return JSONResponse(status_code=520,content={"message":"Ocurrió un error que no pudo ser controlado"})  
    



# Función para actualizar  la clave de un usuario
@callcenter_router.put ('/affiliate/{id}/admin_update_password',
tags=['CallCenter'],
dependencies=[Depends(JWTBearer())], 
responses=
    { 
        201: {
            "description": "Password de Usuario Actualizado",
            "content": { 
                "application/json":{ 
                    "example":
                        {
                            "message":"Password de Usuario Actualizado",
                            "newpassword":"12345678"
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
            "description": "Ocurrió un error que no pudo ser controlado",
            "content": { 
                "application/json":
                    { "example":
                        {
                            "message":"Ocurrió un error que no pudo ser controlado",
                            "estado":"System Error"
                        }
                    } 
                }       
            },                       
    }
)
def update_password_user( password:str = Query (min_length=os.getenv("MIN_LENGTH_USER_PASSWORD"), max_length=os.getenv("MAX_LENGTH_USER_PASSWORD")) ,id : int = Path (ge=1, le=os.getenv('MAX_ID_USERS')), user_updater: int = Query (ge=1, le=os.getenv('MAX_ID_USERS'))):
    db = Session()
    # buscamos el registro
    result = userController(db).update_password_user(id,user_updater, password) 
    if (result['result']=="1"):
        newPassword=result["newPassword"]
        return JSONResponse(status_code=201,content={"message":"Password de Usuario Actualizado","newpassword":newPassword})    
    elif (result['result']=="-1"):
        return JSONResponse(status_code=404,content={"message":"Usuario no encontrado"}) 
    else:
        return JSONResponse(status_code=520,content={"message":"Ocurrió un error que no pudo ser controlado"})  
    


