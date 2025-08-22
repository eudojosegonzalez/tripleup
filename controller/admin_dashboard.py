'''
Este archivo contiene las funciones básicas del CRUD del Usuario
Created 2025-07
'''
'''


'''   
import os
import re
import uuid
import io
import csv
import pdb
import asyncio

import base64
from PIL import Image

import asyncio


import uuid


from middleware.error_handler import ErrorHandler

from fastapi import File, UploadFile, Request
from fastapi.staticfiles import StaticFiles
import openpyxl
from controller.validaciones_user import ValidationController


# import all you need from fastapi-pagination
from sqlalchemy import select,text
from sqlalchemy.sql import literal_column
from sqlalchemy import or_,and_

import datetime
from datetime import timedelta


#Importamos los modeloas necesarios
from models.user import Usuario as UsuarioModel
from models.confirmation_user import ConfirmationUser as ConfirmationUserModel
from models.family_user import FamilyUser as FamilyUserModel
from models.aseguradora import Aseguradora as AseguradoraModel
from models.bitacora import Bitacora as BitacoraModel
from models.producto_seguro import ProductoPoliza as ProductoPolizaModel
from models.datos_personales import DatosPersonales as DatosPersonalesModel


from schemas.user import User as UserSchema
from schemas.bitacora import Bitacora as BitacoraSchema
from schemas.aseguradora import Aseguradora as AseguradoraSchema
from schemas.producto_seguro import ProductoSeguro as ProductoSeguroSchema



# importamos la utilidad para generar el hash del password
from utils.hasher import hash_password
from utils.jwt_managr import create_token
from utils.email_services import sendMail
from utils.uniqueid import generar_codigo_desde_email

from datetime import datetime,timedelta


