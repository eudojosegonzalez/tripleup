'''
Rutas de dashboard_admin
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
from controller.admin_dashboard import dashboardAdminController




# esto importa la tabla desde la definiciones de modelos
from models.user import Usuario as UsuarioModel
from models.aseguradora import Aseguradora as AseguradoraModel
from models.producto_seguro import ProductoPoliza as ProductoPolizaModel


#importamos el esquema de datos para utilizarlo como referencia de datos a la hora de capturar data
from schemas.user import User
from schemas.login import Login
from schemas.aseguradora import Aseguradora as AseguradoraSchema
from schemas.producto_seguro import ProductoSeguro as ProductoSeguroSchema

#from middleware.error_handler import ErrorHandler
from middleware.jwt_bearer import JWTBearer

# importamos la configuracion de la base de datos
from config.database import Session

#cargamos las variables de entorno
dotenv.load_dotenv()


# esta variable define al router
admin_dashboarad_router = APIRouter(prefix="/V1.0")


'''
============================ rutas las empresas de seguros =================================================================
'''

# Funcion para mostrar las empresas aseguradoras en el sistema
@admin_dashboarad_router.get ('/dashboard_admin/insurance/list',
tags=['dashboard_admin/insurance'],
dependencies=[Depends(JWTBearer())], 
responses=
    { 
        200: {
            "description": "Aseguradoras en el sistema",
            "content": { 
                "application/json":{
                    "example":
                        {
                            "message":"ProductosAseguradoras en el sistema",
                            "data":"[{id: 1,name: 'Mercantil Seguros',status: 'Activa',image: 'mercantil-seguros.png',verified: true,	telefonos: {emergencia: ['(+58) 212 5551234', '(+58) 212 5555678'],soporte: ['(+58) 212 5554321', '(+58) 212 5558765']},]"
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
def list_insurance()->dict:
    db = Session()
    # almacenamos el listado de usarios en un resultset
    result = dashboardAdminController(db).list_insurance()
    # debemnos convertir los objetos tipo BD a Json
    if (result):
        if (result["result"]=="1"):
            data=result['data']
            return JSONResponse(status_code=200,content={"message":"aseguradoras encontradas","data":jsonable_encoder(data)})    
        elif (result["result"]=="-2"):
            return JSONResponse(status_code=404,content={"message":"No se han registrado aseguradoras en el sistema"})     
        else:
            return JSONResponse(status_code=520,content={"message":"Ocurrio un error que no pudo ser controlado"}) 
            
    return JSONResponse(status_code=520,content={"message":"Ocurrio un error que no pudo ser controlado"}) 


# Funcion para mostrar las empresas aseguradoras en el sistema
@admin_dashboarad_router.post ('/dashboard_admin/insurance/create',
tags=['dashboard_admin/insurance'],
dependencies=[Depends(JWTBearer())], 
responses=
    { 
        201: {
            "description": "Aseguradora Creada",
            "content": { 
                "application/json":{
                    "example":
                        {
                            "message":"Aseguradora Creada",
                            "data":"id: 1,name: 'Mercantil Seguros',status: 'Activa',image: 'mercantil-seguros.png',verified: true,	telefonos: {emergencia: ['(+58) 212 5551234', '(+58) 212 5555678'],soporte: ['(+58) 212 5554321', '(+58) 212 5558765']},"
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
            "description": "Conflict",
            "content": { 
                "application/json":{ 
                    "example":
                        {
                            "message":"Esta aseguradora ya fue registrada",
                            "data":"id: 1,name: 'Mercantil Seguros',status: 'Activa',image: 'mercantil-seguros.png',verified: true,	telefonos: {emergencia: ['(+58) 212 5551234', '(+58) 212 5555678'],soporte: ['(+58) 212 5554321', '(+58) 212 5558765']},"
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
def create_insurance(aseguradora : AseguradoraSchema, userCreatorId : int = Query (ge=1))->dict:
    db = Session()
    # almacenamos el listado de usarios en un resultset
    result = dashboardAdminController(db).create_insurance(aseguradora,userCreatorId)
    # debemnos convertir los objetos tipo BD a Json
    if (result):
        if (result["result"]=="1"):
            data=result['data']
            return JSONResponse(status_code=200,content={"message":"Aseguradora creada","data":jsonable_encoder(data)})    
        elif (result["result"]=="-1"):
            data=result['data']
            return JSONResponse(status_code=409,content={"message":"Esta aseguradora ya fue registrada","data":jsonable_encoder(data)})              
        else:
            return JSONResponse(status_code=520,content={"message":"Ocurrió un error que no pudo ser controlado"})     
    return JSONResponse(status_code=520,content={"message":"Ocurrió un error que no pudo ser controlado"})    



# Funcion para mostrar las empresas aseguradoras en el sistema
@admin_dashboarad_router.get ('/dashboard_admin/insurance/{id}',
tags=['dashboard_admin/insurance'],
dependencies=[Depends(JWTBearer())], 
responses=
    { 
        200: {
            "description": "Aseguradora encontrada",
            "content": { 
                "application/json":{
                    "example":
                        {
                            "message":"Aseguradora encontrada",
                            "data":"id: 1,name: 'Mercantil Seguros',status: 'Activa',image: 'mercantil-seguros.png',verified: true,	telefonos: {emergencia: ['(+58) 212 5551234', '(+58) 212 5555678'],soporte: ['(+58) 212 5554321', '(+58) 212 5558765']},"
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
            "description": "Record Not Found",
            "content": { 
                "application/json":{ 
                    "example":
                        {
                            "message":"No se ha encontrado esta aseguradoras en el sistema"
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
def get_insurance(id : int )->dict:
    db = Session()
    # almacenamos el listado de usarios en un resultset
    result = dashboardAdminController(db).get_insurance(id)
    # debemnos convertir los objetos tipo BD a Json
    if (result):
        if (result["result"]=="1"):
            data=result['data']
            return JSONResponse(status_code=200,content={"message":"Aseguradora encontrada","data":jsonable_encoder(data)})    
        elif (result["result"]=="-1"):
            return JSONResponse(status_code=404,content={"message":"No se ha encontrado esta aseguradoras en el sistema"}) 
        else:
            return JSONResponse(status_code=520,content={"message":result["cadenaError"]})
             
    return JSONResponse(status_code=520,content={"message":"Ocurrió un error que no pudo ser controlado"})   


# Funcion para mostrar las empresas aseguradoras en el sistema
@admin_dashboarad_router.put ('/dashboard_admin/insurance/{id}/update',
tags=['dashboard_admin/insurance'],
dependencies=[Depends(JWTBearer())], 
responses=
    { 
        201: {
            "description": "Aseguradora Actualizada",
            "content": { 
                "application/json":{
                    "example":
                        {
                            "message":"Aseguradora Creada",
                            "data":"id: 1,name: 'Mercantil Seguros',status: 'Activa',image: 'mercantil-seguros.png',verified: true,	telefonos: {emergencia: ['(+58) 212 5551234', '(+58) 212 5555678'],soporte: ['(+58) 212 5554321', '(+58) 212 5558765']},"
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
            "description": "Conflict",
            "content": { 
                "application/json":{ 
                    "example":
                        {
                            "message":"Esta aseguradora ya fue registrada",
                            "data":"id: 1,name: 'Mercantil Seguros',status: 'Activa',image: 'mercantil-seguros.png',verified: true,	telefonos: {emergencia: ['(+58) 212 5551234', '(+58) 212 5555678'],soporte: ['(+58) 212 5554321', '(+58) 212 5558765']},"
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
def update_insurance(aseguradora : AseguradoraSchema, userUpdaterId : int = Query (ge=1), id : int = Path (ge=1) )->dict:
    db = Session()
    # almacenamos el listado de usarios en un resultset
    result = dashboardAdminController(db).update_insurance(id,aseguradora,userUpdaterId)
    # debemnos convertir los objetos tipo BD a Json
    if (result):
        if (result["result"]=="1"):
            data=result['data']
            return JSONResponse(status_code=200,content={"message":"Aseguradora Actualizada","data":jsonable_encoder(data)})    
        elif (result["result"]=="-1"):
            return JSONResponse(status_code=404,content={"message":"No se ha encontrado esta aseguradora en el sistema"})              
        elif (result["result"]=="-2"):
            return JSONResponse(status_code=409,content={"message":"Existe una aseguradora con este nombre no puede utilizarlo"})              
        else:
            return JSONResponse(status_code=520,content={"message":"Ocurrió un error que no pudo ser controlado"})     
    return JSONResponse(status_code=520,content={"message":"Ocurrió un error que no pudo ser controlado"})    



'''
============================ rutas de los productos de seguro =================================================================
'''

# Funcion para mostrar las empresas aseguradoras en el sistema
@admin_dashboarad_router.get ('/dashboard_admin/products_policy/list',
tags=['dashboard_admin/product_policy'],
dependencies=[Depends(JWTBearer())], 
responses=
    { 
        200: {
            "description": "Productos en el sistema",
            "content": { 
                "application/json":{
                    "example":
                        {
                            "message":"Producto de Seguros en el sistema",
                            "data":"{id: 1001,name: 'Póliza Salud Global Benefits - Access',Aseguradora: 'Mercantil Seguros',tipoPoliza: 'Salud',precio: 43,montoCobertura: 'Hasta 100.000 USD',periodoPago: 'Mensual',rating: 5,status: 'Disponible',description: 'Cobertura nacional con acceso a clínicas de la Red Segura.',image: 'salud-access.jpg',} "
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
def list_products_police()->dict:
    db = Session()
    # almacenamos el listado de usarios en un resultset
    result = dashboardAdminController(db).list_products_policy()
    # debemnos convertir los objetos tipo BD a Json
    if (result):
        if (result["result"]=="1"):
            data=result['data']
            return JSONResponse(status_code=200,content={"message":"Productos Encontrados","data":jsonable_encoder(data)})    
        else:
            return JSONResponse(status_code=404,content={"message":"No se han registrado prodcutos en el sistema"})     
    return JSONResponse(status_code=404,content={"message":"No se han registrado productos en el sistema"})   



# Funcion para crear los productos de seguros en el sistema
@admin_dashboarad_router.post ('/dashboard_admin/product_policy/create',
tags=['dashboard_admin/product_policy'],
dependencies=[Depends(JWTBearer())], 
responses=
    { 
        200: {
            "description": "Aseguradoras en el sistema",
            "content": { 
                "application/json":{
                    "example":
                        {
                            "message":"Productos de Seguro creado en el sistema",
                            "data":"{id: 1001,name: 'Póliza Salud Global Benefits - Access',Aseguradora: 'Mercantil Seguros',tipoPoliza: 'Salud',precio: 43,montoCobertura: 'Hasta 100.000 USD',periodoPago: 'Mensual',rating: 5,status: 'Disponible',description: 'Cobertura nacional con acceso a clínicas de la Red Segura.',image: 'salud-access.jpg'}"
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
            "description": "Conflict",
            "content": { 
                "application/json":{ 
                    "example":
                        {
                            "message":"Esta producto de Seguro ya fue registrada",
                            "data":"{id: 1001,name: 'Póliza Salud Global Benefits - Access',Aseguradora: 'Mercantil Seguros',tipoPoliza: 'Salud',precio: 43,montoCobertura: 'Hasta 100.000 USD',periodoPago: 'Mensual',rating: 5,status: 'Disponible',description: 'Cobertura nacional con acceso a clínicas de la Red Segura.',image: 'salud-access.jpg',} "
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
def create_product_policy(productoSeguro : ProductoSeguroSchema, creatorUserId : int = Query (min=1))->dict:
    db = Session()
    # almacenamos el listado de usarios en un resultset
    result = dashboardAdminController(db).create_product_policy(productoSeguro, creatorUserId)
    # debemnos convertir los objetos tipo BD a Json
    if (result):
        if (result["result"]=="1"):
            data=result['data']
            return JSONResponse(status_code=200,content={"message":"Producto de Seguro Insertado","data":jsonable_encoder(data)})    
        elif (result["result"]=="-1"):
            return JSONResponse(status_code=409,content={"message":"Existe un  producto con ese nombre para esa aseguradora, no puede volver a crearlo"})  
        else:
            return JSONResponse(status_code=520,content={"message":f"Ocurrio un error que no pudo ser controlado, error {result['cadenaError']}"})     
    return JSONResponse(status_code=520,content={"message":"Ocurrio un error que no pudo ser controlado"})         



# Funcion para mostrar las empresas aseguradoras en el sistema
@admin_dashboarad_router.get ('/dashboard_admin/product_policy/{id}',
tags=['dashboard_admin/product_policy'],
dependencies=[Depends(JWTBearer())], 
responses=
    { 
        200: {
            "description": "Producto de Seguro encontrado",
            "content": { 
                "application/json":{
                    "example":
                        {
                            "message":"Producto de Seguro encontrado",
                            "data":"{id: 1001,name: 'Póliza Salud Global Benefits - Access',Aseguradora: 'Mercantil Seguros',tipoPoliza: 'Salud',precio: 43,montoCobertura: 'Hasta 100.000 USD',periodoPago: 'Mensual',rating: 5,status: 'Disponible',description: 'Cobertura nacional con acceso a clínicas de la Red Segura.',image: 'salud-access.jpg',} "
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
            "description": "Record Not Found",
            "content": { 
                "application/json":{ 
                    "example":
                        {
                            "message":"No se ha encontrado este producto en el sistema"
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
def get_product_policy(id : int )->dict:
    db = Session()
    # almacenamos el listado de usarios en un resultset
    result = dashboardAdminController(db).get_product_policy(id)
    # debemnos convertir los objetos tipo BD a Json
    if (result):
        if (result["result"]=="1"):
            data=result['data']
            return JSONResponse(status_code=200,content={"message":"Producto de Seguro encontrado","data":jsonable_encoder(data)})    
        elif (result["result"]=="-1"):
            return JSONResponse(status_code=404,content={"message":"No se ha encontrado este Producto de Seguro en el sistema"}) 
        else:
            return JSONResponse(status_code=520,content={"message":result["cadenaError"]})
             
    return JSONResponse(status_code=520,content={"message":"Ocurrió un error que no pudo ser controlado"})  


# Funcion para editar los productos de los seguros en el sistema
@admin_dashboarad_router.put ('/dashboard_admin/product_policy/{id}/update',
tags=['dashboard_admin/product_policy'],
dependencies=[Depends(JWTBearer())], 
responses=
    { 
        200: {
            "description": "Producto Actualizado",
            "content": { 
                "application/json":{
                    "example":
                        {
                            "message":"Prodcuto Actualizado",
                            "data":"{id: 1001,name: 'Póliza Salud Global Benefits - Access',Aseguradora: 'Mercantil Seguros',tipoPoliza: 'Salud',precio: 43,montoCobertura: 'Hasta 100.000 USD',periodoPago: 'Mensual',rating: 5,status: 'Disponible',description: 'Cobertura nacional con acceso a clínicas de la Red Segura.',image: 'salud-access.jpg',} "
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
            "description": "Not found",
            "content": { 
                "application/json":{ 
                    "example":
                        {
                            "message":"Producto no encontrado"
                        }
                    } 
                }       
            },            
        409: {
            "description": "Conflict",
            "content": { 
                "application/json":{ 
                    "example":
                        {
                            "message":"Existe un producto con ese nombre para esa aseguradora, no puede usarlo"
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
def update_products_police(productoSeguro : ProductoSeguroSchema, creatorUserId : int = Query (min=1),id : int = Path (min=1))->dict:
    db = Session()
    # almacenamos el listado de usarios en un resultset
    result = dashboardAdminController(db).update_product_policy(productoSeguro,creatorUserId,id)
    # debemnos convertir los objetos tipo BD a Json
    if (result):
        if (result["result"]=="1"):
            data=result['data']
            return JSONResponse(status_code=200,content={"message":"Productos Actualizado","data":jsonable_encoder(data)})    
        elif (result["result"]=="-1"):
            return JSONResponse(status_code=404,content={"message":"Producto no encontrado"})    
        elif (result["result"]=="-2"):
            return JSONResponse(status_code=409,content={"message":"Existe un producto con ese nombre para esa aseguradora, no puede usarlo"})    
       
        else:
            return JSONResponse(status_code=404,content={"message":"No se han registrado prodcutos en el sistema"})     
    return JSONResponse(status_code=404,content={"message":"No se han registrado productos en el sistema"})  







# Funcion para listar loas afiliados del sistema
'''@dashboard_admin_router.get ('/dashboard_admin/list_affiliates',
tags=['dashboard_admin'],
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
'''@dashboard_admin_router.get ('/dashboard_admin/search_affiliates',
tags=['dashboard_admin'],
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
    result = dashboard_adminController(db).get_status_users()

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
'''@dashboard_admin_router.get ('/dashboard_admin/query_inversions',
tags=['dashboard_admin'],
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
    result = dashboard_adminController(db).report_status_users(fechaInicio, fechaFin, estado)

    # debemnos convertir los objetos tipo BD a Json
    if (result["result"]=="1"):
        data=result["data"]
        return JSONResponse(status_code=200,content={"message":"Data encontrada","data":jsonable_encoder(data)})    
    elif (result["result"]=="-2"):
        return JSONResponse(status_code=404,content={"message":"No hay registros que mostrar"})
'''



    
# Funcion para listar el historico de estados de los usuarios
'''@dashboard_admin_router.get ('/dashboard_admin/query_withdrawal',
tags=['dashboard_admin'],
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
    result = dashboard_adminController(db).reporte_historico_estados_users(fechaInicio, fechaFin, estado)

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
'''@dashboard_admin_router.get ('/dashboard_admin/{id}/withdrawal_details',
tags=['dashboard_admin'],
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
    result = dashboard_adminController(db).reporte_historico_estados_users(fechaInicio, fechaFin, estado)

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
'''@dashboard_admin_router.get ('/dashboard_admin/query_payments',
tags=['dashboard_admin'],
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
    result = dashboard_adminController(db).reporte_historico_estados_users(fechaInicio, fechaFin, estado)

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
'''@dashboard_admin_router.get ('/dashboard_admin/{id}/payments_details',
tags=['dashboard_admin'],
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
    result = dashboard_adminController(db).reporte_historico_estados_users(fechaInicio, fechaFin, estado)

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
@dashboard_admin_router.get ('/dashboard_admin/query_tickets',
tags=['dashboard_admin'],
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
    result = dashboard_adminController(db).reporte_historico_estados_users(fechaInicio, fechaFin, estado)

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
'''@dashboard_admin_router.get ('/dashboard_admin/{id}/tickets_details',
tags=['dashboard_admin'],
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
    result = dashboard_adminController(db).reporte_historico_estados_users(fechaInicio, fechaFin, estado)

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
'''@dashboard_admin_router.get ('/dashboard_admin/list_products',
tags=['dashboard_admin'],
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
    result = dashboard_adminController(db).reporte_historico_estados_users(fechaInicio, fechaFin, estado)

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
'''@dashboard_admin_router.get ('/dashboard_admin/{id}/details_products',
tags=['dashboard_admin'],
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
    result = dashboard_adminController(db).reporte_historico_estados_users(fechaInicio, fechaFin, estado)

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


'''
====================== rutas put ====================================
'''