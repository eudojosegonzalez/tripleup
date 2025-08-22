'''
Rutas de dashboarad_admin
Created: 2024-06
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


from datetime import datetime,timedelta


#from typing import  Optional, List
from typing import  List
# importamos desde la configuracion de la Base de datos las clases
from config.database import Session



#importamos la libreria para generar el token y validarlo
import jwt 
from utils.jwt_managr import create_token,validate_token


# importamos el controlador 
from controller.user_dashboarad_admin import dashboarad_adminController
from controller.admin_dashboarad_admin import dashboarad_adminAdminController


# importamos la utilidad para generar el hash del password
from utils.hasher import hash_password,verify_password


# esto importa la tabla desde la definiciones de modelos
from models.user import Usuario as UsuarioModel


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
dashboarad_admin_router = APIRouter(prefix="/V1.0")



'''
============================ rutas POST =================================================================
'''
# Funcion para listar los usuarios
@dashboarad_admin_router.post ('/dashboarad_admin/{id}/send_message',
tags=['dashboarad_admin'],
dependencies=[Depends(JWTBearer())], 
responses=
    { 
        201: {
            "description": "Mensaje enviado",
            "content": { 
                "application/json":{
                    "example":
                        {
                            "message":"Mensaje enviado"
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
                            "message":"Usuario no encontradp"
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
def send_message_user(id:int=Path(ge=1), remitente : int =Query (ge=1),asunto : str = Query (min_length=3, max_length=150),texto : str = Query (min_length=3, max_length=500))->dict:
    db = Session()
    # almacenamos el listado de usarios en un resultset
    result = dashboarad_adminController(db).send_message_user(id,remitente,asunto,texto)

    # debemnos convertir los objetos tipo BD a Json
    if (result["result"]=="1"):
        return JSONResponse(status_code=201,content={"message":"Mensaje enviado"}) 
    if (result["result"]=="-2"):
        return JSONResponse(status_code=404,content={"message":"Usuario no encontrado"})         
    else:
        cadenaError=result["cadenaError"]
        return JSONResponse(status_code=520,content={"message":f"{cadenaError}"})  


'''
============================ rutas GET =================================================================
'''
# Funcion para mostrar las consultas inciales del sistem
@dashboarad_admin_router.get ('/dashboarad_admin/',
tags=['dashboarad_admin'],
dependencies=[Depends(JWTBearer())], 
responses=
    { 
        200: {
            "description": "Dashboarad  Administradores",
            "content": { 
                "application/json":{
                    "example":
                        {
                            "message":"dashboarad_admin Administradores",
                            "data":"{'id':1}"
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
def index()->dict:
    data=[{'id':1},{'id':2},{'id':3}]
    return JSONResponse (status_code=200,content={"message":"Datos del dashboarad_admin","data":jsonable_encoder(data)})     



# Funcion para listar loas afiliados del sistema
'''@dashboarad_admin_router.get ('/dashboarad_admin/list_affiliates',
tags=['dashboarad_admin'],
dependencies=[Depends(JWTBearer())], 
responses=
    { 
        200: {
            "description": "Afiliados encontrados",
            "content": { 
                "application/json":{
                    "example":
                        {
                            "message":"Afiliados encontrados",
                            "data":"{'id':1}"
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
def list_user()->dict:
    data=[{'id':1},{'id':2},{'id':3}]
    return JSONResponse (status_code=200,content={"message":"Usuarios encontrados","data":jsonable_encoder(data)})     
'''

# Funcion para listar los usuarios
'''@dashboarad_admin_router.get ('/dashboarad_admin/search_affiliates',
tags=['dashboarad_admin'],
dependencies=[Depends(JWTBearer())], 
responses=
    { 
        200: {
            "description": "Buscar afiliados",
            "content": { 
                "application/json":{
                    "example":
                        {
                            "message":"Estados de usuarios encontrados",
                            "data":"{'id':1}"
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
def get_search_affiliates()->dict:
    db = Session()
    # almacenamos el listado de usarios en un resultset
    result = dashboarad_adminController(db).get_status_users()

    # debemnos convertir los objetos tipo BD a Json
    if (result["result"]=="1"):
        data=result["data"]
        return JSONResponse(status_code=200,content={"message":"Data encontrada","data":jsonable_encoder(data)})    
    elif (result["result"]=="-2"):
        return JSONResponse(status_code=404,content={"message":"No hay registros que mostrar"})
    else:
        cadenaError=result["cadenaError"]
        return JSONResponse(status_code=520,content={"message":f"{cadenaError}"})'''
   
    

# Funcion para listar los usuarios
'''@dashboarad_admin_router.get ('/dashboarad_admin/query_inversions',
tags=['dashboarad_admin'],
dependencies=[Depends(JWTBearer())], 
responses=
    { 
        200: {
            "description": "Consulta de las inversiones en el sistema",
            "content": { 
                "application/json":{
                    "example":
                        {
                            "message":"Consulta de las inversiones en el sistema",
                            "data":"{'id':1}"
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
def query_inversions(fechaInicio : str, fechaFin : str, estado : int =Query(ge=0,le=9))->dict:
    db = Session()
    # almacenamos el listado de usarios en un resultset
    result = dashboarad_adminController(db).report_status_users(fechaInicio, fechaFin, estado)

    # debemnos convertir los objetos tipo BD a Json
    if (result["result"]=="1"):
        data=result["data"]
        return JSONResponse(status_code=200,content={"message":"Data encontrada","data":jsonable_encoder(data)})    
    elif (result["result"]=="-2"):
        return JSONResponse(status_code=404,content={"message":"No hay registros que mostrar"})
'''



    
# Funcion para listar el historico de estados de los usuarios
'''@dashboarad_admin_router.get ('/dashboarad_admin/query_withdrawal',
tags=['dashboarad_admin'],
dependencies=[Depends(JWTBearer())], 
responses=
    { 
        200: {
            "description": "Consulta de los retiros",
            "content": { 
                "application/json":{
                    "example":
                        {
                            "message":"Consulta de los Retiros",
                            "data":"{'id':1}"
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
def query_withdrawal(fechaInicio : str, fechaFin : str, estado : str)->dict:
    db = Session()
    # almacenamos el listado de usarios en un resultset
    result = dashboarad_adminController(db).reporte_historico_estados_users(fechaInicio, fechaFin, estado)

    # debemnos convertir los objetos tipo BD a Json
    if (result["result"]=="1"):
        data=result["data"]
        archivo=result["archivo"]
        return JSONResponse(status_code=200,content={"message":"Data encontrada","data":jsonable_encoder(data),"archivo":archivo})    
    elif (result["result"]=="-2"):
        return JSONResponse(status_code=404,content={"message":"No hay registros que mostrar"})
    else:
        cadenaError=result["cadenaError"]
        return JSONResponse(status_code=520,content={"message":f"{cadenaError}"})'''



# Funcion para listar los detalles de un retiro
'''@dashboarad_admin_router.get ('/dashboarad_admin/{id}/withdrawal_details',
tags=['dashboarad_admin'],
dependencies=[Depends(JWTBearer())], 
responses=
    { 
        200: {
            "description": "Consulta detalles de de los retiros",
            "content": { 
                "application/json":{
                    "example":
                        {
                            "message":"Consulta detalles de de los retiros",
                            "data":"{'id':1}"
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
def withdrawal_details(fechaInicio : str, fechaFin : str, estado : str, id : int = Path(ge=1,le=10000))->dict:
    db = Session()
    # almacenamos el listado de usarios en un resultset
    result = dashboarad_adminController(db).reporte_historico_estados_users(fechaInicio, fechaFin, estado)

    # debemnos convertir los objetos tipo BD a Json
    if (result["result"]=="1"):
        data=result["data"]
        archivo=result["archivo"]
        return JSONResponse(status_code=200,content={"message":"Data encontrada","data":jsonable_encoder(data),"archivo":archivo})    
    elif (result["result"]=="-2"):
        return JSONResponse(status_code=404,content={"message":"No hay registros que mostrar"})
    else:
        cadenaError=result["cadenaError"]
        return JSONResponse(status_code=520,content={"message":f"{cadenaError}"})
    '''

    
# Funcion para listar los pagos en el sistema
'''@dashboarad_admin_router.get ('/dashboarad_admin/query_payments',
tags=['dashboarad_admin'],
dependencies=[Depends(JWTBearer())], 
responses=
    { 
        200: {
            "description": "Consulta los pagos en el sistema",
            "content": { 
                "application/json":{
                    "example":
                        {
                            "message":"Consulta los pagos en el sistema",
                            "data":"{'id':1}"
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
def query_payments(fechaInicio : str, fechaFin : str, estado : str)->dict:
    db = Session()
    # almacenamos el listado de usarios en un resultset
    result = dashboarad_adminController(db).reporte_historico_estados_users(fechaInicio, fechaFin, estado)

    # debemnos convertir los objetos tipo BD a Json
    if (result["result"]=="1"):
        data=result["data"]
        archivo=result["archivo"]
        return JSONResponse(status_code=200,content={"message":"Data encontrada","data":jsonable_encoder(data),"archivo":archivo})    
    elif (result["result"]=="-2"):
        return JSONResponse(status_code=404,content={"message":"No hay registros que mostrar"})
    else:
        cadenaError=result["cadenaError"]
        return JSONResponse(status_code=520,content={"message":f"{cadenaError}"})
    
'''


# Funcion para listar los pagos en el sistema
'''@dashboarad_admin_router.get ('/dashboarad_admin/{id}/payments_details',
tags=['dashboarad_admin'],
dependencies=[Depends(JWTBearer())], 
responses=
    { 
        200: {
            "description": "Consulta los detalles de un pago en el sistema",
            "content": { 
                "application/json":{
                    "example":
                        {
                            "message":"Consulta los detalles de un pago en el sistema",
                            "data":"{'id':1}"
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
def payments_details(fechaInicio : str, fechaFin : str, estado : str, id: int = Path (ge=1, le=10000))->dict:
    db = Session()
    # almacenamos el listado de usarios en un resultset
    result = dashboarad_adminController(db).reporte_historico_estados_users(fechaInicio, fechaFin, estado)

    # debemnos convertir los objetos tipo BD a Json
    if (result["result"]=="1"):
        data=result["data"]
        archivo=result["archivo"]
        return JSONResponse(status_code=200,content={"message":"Data encontrada","data":jsonable_encoder(data),"archivo":archivo})    
    elif (result["result"]=="-2"):
        return JSONResponse(status_code=404,content={"message":"No hay registros que mostrar"})
    else:
        cadenaError=result["cadenaError"]
        return JSONResponse(status_code=520,content={"message":f"{cadenaError}"})    
    

# Funcion para listar los tickets en el sistema
@dashboarad_admin_router.get ('/dashboarad_admin/query_tickets',
tags=['dashboarad_admin'],
dependencies=[Depends(JWTBearer())], 
responses=
    { 
        200: {
            "description": "Consulta los pagos en el sistema",
            "content": { 
                "application/json":{
                    "example":
                        {
                            "message":"Consulta los pagos en el sistema",
                            "data":"{'id':1}"
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
def query_tickets(fechaInicio : str, fechaFin : str, estado : str)->dict:
    db = Session()
    # almacenamos el listado de usarios en un resultset
    result = dashboarad_adminController(db).reporte_historico_estados_users(fechaInicio, fechaFin, estado)

    # debemnos convertir los objetos tipo BD a Json
    if (result["result"]=="1"):
        data=result["data"]
        archivo=result["archivo"]
        return JSONResponse(status_code=200,content={"message":"Data encontrada","data":jsonable_encoder(data),"archivo":archivo})    
    elif (result["result"]=="-2"):
        return JSONResponse(status_code=404,content={"message":"No hay registros que mostrar"})
    else:
        cadenaError=result["cadenaError"]
        return JSONResponse(status_code=520,content={"message":f"{cadenaError}"})
'''    



# Funcion para listar los tickets en el sistema
'''@dashboarad_admin_router.get ('/dashboarad_admin/{id}/tickets_details',
tags=['dashboarad_admin'],
dependencies=[Depends(JWTBearer())], 
responses=
    { 
        200: {
            "description": "Consulta los detalles de un  ticket en el sistema",
            "content": { 
                "application/json":{
                    "example":
                        {
                            "message":"Consulta los detalles de un  ticket en el sistema",
                            "data":"{'id':1}"
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
def tickets_details(fechaInicio : str, fechaFin : str, estado : str, id : int = Path(ge=1, le=10000))->dict:
    db = Session()
    # almacenamos el listado de usarios en un resultset
    result = dashboarad_adminController(db).reporte_historico_estados_users(fechaInicio, fechaFin, estado)

    # debemnos convertir los objetos tipo BD a Json
    if (result["result"]=="1"):
        data=result["data"]
        archivo=result["archivo"]
        return JSONResponse(status_code=200,content={"message":"Data encontrada","data":jsonable_encoder(data),"archivo":archivo})    
    elif (result["result"]=="-2"):
        return JSONResponse(status_code=404,content={"message":"No hay registros que mostrar"})
    else:
        cadenaError=result["cadenaError"]
        return JSONResponse(status_code=520,content={"message":f"{cadenaError}"})
    
'''


# Funcion para listar los tickets en el sistema
'''@dashboarad_admin_router.get ('/dashboarad_admin/list_products',
tags=['dashboarad_admin'],
dependencies=[Depends(JWTBearer())], 
responses=
    { 
        200: {
            "description": "Consulta los productos en el sistema",
            "content": { 
                "application/json":{
                    "example":
                        {
                            "message":"Consulta los pagos en el sistema",
                            "data":"{'id':1}"
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
def list_products(fechaInicio : str, fechaFin : str, estado : str)->dict:
    db = Session()
    # almacenamos el listado de usarios en un resultset
    result = dashboarad_adminController(db).reporte_historico_estados_users(fechaInicio, fechaFin, estado)

    # debemnos convertir los objetos tipo BD a Json
    if (result["result"]=="1"):
        data=result["data"]
        archivo=result["archivo"]
        return JSONResponse(status_code=200,content={"message":"Data encontrada","data":jsonable_encoder(data),"archivo":archivo})    
    elif (result["result"]=="-2"):
        return JSONResponse(status_code=404,content={"message":"No hay registros que mostrar"})
    else:
        cadenaError=result["cadenaError"]
        return JSONResponse(status_code=520,content={"message":f"{cadenaError}"})

'''


# Funcion para listar los tickets en el sistema
'''@dashboarad_admin_router.get ('/dashboarad_admin/{id}/details_products',
tags=['dashboarad_admin'],
dependencies=[Depends(JWTBearer())], 
responses=
    { 
        200: {
            "description": "Consulta los detalles de un producto en el sistema",
            "content": { 
                "application/json":{
                    "example":
                        {
                            "message":"Consulta los detalles de un producto en el sistema",
                            "data":"{'id':1}"
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
def products_details(fechaInicio : str, fechaFin : str, estado : str, id : int = Path(ge=1, le=10000))->dict:
    db = Session()
    # almacenamos el listado de usarios en un resultset
    result = dashboarad_adminController(db).reporte_historico_estados_users(fechaInicio, fechaFin, estado)

    # debemnos convertir los objetos tipo BD a Json
    if (result["result"]=="1"):
        data=result["data"]
        archivo=result["archivo"]
        return JSONResponse(status_code=200,content={"message":"Data encontrada","data":jsonable_encoder(data),"archivo":archivo})    
    elif (result["result"]=="-2"):
        return JSONResponse(status_code=404,content={"message":"No hay registros que mostrar"})
    else:
        cadenaError=result["cadenaError"]
        return JSONResponse(status_code=520,content={"message":f"{cadenaError}"})'''