# esto representa los metodos implementados en la tabla
class dashboardAdminController():
    # metodo constructor que requerira una instancia a la Base de Datos
    def __init__(self,db) -> None:
        self.db = db

    # esta funcion obtiene la ip
    def get_client_ip(request: Request):
        client_ip = request.client.host

        # Handle cases where a proxy server is involved
        if request.headers.get("X-Forwarded-For"):
            forwarded_ips = request.headers.get("X-Forwarded-For").split(",")
            client_ip = forwarded_ips[0].strip()

        return {client_ip}
    

    # esta funcion crea las aseguradoras en el sistema
    def create_insurance(self,aseguradora:AseguradoraSchema, userCreatorId:int):
        paso=1
        #pdb.set_trace()        
        try:
            #obtenemos la fecha/hora del servidor
            ahora=datetime.now()
            paso=2
            '''
            "descripcion":"pperez@gmail.com",
            "logo":"imagen.png",
            "verificado":1,
            "emergencia":"04246007712",
            "soporte":"04246007712",       
            '''

            nombreAseguradora=aseguradora.descripcion.upper().strip()
            paso=3
            logoAseguradora=aseguradora.logo.strip()
            paso=4
            verificadoAseguradora=aseguradora.verificado
            paso=5
            emergenciaAseguradora=aseguradora.emergencia.strip()
            paso=6
            soporteAseguradora=aseguradora.soporte.strip()
            paso=7
            userId=userCreatorId

            # buscamos si existe la aseguradora
            paso=8
            nRecordAseguradora = self.db.query(AseguradoraModel).filter(AseguradoraModel.descripcion == nombreAseguradora).count() 
            
            paso=9
            if (nRecordAseguradora > 0):
                paso=10
                # existe buscamos la aseguradora 
                aseguradoraExists= self.db.query(AseguradoraModel).filter(AseguradoraModel.descripcion == nombreAseguradora).first() 

                # devolvemos el banco que ya existe
                paso=11
                return ({"result":"-1","estado":"Existe una aseguradora con este nombre","data":aseguradoraExists.to_dict()})        
            else:
                paso=12
                #no existe se crea el registro
                '''
                id	bigint(20) AI PK
                descripcion	varchar(150)
                logo	varchar(250)
                verificado	int(11)
                emergencia	text
                soporte	text
                created	datetime
                updated	datetime
                creator_user	bigint(20)
                updater_user	bigint(20)            
                '''
                newAseguradora = AseguradoraModel(
                    descripcion = nombreAseguradora,
                    logo=logoAseguradora,
                    verificado=verificadoAseguradora,
                    emergencia=emergenciaAseguradora,
                    soporte=soporteAseguradora,
                    created=ahora,
                    updated=ahora,
                    creator_user=userId,
                    updater_user=userId
                )

                #confirmamos el cambio en la Base de Datos
                paso=13
                self.db.add(newAseguradora)
                
                paso=14
                self.db.commit()            
                
                paso=15
                return ({"result":"1","estado":"creado","data":newAseguradora.to_dict()})
            
        except ValueError as e:
            return( {"result":"-3","cadenaError": f"Error {str(e)} paso {paso}"}) 
        


    # esta funcion crea las aseguradoras en el sistema
    def get_insurance(self,id:int):
        paso=1
        #pdb.set_trace()        
        try:
            #obtenemos la fecha/hora del servidor
            ahora=datetime.now()
            paso=2
            '''
            "descripcion":"pperez@gmail.com",
            "logo":"imagen.png",
            "verificado":1,
            "emergencia":"04246007712",
            "soporte":"04246007712",       
            '''

            # buscamos si existe la aseguradora
            paso=8
            nRecordAseguradora = self.db.query(AseguradoraModel).filter(AseguradoraModel.id == id).count() 
            
            paso=9
            if (nRecordAseguradora > 0):
                paso=10
                # existe buscamos la aseguradora 
                aseguradoraExists= self.db.query(AseguradoraModel).filter(AseguradoraModel.id == id).first() 

                # devolvemos el banco que ya existe
                paso=11
                return ({"result":"1","estado":"Aseguradora encontrada","data":aseguradoraExists.to_dict()})        
            else:
                paso=15
                return ({"result":"-1","estado":"La Aseguradora no existe"})
            
        except ValueError as e:
            return( {"result":"-3","cadenaError": f"Error {str(e)} paso {paso}"}) 
        

    # esta funcion permite listar las aseguradoras
    def list_insurance (self):
        paso=1
        try:
            paso=2
            nRecord=self.db.query(AseguradoraModel).count()
            if (nRecord > 0):
                paso=2
                result= self.db.query(AseguradoraModel).all()

                paso=3
                arregloSalida= []
                paso=4
                for row in result:
                    paso=5

                    '''
                    id = Column(BIGINT, primary_key=True, autoincrement=True)
                    descripcion = Column(VARCHAR(150), nullable=False) #varchar(250) NOT NULL,    
                    logo = Column(VARCHAR(250), nullable=False) #NOT NULL,  
                    verificado = Column(INTEGER, nullable=False)   
                    emergencia = Column(TEXT, nullable=True)
                    soporte = Column(TEXT, nullable=True)
                    created = Column (DateTime, nullable=False) #datetime NOT NULL,    T
                    updated = Column (DateTime, nullable=False) #datetime NOT NULL,    T
                    creator_user= Column (BIGINT, ForeignKey("usuario.id", ondelete="RESTRICT", onupdate="CASCADE"), nullable=False)  
                    updater_user= Column (BIGINT, ForeignKey("usuario.id", ondelete="RESTRICT", onupdate="CASCADE"), nullable=False)    


                    id: 1,
                    name: 'Mercantil Seguros',
                    status: 'Activa',
                    image: 'mercantil-seguros.png',
                    verified: true,
                    telefonos: {
                    emergencia: ['(+58) 212 5551234', '(+58) 212 5555678'],
                    soporte: ['(+58) 212 5554321', '(+58) 212 5558765'],                                     
                    
                    '''

                    recordTelefonos={
                        "emergencia":[row.emergencia],
                        "soporte":[row.soporte]
                    }

                    nuevo_registro = {
                        "id": row.id,
                        "name": row.descripcion, # Este es un ejemplo, ajústalo a tu lógica real
                        "status": 1,
                        "image":row.logo,
                        "verified":row.verificado,
                        "telefonos":recordTelefonos
                    }

                    paso=27    

                    arregloSalida.append(nuevo_registro)   

                paso=6
                data=arregloSalida

                '''
                
                    nuevo_registro = {
                                "id": row.id,
                                "name": row.descripcion, # Este es un ejemplo, ajústalo a tu lógica real
                                "Aseguradora": row.aseguradora,
                                "tipoPoliza": row.tipo_poliza,
                                "precio": row.precio,
                                "montoCobertura": row.montoCobertura,
                                "periodoPago": row.periodoPago,
                                "rating": row.rating,
                                "status": row.status,
                                "description": row.descripcion,
                                "image": row.imagen,
                                                                    
                            }

                    paso=27    
                    arregloSalida.append(nuevo_registro)                    
                '''

                paso=7
                return ({"result":"1","estado":"Listado de Aseguradoras","data":data })                            
            else:
                paso=5
                return ({"result":"-2","estado":"No se han registrado aseguradoras en el sistema"})                         
        
        except ValueError as e:
            return( {"result":"-3","cadenaError": f"Error {str(e)} paso {paso}"})        
        

    # esta funcion crea las aseguradoras en el sistema
    def update_insurance(self,id : int,aseguradora:AseguradoraSchema, userCreatorId:int):
        paso=1
        #pdb.set_trace()        
        try:
            #obtenemos la fecha/hora del servidor
            ahora=datetime.now()
            paso=2
            '''
            "descripcion":"pperez@gmail.com",
            "logo":"imagen.png",
            "verificado":1,
            "emergencia":"04246007712",
            "soporte":"04246007712",       
            '''

            nombreAseguradora=aseguradora.descripcion.upper().strip()
            paso=3
            logoAseguradora=aseguradora.logo.strip()
            paso=4
            verificadoAseguradora=aseguradora.verificado
            paso=5
            emergenciaAseguradora=aseguradora.emergencia.strip()
            paso=6
            soporteAseguradora=aseguradora.soporte.strip()
            paso=7
            userId=userCreatorId

            # buscamos si existe la aseguradora
            paso=8
            nRecordAseguradora = self.db.query(AseguradoraModel).filter(AseguradoraModel.id == id).count() 
            
            paso=9
            if (nRecordAseguradora > 0):
                # buscamos si existe otra aseguradora con este nombre
                nRecordAseguradora2 = self.db.query(AseguradoraModel).filter(AseguradoraModel.descripcion == nombreAseguradora).count() 

                if (nRecordAseguradora2==0):
                    paso=10
                    # existe buscamos la aseguradora 
                    aseguradoraExists= self.db.query(AseguradoraModel).filter(AseguradoraModel.id == id).first() 


                    # actualizamos loos campos
                    paso=11
                    aseguradoraExists.descripcion = nombreAseguradora,
                    aseguradoraExists.logo=logoAseguradora,
                    aseguradoraExists.verificado=verificadoAseguradora,
                    aseguradoraExists.emergencia=emergenciaAseguradora,
                    aseguradoraExists.soporte=soporteAseguradora,
                    aseguradoraExists.updated=ahora,
                    aseguradoraExists.updater_user=userId

                    paso=12
                    self.db.commit()      

                    # devolvemos el banco que ya existe
                    paso=13
                    return ({"result":"1","estado":"Aseguradora actualizada","data":aseguradoraExists.to_dict()})                        
                else:
                    paso=14
                    return ({"result":"-2","estado":"Existe otra aseguradora con este nombre no puede volver a usarlo",})
            else:
                paso=20
                #no existe se crea el registro
                
                paso=21
                return ({"result":"-1","estado":"Aseguradora no existe",})
            
        except ValueError as e:
            return( {"result":"-3","estado":f"error paso {paso}  {str(e)}"})        
        

    # esta fuincion permite listar los productos de las polizas
    def list_products_policy (self):
        paso=1
        try:
            paso=2

            '''
            Debemos buscar todos los hijos y por cada hijo debemos devolver la siguiente estructura

            {
                id: 1001,
                name: 'Póliza Salud Global Benefits - Access',
                Aseguradora: 'Mercantil Seguros',
                tipoPoliza: 'Salud',
                precio: 43,
                montoCobertura: 'Hasta 100.000 USD',
                periodoPago: 'Mensual',
                rating: 5,
                status: 'Disponible',
                description: 'Cobertura nacional con acceso a clínicas de la Red Segura.',
                image: 'salud-access.jpg',
            }
            
            Consulta view_familiaresview_productos_poliza
            ------------------------------------------------------
            id	bigint(20)
            tipo_poliza	varchar(150)
            precio	decimal(13,4)
            montoCobertura	decimal(18,2)
            periodoPago	varchar(100)
            rating	int(11)
            status	int(11)
            descripcion	text
            imagen	varchar(250)
            aseguradora	varchar(150)  
            '''

            paso=4

            query = select(
                    literal_column("id"),
                    literal_column("tipo_poliza"),
                    literal_column("precio") , # Esto asume que tu vista ya tiene esta columna
                    literal_column("montoCobertura"), # Esto asume que tu vista ya tiene esta columna
                    literal_column("periodoPago"), # Esto asume que tu vista ya tiene esta columna
                    literal_column("rating"), # Esto asume que tu vista ya tiene esta columna
                    literal_column("status"), # Esto asume que tu vista ya tiene esta columna
                    literal_column("descripcion"), # Esto asume que tu vista ya tiene esta columna
                    literal_column("imagen"), # Esto asume que tu vista ya tiene esta columna
                    literal_column("aseguradora"), # Esto asume que tu vista ya tiene esta columna
                ).select_from(text("view_productos_poliza")) # Aquí también usamos text() para la vista
            
            paso=7

            paso=8
            result = self.db.execute(query)

            #pdb.set_trace()
            if (result.rowcount > 0):
                paso=10
                arregloSalida = []

                for row in result:
                    paso=9
                    '''
                    estructura esperada
                    -------------------------------------------------------
                    {
                        id: 1001,
                        name: 'Póliza Salud Global Benefits - Access',
                        Aseguradora: 'Mercantil Seguros',
                        tipoPoliza: 'Salud',
                        precio: 43,
                        montoCobertura: 'Hasta 100.000 USD',
                        periodoPago: 'Mensual',
                        rating: 5,
                        status: 'Disponible',
                        description: 'Cobertura nacional con acceso a clínicas de la Red Segura.',
                        image: 'salud-access.jpg',
                    }                        
                    '''
                    paso=26
                    nuevo_registro = {
                                "id": row.id,
                                "name": row.descripcion, # Este es un ejemplo, ajústalo a tu lógica real
                                "Aseguradora": row.aseguradora,
                                "tipoPoliza": row.tipo_poliza,
                                "precio": row.precio,
                                "montoCobertura": row.montoCobertura,
                                "periodoPago": row.periodoPago,
                                "rating": row.rating,
                                "status": row.status,
                                "description": row.descripcion,
                                "image": row.imagen,
                                                                    
                            }

                    paso=27    
                    arregloSalida.append(nuevo_registro)                        
                
                # Si quieres los resultados como diccionarios
                # Si quieres los resultados como diccionarios
                # recordFamily = [dict(row) for row in result.mappings()]           

                paso=28
                return ({"result":"1","estado":"Productos Encontrados","data":arregloSalida})                       

            else:
                paso=500
                return ({"result":"-4","estado":"No se han definido prodcutos en e sistema"})
        
        except ValueError as e:
            return( {"result":"-1","cadenaError": f"Error {str(e)} paso {paso}"})         
                


   # esta fuincion permite consultar un productos de seguro en el sistema
    def get_product_policy (self,id):
        paso=1
        try:
            paso=2

            '''
            Debemos buscar todos los hijos y por cada hijo debemos devolver la siguiente estructura

            {
                id: 1001,
                name: 'Póliza Salud Global Benefits - Access',
                Aseguradora: 'Mercantil Seguros',
                tipoPoliza: 'Salud',
                precio: 43,
                montoCobertura: 'Hasta 100.000 USD',
                periodoPago: 'Mensual',
                rating: 5,
                status: 'Disponible',
                description: 'Cobertura nacional con acceso a clínicas de la Red Segura.',
                image: 'salud-access.jpg',
            }
            
            Consulta view_familiaresview_productos_poliza
            ------------------------------------------------------
            id	bigint(20)
            tipo_poliza	varchar(150)
            precio	decimal(13,4)
            montoCobertura	decimal(18,2)
            periodoPago	varchar(100)
            rating	int(11)
            status	int(11)
            descripcion	text
            imagen	varchar(250)
            aseguradora	varchar(150)  
            '''

            paso=4

            query = select(
                    literal_column("id"),
                    literal_column("tipo_poliza"),
                    literal_column("precio") , # Esto asume que tu vista ya tiene esta columna
                    literal_column("montoCobertura"), # Esto asume que tu vista ya tiene esta columna
                    literal_column("periodoPago"), # Esto asume que tu vista ya tiene esta columna
                    literal_column("rating"), # Esto asume que tu vista ya tiene esta columna
                    literal_column("status"), # Esto asume que tu vista ya tiene esta columna
                    literal_column("descripcion"), # Esto asume que tu vista ya tiene esta columna
                    literal_column("imagen"), # Esto asume que tu vista ya tiene esta columna
                    literal_column("aseguradora"), # Esto asume que tu vista ya tiene esta columna
                ).select_from(text("view_productos_poliza")) # Aquí también usamos text() para la vista
            
            paso=7

            paso=8
            result = self.db.execute(query)

            #pdb.set_trace()
            if (result.rowcount > 0):
                paso=10
                arregloSalida = []

                for row in result:
                    paso=9
                    '''
                    estructura esperada
                    -------------------------------------------------------
                    {
                        id: 1001,
                        name: 'Póliza Salud Global Benefits - Access',
                        Aseguradora: 'Mercantil Seguros',
                        tipoPoliza: 'Salud',
                        precio: 43,
                        montoCobertura: 'Hasta 100.000 USD',
                        periodoPago: 'Mensual',
                        rating: 5,
                        status: 'Disponible',
                        description: 'Cobertura nacional con acceso a clínicas de la Red Segura.',
                        image: 'salud-access.jpg',
                    }                        
                    '''
                    paso=26
                    nuevo_registro = {
                                "id": row.id,
                                "name": row.descripcion, # Este es un ejemplo, ajústalo a tu lógica real
                                "Aseguradora": row.aseguradora,
                                "tipoPoliza": row.tipo_poliza,
                                "precio": row.precio,
                                "montoCobertura": row.montoCobertura,
                                "periodoPago": row.periodoPago,
                                "rating": row.rating,
                                "status": row.status,
                                "description": row.descripcion,
                                "image": row.imagen,
                                                                    
                            }

                    paso=27    
                    arregloSalida.append(nuevo_registro)                        
                
                # Si quieres los resultados como diccionarios
                # Si quieres los resultados como diccionarios
                # recordFamily = [dict(row) for row in result.mappings()]           

                paso=28
                return ({"result":"1","estado":"Productos Encontrados","data":arregloSalida})                       

            else:
                paso=500
                return ({"result":"-4","estado":"No se han definido prodcutos en e sistema"})
        
        except ValueError as e:
            return( {"result":"-1","cadenaError": f"Error {str(e)} paso {paso}"})  
        


    # esta funcion crea las aseguradoras en el sistema
    def create_product_policy(self,productoSeguro : ProductoSeguroSchema , userCreatorId:int):
        paso=1
        #pdb.set_trace()        
        try:
            #obtenemos la fecha/hora del servidor
            ahora=datetime.now()
            paso=2
            '''
                "nombre" : "Producto ABC",
                "aseguradora_id" : 1,
                "tipo_poliza" : "Seguro de Salud",
                "monto_cobertura" : 20000.00,
                "periodo_pago" : "Mensual",
                "rating" : 5,
                "costo" : 250.00,
                "precio" : 25.00,
                "cuotas" : 35.00,
                "estado" : 2,
                "descripcion" : "Esto es un producto de prueba",
                "plazo_espera" : "Esto son plazos de espera de prueba",
                "imagen" : ""     
            '''

            nombreProducto = productoSeguro.nombre.upper().strip()
            aseguradoraId=productoSeguro.aseguradora_id
            tipoPoliza=productoSeguro.tipo_poliza
            montoCoberturaProducto=productoSeguro.monto_cobertura
            periodoPagoProducto=productoSeguro.periodo_pago
            ratingProducto=productoSeguro.rating
            costoProducto=productoSeguro.costo
            precioProducto=productoSeguro.precio
            cuotaProducto=productoSeguro.cuotas
            estadoProdcuto=productoSeguro.estado
            descripcionProducto=productoSeguro.descripcion
            plazoEsperaProducto=productoSeguro.plazo_espera
            imagenProducto=productoSeguro.imagen

            paso=7
            userId=userCreatorId

            # buscamos si existe el producto
            paso=8
            nRecordProducto = self.db.query(ProductoPolizaModel).filter(ProductoPolizaModel.nombre==nombreProducto).filter(ProductoPolizaModel.aseguradora_id==aseguradoraId).count() 
            
            paso=9
            if (nRecordProducto > 0):
                paso=10
                # existe buscamos la aseguradora 
                productPolicyExists= self.db.query(ProductoPolizaModel).filter(ProductoPolizaModel.nombre==nombreProducto).filter(ProductoPolizaModel.aseguradora_id==aseguradoraId).first()

                # devolvemos el producto ya existe
                paso=11
                return ({"result":"-1","estado":"Existe un producto de seguros con este nombre","data":productPolicyExists.to_dict()})        
            else:
                paso=12
                #no existe se crea el registro
                '''
                id	bigint(20) AI PK
                nombre	varchar(150)
                aseguradora_id	bigint(20)
                tipo_poliza	varchar(150)
                montoCobertura	decimal(18,2)
                periodoPago	varchar(100)
                rating	int(11)
                costo	decimal(13,4)
                precio	decimal(13,4)
                cuotas	decimal(13,4)
                estado	int(11)
                descripcion	text
                plazo_espera	varchar(250)
                imagen	varchar(250)
                created	datetime
                updated	datetime
                creator_user	bigint(20)
                updater_user	bigint(20)         
                '''
                newProductPolicy = ProductoPolizaModel(
                    nombre=nombreProducto,
                    aseguradora_id=aseguradoraId,
                    tipo_poliza=tipoPoliza,
                    montoCobertura=montoCoberturaProducto,
                    periodoPago=periodoPagoProducto,
                    rating=ratingProducto,
                    costo=costoProducto,
                    precio=precioProducto,
                    cuotas=cuotaProducto,
                    estado=estadoProdcuto,
                    descripcion=descripcionProducto,
                    plazo_espera=plazoEsperaProducto,
                    imagen=imagenProducto,
                    created=ahora,
                    updated=ahora,
                    creator_user=userId,
                    updater_user=userId
                )

                #confirmamos el cambio en la Base de Datos
                paso=13
                self.db.add(newProductPolicy)
                
                paso=14
                self.db.commit()            
                
                paso=15
                return ({"result":"1","estado":"creado","data":newProductPolicy.to_dict()})
            
        except ValueError as e:
            return( {"result":"-3","cadenaError": f"Error {str(e)} paso {paso}"})         
        

   # esta funcion actualiza las los productos de seguro
    def update_product_policy(self,productoSeguro : ProductoSeguroSchema , userCreatorId:int, id:int):
        paso=1
        #pdb.set_trace()        
        try:
            #obtenemos la fecha/hora del servidor
            ahora=datetime.now()
            paso=2
            '''
                "nombre" : "Producto ABC",
                "aseguradora_id" : 1,
                "tipo_poliza" : "Seguro de Salud",
                "monto_cobertura" : 20000.00,
                "periodo_pago" : "Mensual",
                "rating" : 5,
                "costo" : 250.00,
                "precio" : 25.00,
                "cuotas" : 35.00,
                "estado" : 2,
                "descripcion" : "Esto es un producto de prueba",
                "plazo_espera" : "Esto son plazos de espera de prueba",
                "imagen" : ""     
            '''

            nombreProducto = productoSeguro.nombre.upper().strip()
            aseguradoraId=productoSeguro.aseguradora_id
            tipoPoliza=productoSeguro.tipo_poliza
            montoCoberturaProducto=productoSeguro.monto_cobertura
            periodoPagoProducto=productoSeguro.periodo_pago
            ratingProducto=productoSeguro.rating
            costoProducto=productoSeguro.costo
            precioProducto=productoSeguro.precio
            cuotaProducto=productoSeguro.cuotas
            estadoProdcuto=productoSeguro.estado
            descripcionProducto=productoSeguro.descripcion
            plazoEsperaProducto=productoSeguro.plazo_espera
            imagenProducto=productoSeguro.imagen

            paso=7
            userId=userCreatorId

            # buscamos si existe el producto
            paso=8
            nRecordProducto = self.db.query(ProductoPolizaModel).filter(ProductoPolizaModel.id==id).count() 
            
            paso=9
            if (nRecordProducto > 0):
                paso=10
                # existe, buscamos si existe un producto semenjante para la aseguradora 
                nProductPolicyExists= self.db.query(ProductoPolizaModel).filter(ProductoPolizaModel.nombre==nombreProducto).filter(ProductoPolizaModel.aseguradora_id==aseguradoraId).count()

                if (nProductPolicyExists > 0):
                    # existe un producto con el mismo nombre para esa aseguradora no podemos suar ese nombre
                    paso=15
                    return ({"result":"-2","estado":"Existe un producto con ese nombre para esa aseguradora, no puede usarlo"})
                else:
                    # actualizamos el registro
                    paso=11
                    recordProduct= self.db.query(ProductoPolizaModel).filter(ProductoPolizaModel.id== id).first() 

                    recordProduct.nombre=nombreProducto
                    recordProduct.aseguradora_id=aseguradoraId
                    recordProduct.tipo_poliza=tipoPoliza
                    recordProduct.montoCobertura=montoCoberturaProducto
                    recordProduct.periodoPago=periodoPagoProducto
                    recordProduct.rating=ratingProducto
                    recordProduct.costo=costoProducto
                    recordProduct.precio=precioProducto
                    recordProduct.cuotas=cuotaProducto
                    recordProduct.estado=estadoProdcuto
                    recordProduct.descripcion=descripcionProducto
                    recordProduct.plazo_espera=plazoEsperaProducto
                    recordProduct.imagen=imagenProducto
                    recordProduct.updated=ahora
                    recordProduct.updater_user=userId

                    paso=14
                    self.db.commit()                     

                    return ({"result":"1","estado":"Procuto actualizado","data":recordProduct.to_dict()})        
            else:
                paso=15
                return ({"result":"-1","estado":"Producto no encontrado"})
            
        except ValueError as e:
            return( {"result":"-3","cadenaError": f"Error {str(e)} paso {paso}"})    