'''
Rutas de usuario
Created: 2025-06
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



# importamos el controlador 
from controller.users import userController


# importamos la utilidad para generar el hash del password
from utils.hasher import hash_password,verify_password


# esto importa la tabla desde la definiciones de modelos
from models.user import Usuario as UsuarioModel
from models.bitacora import Bitacora as BitacoraModel
from models.datos_personales import DatosPersonales as DatosPersonalesModel
from models.datos_contacto import DatosContacto as DatosContactoModel


#importamos el esquema de datos para utilizarlo como referencia de datos a la hora de capturar data
from schemas.user import User
from schemas.login import Login
from schemas.datos_personales import DatosPersonales as DatosPersonalesSchema
from schemas.datos_contacto import DatosContacto as DatosContactoSchema
from schemas.datos_ubicacion import DatosUbicacion as DatosUbicacionSchema
from schemas.all_data_user import AllDataUser as AllDataUserSchema

#from middleware.error_handler import ErrorHandler
from middleware.jwt_bearer import JWTBearer

# importamos la configuracion de la base de datos
from config.database import Session

#cargamos las variables de entorno
dotenv.load_dotenv()


# esta variable define al router
user_router = APIRouter(prefix="/V1.0/affiliate")

def get_client_ip(request: Request):
    client_ip = request.client.host

    # Handle cases where a proxy server is involved
    if request.headers.get("X-Forwarded-For"):
        forwarded_ips = request.headers.get("X-Forwarded-For").split(",")
        client_ip = forwarded_ips[0].strip()

    return {client_ip}


# esta rutina permite obtener un valor unico a partir del correo
def generar_codigo_desde_email(email):
    """
    Genera un hash MD5 de un correo electrónico y lo convierte en una
    cadena alfanumérica de 10 caracteres (mayúsculas y números).
    """
    if not isinstance(email, str):
        raise TypeError("La entrada debe ser una cadena de texto (string).")
    if not email:
        raise ValueError("El correo electrónico no puede estar vacío.")

    # 1. Convertir el correo electrónico a su hash MD5
    # Los hashes MD5 siempre son de 32 caracteres hexadecimales.
    md5_hash = hashlib.sha256(email.lower().encode('utf-8')).hexdigest()

    # 2. Mapear caracteres hexadecimales a alfanuméricos (0-9, A-Z)
    # y seleccionar 10 caracteres del hash para formar la cadena.
    
    # Define los caracteres válidos para el código final
    caracteres_validos = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    
    codigo_resultante = ""
    
    # Usaremos una parte del hash MD5 para obtener los 10 dígitos.
    # El MD5 es de 32 caracteres. Podemos usar los primeros 10, o los últimos,
    # o una combinación. Para asegurar que siempre obtengamos 10 caracteres,
    # tomaremos los primeros 10 y los "mapearemos" a nuestro conjunto de caracteres válidos.
    
    # Iterar sobre los primeros 10 caracteres del hash MD5
    for i in range(12):
        # Tomar el valor numérico del carácter hexadecimal
        # Por ejemplo, 'a' es 10, 'f' es 15. '0' es 0, '9' es 9.
        valor_hex = int(md5_hash[i], 16)
        
        # Mapear este valor a un índice dentro de nuestros caracteres_validos (0-35)
        # Usamos el operador módulo para asegurar que el índice esté dentro del rango.
        indice = valor_hex % len(caracteres_validos)
        
        codigo_resultante += caracteres_validos[indice]
            
    return codigo_resultante



'''
============================ rutas POST =================================================================
'''
# metodo que logea compara el email y la clave enviadas desde  el formulario
# se crea el token si la claeve y el usuario coinciden
@user_router.post("/login", 
tags=["Affiliate"])
def login(request: Request, email : str = Body, password : str = Body, persistencia: bool = Body):
    session = Session()
    # generamos el hash del password del usuario desde la peticion HTTP
    passWord=hash_password(password)
    
    #buscamos el usuario
    userVerified = session.query(UsuarioModel).filter(UsuarioModel.username == email).first()
    
    # existe el usuario
    if (userVerified):
        ahora=datetime.now()

        #retornamos el password del usuario desde la tabla
        hashV=userVerified.password
        #comparamos los password
        autorized=verify_password(password,hashV)
        #determinamos si el usuario está activo
        userActive=userVerified.estado
        #verificamos que esta autorizado 
        if (autorized):
            #verificamos que esta activo 
            if (userActive):
                # calculamos el tiempo de expiracion del token por defecto 30 minutos
                # Define la duración en minutos
                duration_in_minutes = (30 * 60 )
                duration_in_minutes2 = (60 * 60 )

                # Crea un objeto datetime con la hora actual
                now = datetime.now()

                # Crea un objeto timedelta
                delta = timedelta(seconds=duration_in_minutes)

                delta2 = timedelta(seconds=duration_in_minutes2)

                # Suma el timedelta a la hora actual
                future_time = now + delta

                future_time2 = now + delta2

                timestamp_unix = future_time.timestamp()
                timestamp_unix2 = future_time2.timestamp()

                #determinamos la ip del cliente
                client_ip = request.client.host

                # Handle cases where a proxy server is involved
                if request.headers.get("X-Forwarded-For"):
                    forwarded_ips = request.headers.get("X-Forwarded-For").split(",")
                    client_ip = forwarded_ips[0].strip()


                # creamos un diccionario para generar el token del usuario
                #userDict={"username":username,"password":password,"expires_in":timestamp_unix,"nivel":userVerified.nivel}
                userDict={"userid":userVerified.id,"username":email,"generated":now.timestamp(),"expires_in":timestamp_unix,"nivel":userVerified.id_nivel,"client_ip":client_ip}
                # generamos el token del usuario
                token1: str = create_token(userDict)

                userDict2={"userid":userVerified.id,"username":email,"generated":now.timestamp(),"expires_in":timestamp_unix2,"nivel":userVerified.id_nivel,"client_ip":client_ip}
                # generamos el token del usuario
                token2: str = create_token(userDict2)                

                # creamos el ingreso en el 
                '''
                id = Column(BIGINT, primary_key=True, autoincrement=True)
                user_id = Column(BIGINT,  ForeignKey("Usuario.id", ondelete="RESTRICT", onupdate="CASCADE"), nullable=False)
                observaciones = Column (TEXT, nullable=False)
                created=Column(DATETIME, nullable=False)             
                '''
                newBitacora = BitacoraModel (
                    user_id=userVerified.id,
                    observaciones="Login",
                    created=ahora
                )
                
                session.add(newBitacora)

                session.commit()

                # buscamos en los datos personales para ver si el pefil esta completo
                nRecordDataPersonal = session.query(DatosPersonalesModel).filter(DatosPersonalesModel.user_id == userVerified.id).count()

                if (nRecordDataPersonal > 0):
                    statusProfile=1
                else:
                    statusProfile=0

                '''
                formato de salida
                {
                accessToken: 'token_simulado',
                refreshToken: 'refresh_token_simulado',
                user: {
                    id: 'user123',
                    email: 'usuario@ejemplo.com',
                    roles: ['admin', 'user'],
                    permissions: ['read', 'write']
                },
                expiresIn: 3600 // segundos
                }
                '''
                roles="['user']"

                permisos="['read','write']"

                userData={
                    "id":userVerified.id,
                    "roles": roles,
                    "permisions":permisos
                    }
                
                return JSONResponse (status_code=202,content={"accessToken":token1,"refreshToken":token2,"user":userData,"expireIn": duration_in_minutes2,"statusProfile":statusProfile})
            else:
                #usuario suspendido
                return JSONResponse (status_code=403,content={"message":"Usuario suspendido 3"}) 
        else:
            # 
            if (not userActive):
                return JSONResponse (status_code=402,content={"message":"Usuario no autorizado 2"})               
    
    return JSONResponse (status_code=401,content={"message":"Usuario no autorizado 1"})      



@user_router.post("/validate", 
tags=["Affiliate"])
def validate(request : Request ,token : str = Body):
    #pdb.set_trace()
     # decodifica el token
    if (validate_token(token)):
         # decodifica el token
        data=validate_token(token)
        '''
        data davuelta
        {
        "message": "autorizado",
        "data": {
            "userid": 1,
            "username": "xarcx2@gmail.com",
            "generated": 1751023183.047464,
            "expires_in": 1751051983.047464,
            "nivel": 1,
            "client_ip": "127.0.0.1"
            }
        }        
        si expires_in es mayor que el tiempo actual esta vencido debe crearse un nuevo token

        '''
        # Crea un objeto datetime con la hora actual
        now = datetime.now()

        expireIn=data["expires_in"]
        if (expireIn < now.timestamp()):
            return JSONResponse (status_code=401,content={"message":"sesion expiro"})
        else:
            return JSONResponse (status_code=201,content={"message":"sesion activa"})
    else:
        return JSONResponse (status_code=401,content={"message":"no autorizado"})
    


@user_router.post("/validate_refresh", 
tags=["Affiliate"])
def validate_refresh(request : Request ,token : str = Body,token_refresh : str = Body):
    #pdb.set_trace()
    if (validate_token(token_refresh)):
        # decodifica el token
        data=validate_token(token_refresh)
        '''
        data davuelta
        {
        "message": "autorizado",
        "data": {
            "userid": 1,
            "username": "xarcx2@gmail.com",
            "generated": 1751023183.047464,
            "expires_in": 1751051983.047464,
            "nivel": 1,
            "client_ip": "127.0.0.1"
            }
        }        
        si expires_in es mayor que el tiempo actual esta vencido debe crearse un nuevo token

        '''
        # Crea un objeto datetime con la hora actual
        now = datetime.now()

        expireIn=data["expires_in"]
        if (expireIn < now.timestamp()):
            return JSONResponse (status_code=401,content={"message":"sesion expiro"})
        else:
            #determinamos la ip del cliente
            client_ip = request.client.host

            # Handle cases where a proxy server is involved
            if request.headers.get("X-Forwarded-For"):
                forwarded_ips = request.headers.get("X-Forwarded-For").split(",")
                client_ip = forwarded_ips[0].strip()

            duration_in_minutes = (60 * 60 )

              # Crea un objeto timedelta
            delta = timedelta(seconds=duration_in_minutes)

            # Suma el timedelta a la hora actual
            future_time = now + delta


            timestamp_unix = future_time.timestamp()

            # creamos un diccionario para generar el token del usuario
            #userDict={"username":username,"password":password,"expires_in":timestamp_unix,"nivel":userVerified.nivel}
            userDict={"userid":data["userid"],"generated":now.timestamp(),"expires_in":timestamp_unix,"nivel":data['nivel'],"client_ip":client_ip}
            # generamos el token del usuario
            token2: str = create_token(userDict)        

            '''
            formato de salida
            {
            accessToken: 'token_simulado',
            refreshToken: 'refresh_token_simulado',
            user: {
                id: 'user123',
                email: 'usuario@ejemplo.com',
                roles: ['admin', 'user'],
                permissions: ['read', 'write']
            },
            expiresIn: 3600 // segundos
            }
            '''
            roles="['user']"

            permisos="['read','write']"

            userData={
                "id":data["userid"],
                "roles": roles,
                "permisions":permisos
                }
            
            return JSONResponse (status_code=202,content={"accessToken":token,"refreshToken":token2,"user":userData,"expireIn": duration_in_minutes})
    else:
        return JSONResponse (status_code=401,content={"message":"no autorizado"})    
                
                


# Funcion para crear los datos personales de un usuario
@user_router.post("/create", 
tags=["Affiliate"])
def create(request: Request, usuario : User):
    #pdb.set_trace()
    db = Session()
    # buscamos el registro
    '''    {
        "username":"pperez",
        "password":"12345678",
        "estado":1,
        "confirmado":0,
        "id_nivel":1,
        "codigo":"ABCDEFGHI",
    } '''   

    result = userController(db).create_user(request,usuario)

    if (result['result']=="1"):
        return JSONResponse(status_code=200,content={"message":"Usuario creado, correo de confirmación enviado"})    
    elif (result['result']=="-2"):
        return JSONResponse(status_code=521,content={"message":f"Este correo ya fue registrado"})     
    elif (result['result']=="-3"):
        return JSONResponse(status_code=522,content={"message":f"Se creo el usuario, pero no se pudo enviar el correo de confirmación de datos"})     
    elif (result['result']=="-4"):
        return JSONResponse(status_code=523,content={"message":f"Se creo el usuario, pero no se pudo enlazar a su familia"})    
    elif (result['result']=="-5"):
        return JSONResponse(status_code=524,content={"message":f"Código de referido no existe"})      
    else:
        codigo=result['result']
        cadenaError=result['cadenaError']
        return JSONResponse(status_code=520,content={"message":f"Ocurrió un error que no pudo ser controlado {codigo} {cadenaError} "})     


# Funcion para el codigo de afiliado del afiliado
@user_router.post("/confirmation_email", 
tags=["Affiliate"])
def validate_email(request: Request, i: str):

    if (validate_token(i)):
        data=validate_token(i)
        '''
        "data": {
            "username": "eudojosegonzalez@hotmail.com",
            "generated": 1751854255.463903,
            "client_ip": "127.0.0.1",
            "identificador": "4d253a41-a745-4cfa-921e-e18e263fe867"
        }
        '''
        if ((data['username']) and (data['identificador'])):
            email=data['username']
            identificador=data['identificador']
            #pdb.set_trace()
            db = Session()
            # buscamos el registro 

            result = userController(db).validate_email(request,email,identificador)

            if (result['result']=="1"):
                # existe el correo y se activo la cuenta, se envia al login
                url=f"https://tripleup.net:8000/v1/login"
                return JSONResponse(status_code=200,content={"message":"Usuario confirmado","url":url})  
            elif (result['result']=="-1"):  
                # lEl usuario no existe
                return JSONResponse(status_code=521,content={"message":"Este usuario no existe debe crearse"}) 
            elif (result['result']=="-2"): 
                # el email ya fue confirmado
                return JSONResponse(status_code=522,content={"message":"Este usuario ya fue confirmado"})  
            else:
                cadenaError=result['estado']
                return JSONResponse(status_code=523,content={"message":cadenaError}) 
        else:
            return JSONResponse(status_code=520,content={"message":"El token está mal formateado"})         
    else:
        return JSONResponse(status_code=520,content={"message":"El token está mal formateado"})  



# Funcion para el codigo de afiliado del afiliado
@user_router.get("/share_code", 
tags=["Affiliate"])
def share_cod(request: Request, userid : int):
    #pdb.set_trace()
    db = Session()
    # buscamos el registro 

    result = userController(db).share_code(request,userid)

    if (result['result']=="1"):
        codigo=result['codigo']
        url=f"https://tripleup.net/auth/register?codigo={codigo}"
        return JSONResponse(status_code=200,content={"url":url})    
    elif (result['result']=="-1"):
        return JSONResponse(status_code=521,content={"message":"Usuario no existe"})      
    else:
        paso=result['paso']
        return JSONResponse(status_code=520,content={"message":f"Ocurrió un error que no pudo ser controlado, paso:{paso}"})    
    

# registro de pago en el sistema
@user_router.post ('/pay',
tags=['CallCenter'],
dependencies=[Depends(JWTBearer())], 
responses=
    { 
        201: {
            "description": "Se registro un pago en el sistema",
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
def pay(usuario:User,creatorUserId : int = Query (ge=1, le=os.getenv("MAX_ID_USERS")))->dict:
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



# Funcion para crear los datos personles de un usuario
@user_router.post ('/withdrawal',
tags=['CallCenter'],
dependencies=[Depends(JWTBearer())], 
responses=
    { 
        201: {
            "description": "Se registro un retiro en el sistema",
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
def withdrawal(usuario:User,creatorUserId : int = Query (ge=1, le=os.getenv("MAX_ID_USERS")))->dict:
    db = Session()
    result=userController(db).create_user(usuario,creatorUserId)
    # evaluamos el resultado
    estado=result['result']

    if (estado=="1") :
        # se inserto el registro sin problemas
        data=result["data"]
        return JSONResponse (status_code=201,content={"message":"Se creo un retiro en el sistema","data":jsonable_encoder(data)})     
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




# Funcion para crear preguntas al sistema de soporte
@user_router.post ('/send_question',
tags=['CallCenter'],
dependencies=[Depends(JWTBearer())], 
responses=
    { 
        201: {
            "description": "Se registro un retiro en el sistema",
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
def send_question(usuario:User,creatorUserId : int = Query (ge=1, le=os.getenv("MAX_ID_USERS")))->dict:
    db = Session()
    result=userController(db).create_user(usuario,creatorUserId)
    # evaluamos el resultado
    estado=result['result']

    if (estado=="1") :
        # se inserto el registro sin problemas
        data=result["data"]
        return JSONResponse (status_code=201,content={"message":"Se envió una prfegunta al sistema","data":jsonable_encoder(data)})     
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




# Funcion para crear tickets de soporte al sistema de soporte
@user_router.post ('/open_ticket',
tags=['CallCenter'],
dependencies=[Depends(JWTBearer())], 
responses=
    { 
        201: {
            "description": "Se registro un ticket en el sistema",
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
def open_ticket(usuario:User,creatorUserId : int = Query (ge=1, le=os.getenv("MAX_ID_USERS")))->dict:
    db = Session()
    result=userController(db).create_user(usuario,creatorUserId)
    # evaluamos el resultado
    estado=result['result']

    if (estado=="1") :
        # se inserto el registro sin problemas
        data=result["data"]
        return JSONResponse (status_code=201,content={"message":"Se creo un ticket en el sistema","data":jsonable_encoder(data)})     
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
@user_router.get ('/{id}/profile',
tags=['Affiliate'],
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
                                    "data": "{'name':namePersonales,'email':recordUser.username,'avatar':imagen,'registered':recordUser.created, 'estatus':estadoUser,'directReferrals': nRecorFamiliaresDirectos,'indirectReferrals': nRecorFamiliaresIndirectos,'earnings': ganancias}",
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
def get_user(id:int = Path(ge=1))->dict:
    db = Session()
    # almacenamos el listado de usarios en un resultset
    result = userController(db).get_user(id)
    # debemnos convertir los objetos tipo BD a Json
    if (result):
        if (result["result"]=="1"):
            data=result['data']
            return JSONResponse(status_code=200,content=jsonable_encoder(data))    
        elif (result["result"]=="-2"):
            return JSONResponse(status_code=404,content={"message":"Usuario no encontrado"})     
    return JSONResponse(status_code=520,content={"message":"Usuario no encontrado"})  


# Funcion para consultar los datos personales de un usuario
@user_router.get ('/{id}/personal_data',
tags=['Affiliate'],
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
                                    "data": "{'id': 1,'user_id': 1,'nac': 'V','identificacion': '99999999','nombres': 'PEDRO','apellidos': 'PEREZ','sexo': 1,'fecha_nac': '2000-01-01','created': '2025-08-04T21:23:13','updated': '2025-08-04T21:23:13'}",
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
def get_personal_data_user(id:int = Path(ge=1))->dict:
    db = Session()
    # almacenamos el listado de usarios en un resultset
    result = userController(db).get_personal_data_user(id)
    # debemnos convertir los objetos tipo BD a Json
    if (result):
        if (result["result"]=="1"):
            data=result['data']
            return JSONResponse(status_code=200,content=jsonable_encoder(data))    
        elif (result["result"]=="-2"):
            return JSONResponse(status_code=404,content={"message":"Usuario no encontrado"})     
    return JSONResponse(status_code=520,content={"message":"Usuario no encontrado"})  


# Funcion para consultar los datos de ubicacion del usuario
@user_router.get ('/{id}/personal_address',
tags=['Affiliate'],
dependencies=[Depends(JWTBearer())], 
responses=
    { 
        200: {
                "description": "Datos de ubicacion encontrado",
                "content": { 
                    "application/json":
                        { 
                            "example":
                                {
                                    "message":"Datos de ubicacion encontrado",
                                    "data": "{'id': 1,'user_id': 1,'nac': 'V','identificacion': '99999999','nombres': 'PEDRO','apellidos': 'PEREZ','sexo': 1,'fecha_nac': '2000-01-01','created': '2025-08-04T21:23:13','updated': '2025-08-04T21:23:13'}",
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
            "description": "Datos de ubicacion no encontrado",
            "content": { 
                "application/json":{ 
                    "example":
                        {
                            "message":"Datos de ubicacion no encontrado"
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
def get_personal_address(id:int = Path(ge=1))->dict:
    db = Session()
    # almacenamos el listado de usarios en un resultset
    result = userController(db).get_personal_address(id)
    # debemnos convertir los objetos tipo BD a Json
    if (result):
        if (result["result"]=="1"):
            data=result['data']
            return JSONResponse(status_code=200,content=jsonable_encoder(data))    
        elif (result["result"]=="-2"):
            return JSONResponse(status_code=404,content={"message":"Datos de ubicacion no encontrado"})     
    return JSONResponse(status_code=520,content={"message":"Usuario no encontrado"})  


# Funcion para consultar la familia de un afiliado
@user_router.get('/{id}/family',
tags=['Affiliate'],
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
                                    "message":"Familia encontrada",
                                    "data": "{'id': 1,'codigoReferido': 'REF123456','nombre': 'Juan','apellido': 'Pérez','productosAdquiridos': ['Producto A','Producto B'],'promedioGanancias': 120.50,'referidosIndirectos': 5,'promedioGananciasIndirectos': 30.75,'pnl': 12.3,'gananciasTotales': 500.00,'fechaRegistro': '2023-05-10T14:23:00Z','ultimaActividad': '2025-06-24T09:15:00Z','nivel': 'Oro','estado': 'activo','verificado': true,'contacto': {'email': 'juan.perez@email.com','telefono': '+58 123-4567890'},'tendenciaGanancias': 'subiendo','notas': 'Referido muy activo, excelente conversión.'}"
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
def get_family(id:int = Path(ge=1, le=os.getenv("MAX_ID_USERS")))->dict:
    db = Session()
    # almacenamos el listado de usarios en un resultset
    result = userController(db).get_family(id)
    # debemnos convertir los objetos tipo BD a Json
    if (result):
        if (result["result"]=="1"):
            data=result['data']
            return JSONResponse(status_code=200,content={"message":"familia encontrada","registros":result['nRecord'],"data":jsonable_encoder(data)})    
        else:
            return JSONResponse(status_code=404,content={"message":"Usuario no encontrado"})     
    
    
    return JSONResponse(status_code=404,content={"message":"Usuario no encontrado"})  



# Funcion para consultar las wallets del afiliado
@user_router.get ('/{id}/wallets',
tags=['Affiliate'],
dependencies=[Depends(JWTBearer())], 
responses=
    { 
        200: {
                "description": "Wallets Encontradas",
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
def get_wallets(id:int = Path(ge=1, le=os.getenv("MAX_ID_USERS")))->dict:
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



# Funcion para consultar los productos contratados  de un afiliado
@user_router.get ('/{id}/products',
tags=['Affiliate'],
dependencies=[Depends(JWTBearer())], 
responses=
    { 
        200: {
                "description": "Productos encontrados",
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
def get_products(id:int = Path(ge=1, le=os.getenv("MAX_ID_USERS")))->dict:
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




# Funcion para consultar las wallets del afiliado
@user_router.get ('/{id}/wallets',
tags=['Affiliate'],
dependencies=[Depends(JWTBearer())], 
responses=
    { 
        200: {
                "description": "Wallets Encontradas",
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
def get_wallets(id:int = Path(ge=1, le=os.getenv("MAX_ID_USERS")))->dict:
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



# Funcion para consultar los pagos  de un afiliado
@user_router.get ('/{id}/payments',
tags=['Affiliate'],
dependencies=[Depends(JWTBearer())], 
responses=
    { 
        200: {
                "description": "Pagos encontrados",
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
def get_payments(id:int = Path(ge=1, le=os.getenv("MAX_ID_USERS")))->dict:
    db = Session()
    # almacenamos el listado de usarios en un resultset
    result = userController(db).get_user(id)
    # debemnos convertir los objetos tipo BD a Json
    if (result):
        if (result["result"]=="1"):
            data=result['data']
            return JSONResponse(status_code=200,content=jsonable_encoder(data))    
        else:
            return JSONResponse(status_code=404,content={"message":"Pagos no encontrados"})     
    
    
    return JSONResponse(status_code=404,content={"message":"Pagos no encontrado"})  


# Funcion para consultar el hostorial de retiro
@user_router.get ('/{id}/withdrawal_history',
tags=['Affiliate'],
dependencies=[Depends(JWTBearer())], 
responses=
    { 
        200: {
                "description": "Historial de Retios encontrados",
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
def get_withdrawal_history(id:int = Path(ge=1, le=os.getenv("MAX_ID_USERS")))->dict:
    db = Session()
    # almacenamos el listado de usarios en un resultset
    result = userController(db).get_user(id)
    # debemnos convertir los objetos tipo BD a Json
    if (result):
        if (result["result"]=="1"):
            data=result['data']
            return JSONResponse(status_code=200,content=jsonable_encoder(data))    
        else:
            return JSONResponse(status_code=404,content={"message":"Historial de retiros no encontrados"})     
    
    
    return JSONResponse(status_code=404,content={"message":"Historial de retiros no encontrados"})  



# Funcion para consultar el hostorial de retiro
@user_router.get ('/{id}/tickets',
tags=['Affiliate'],
dependencies=[Depends(JWTBearer())], 
responses=
    { 
        200: {
                "description": "Historial de Tickets encontrados",
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
def get_tickets(id:int = Path(ge=1, le=os.getenv("MAX_ID_USERS")))->dict:
    db = Session()
    # almacenamos el listado de usarios en un resultset
    result = userController(db).get_user(id)
    # debemnos convertir los objetos tipo BD a Json
    if (result):
        if (result["result"]=="1"):
            data=result['data']
            return JSONResponse(status_code=200,content=jsonable_encoder(data))    
        else:
            return JSONResponse(status_code=404,content={"message":"Historial de tickets no encontrados"})     
    
    
    return JSONResponse(status_code=404,content={"message":"Historial de tickets no encontrados"})  



'''
============================ rutas PUT =================================================================
'''
# Función para actualizar  los datos del usuario
@user_router.put ('/{id}/update',
tags=['Affiliate'],
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
                                    "message":"Familia encontrada",
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



# Función para actualizar  los datos del usuario
@user_router.put ('/{id}/update_personal_data',
tags=['Affiliate'],
dependencies=[Depends(JWTBearer())],
responses=
    { 
        200: {
                "description": "Datos Personales Actualizados",
                "content": { 
                    "application/json":
                        { 
                            "example":
                                {
                                    "message":"Datos Personales Actualizados",
                                    "data": "{'id': 1,'user_id': 1,'nac': 'V','identificacion': '99999999','nombres': 'PEDRO','apellidos': 'PEREZ','sexo': 1,'fecha_nac': '2000-01-01','created': '2025-08-04T21:23:13','updated': '2025-08-04T21:23:13'}",
                                }
                        } 
                    
                } 
                    
            },   
        201: {
                "description": "Datos Personales Creados",
                "content": { 
                    "application/json":
                        { 
                            "example":
                                {
                                    "message":"Datos Personales Creados",
                                    "data": "{'id': 1,'user_id': 1,'nac': 'V','identificacion': '99999999','nombres': 'PEDRO','apellidos': 'PEREZ','sexo': 1,'fecha_nac': '2000-01-01','created': '2025-08-04T21:23:13','updated': '2025-08-04T21:23:13'}",
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
def update_personal_data_user(dataPersonal : DatosPersonalesSchema, id : int =Path(ge=1))->dict:
    db = Session()
    # buscamos el registro
    result = userController(db).update_personal_data_user(dataPersonal ,id) 
    if (result['result']=="1"):
        data=result['data']
        return JSONResponse(status_code=200,content={"message":"Datos Personales Actualizados","DatosPersonales":jsonable_encoder(data)})    
    elif (result['result']=="2"):
        data=result['data']
        return JSONResponse(status_code=201,content={"message":"Datos Personales Creados","DatosPersonales":jsonable_encoder(data)})   
    else:
        codigo=result['result']
        cadenaError=result['cadenaError']
        return JSONResponse(status_code=520,content={"message":f"Ocurrió un error que no pudo ser controlado {codigo} {cadenaError} "})  
    

#Función para actualizar  los datos de de ubicacion
@user_router.put ('/{id}/update_ubication_data',
tags=['Affiliate'],
dependencies=[Depends(JWTBearer())],
responses=
    { 
        200: {
                "description": "Datos de Ubicación Actualizados",
                "content": { 
                    "application/json":
                        { 
                            "example":
                                {
                                    "message":"Datos de Ubicación Actualizados",
                                    "data": "{'id': 1,'user_id': 1,'nac': 'V','identificacion': '99999999','nombres': 'PEDRO','apellidos': 'PEREZ','sexo': 1,'fecha_nac': '2000-01-01','created': '2025-08-04T21:23:13','updated': '2025-08-04T21:23:13'}",
                                }
                        } 
                    
                } 
                    
            },   
        201: {
                "description": "Datos de Ubicacion Creados",
                "content": { 
                    "application/json":
                        { 
                            "example":
                                {
                                    "message":"Datos de Ubicacion Creados",
                                    "data": "{'id': 1,'user_id': 1,'nac': 'V','identificacion': '99999999','nombres': 'PEDRO','apellidos': 'PEREZ','sexo': 1,'fecha_nac': '2000-01-01','created': '2025-08-04T21:23:13','updated': '2025-08-04T21:23:13'}",
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
def update_ubication_data_user(dataPersonal : DatosPersonalesSchema, id : int =Path(ge=1))->dict:
    db = Session()
    # buscamos el registro
    result = userController(db).update_personal_data_user(dataPersonal ,id) 
    if (result['result']=="1"):
        data=result['data']
        return JSONResponse(status_code=200,content={"message":"Datos Personales Actualizados","DatosPersonales":jsonable_encoder(data)})    
    elif (result['result']=="2"):
        data=result['data']
        return JSONResponse(status_code=201,content={"message":"Datos Personales Creados","DatosPersonales":jsonable_encoder(data)})   
    else:
        codigo=result['result']
        cadenaError=result['cadenaError']
        return JSONResponse(status_code=520,content={"message":f"Ocurrió un error que no pudo ser controlado {codigo} {cadenaError} "}) 


#Función para actualizar  los datos de de ubicacion
@user_router.put ('/{id}/update_contact_data',
tags=['Affiliate'],
dependencies=[Depends(JWTBearer())],
responses=
    { 
        200: {
                "description": "Datos de Contacto Actualizados",
                "content": { 
                    "application/json":
                        { 
                            "example":
                                {
                                    "message":"Datos de Contacto Actualizados",
                                    "data": "{'id': 1,'user_id': 1,'nac': 'V','identificacion': '99999999','nombres': 'PEDRO','apellidos': 'PEREZ','sexo': 1,'fecha_nac': '2000-01-01','created': '2025-08-04T21:23:13','updated': '2025-08-04T21:23:13'}",
                                }
                        } 
                    
                } 
                    
            },   
        201: {
                "description": "Datos de Contacto Creados",
                "content": { 
                    "application/json":
                        { 
                            "example":
                                {
                                    "message":"Datos de Contacto Creados",
                                    "data": "{'id': 1,'user_id': 1,'nac': 'V','identificacion': '99999999','nombres': 'PEDRO','apellidos': 'PEREZ','sexo': 1,'fecha_nac': '2000-01-01','created': '2025-08-04T21:23:13','updated': '2025-08-04T21:23:13'}",
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
def update_contact_data_user(dataPersonal : DatosPersonalesSchema, id : int =Path(ge=1))->dict:
    db = Session()
    # buscamos el registro
    result = userController(db).update_personal_data_user(dataPersonal ,id) 
    if (result['result']=="1"):
        data=result['data']
        return JSONResponse(status_code=200,content={"message":"Datos Personales Actualizados","DatosPersonales":jsonable_encoder(data)})    
    elif (result['result']=="2"):
        data=result['data']
        return JSONResponse(status_code=201,content={"message":"Datos Personales Creados","DatosPersonales":jsonable_encoder(data)})   
    else:
        codigo=result['result']
        cadenaError=result['cadenaError']
        return JSONResponse(status_code=520,content={"message":f"Ocurrió un error que no pudo ser controlado {codigo} {cadenaError} "})      
    

# ruta para actualizar los datos de forma combinada
@user_router.put ('/{id}/update_all_data',
tags=['Affiliate'],
dependencies=[Depends(JWTBearer())],
responses=
    { 
        200: {
                "description": "Datos de Contacto Actualizados",
                "content": { 
                    "application/json":
                        { 
                            "example":
                                {
                                    "message":"Datos de Contacto Actualizados",
                                    "data": "{'id': 1,'user_id': 1,'nac': 'V','identificacion': '99999999','nombres': 'PEDRO','apellidos': 'PEREZ','sexo': 1,'fecha_nac': '2000-01-01','created': '2025-08-04T21:23:13','updated': '2025-08-04T21:23:13'}",
                                }
                        } 
                    
                } 
                    
            },   
        201: {
                "description": "Datos de Contacto Creados",
                "content": { 
                    "application/json":
                        { 
                            "example":
                                {
                                    "message":"Datos de Contacto Creados",
                                    "data": "{'id': 1,'user_id': 1,'nac': 'V','identificacion': '99999999','nombres': 'PEDRO','apellidos': 'PEREZ','sexo': 1,'fecha_nac': '2000-01-01','created': '2025-08-04T21:23:13','updated': '2025-08-04T21:23:13'}",
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
def update_all_data_user(dataPersonal : AllDataUserSchema , id : int =Path(ge=1))->dict:
    db = Session()
    # buscamos el registro
    result = userController(db).update_all_data_user(dataPersonal ,id) 
    if (result['result']=="1"):
        data=result['data']
        return JSONResponse(status_code=200,content={"message":"Datos Actualizados","DatosPersonales":jsonable_encoder(data)})    
    elif (result['result']=="2"):
        data=result['data']
        return JSONResponse(status_code=201,content={"message":"Datos Personales Creados","DatosPersonales":jsonable_encoder(data)})   
    else:
        codigo=result['result']
        cadenaError=result['cadenaError']
        return JSONResponse(status_code=520,content={"message":f"Ocurrió un error que no pudo ser controlado {codigo} {cadenaError} "})      
  

# Función para actualizar  la clave de un usuario
@user_router.put ('/{id}/update_password',
tags=['Affiliate'],
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
    


# Función para cerrar un ticket en el iste,a
@user_router.put ('/{id}/ticket/{idticket}/close',
tags=['Affiliate'],
dependencies=[Depends(JWTBearer())], 
responses=
    { 
        201: {
            "description": "Ticket Cerrado",
            "content": { 
                "application/json":{ 
                    "example":
                        {
                            "message":"Ticket Cerrado",
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
def close_ticket (idticket : int =Path (ge=1,le=10000), id : int = Path (ge=1, le=os.getenv('MAX_ID_USERS'))):
    # db = Session()
    # buscamos el registro
    # result = userController(db).update_password_user(id,user_updater, password) 
    result={"result":"1"}
    if (result['result']=="1"):
        newPassword=result["newPassword"]
        return JSONResponse(status_code=201,content={"message":"Ticket Cerrado","newpassword":newPassword})    
    elif (result['result']=="-1"):
        return JSONResponse(status_code=404,content={"message":"Usuario no encontrado"}) 
    else:
        return JSONResponse(status_code=520,content={"message":"Ocurrió un error que no pudo ser controlado"})  
    



# Función para cerrar un ticket en el iste,a
@user_router.put ('/{id}/ticket/{idticket}/reopen',
tags=['Affiliate'],
dependencies=[Depends(JWTBearer())], 
responses=
    { 
        201: {
            "description": "Ticket Reabierto",
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
def reopen_ticket (idticket : int =Path (ge=1,le=10000), id : int = Path (ge=1, le=os.getenv('MAX_ID_USERS'))):
    # db = Session()
    # buscamos el registro
    # result = userController(db).update_password_user(id,user_updater, password) 
    result={"result":"1"}
    if (result['result']=="1"):
        newPassword=result["newPassword"]
        return JSONResponse(status_code=201,content={"message":"Password de Usuario Actualizado","newpassword":newPassword})    
    elif (result['result']=="-1"):
        return JSONResponse(status_code=404,content={"message":"Usuario no encontrado"}) 
    else:
        return JSONResponse(status_code=520,content={"message":"Ocurrió un error que no pudo ser controlado"})  
    