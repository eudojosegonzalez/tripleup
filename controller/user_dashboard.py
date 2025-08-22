'''
Este archivo contiene las funciones básicas del CRUD del Usuario
Created 2024-06
'''
'''
    **********************************************************************
    * Estructura del Modelo                                              *
    **********************************************************************
    __tablename__="Usuario"
    id = Column(BIGINT, primary_key=True, autoincrement=True)
    rut = Column(VARCHAR(100), nullable=False) #VARCHAR(100) NOT NULL,
    rut_provisorio  = Column(VARCHAR(100), nullable=True) #VARCHAR(100) NULL,
    nombres = Column (VARCHAR(100), nullable=False) #VARCHAR(100) NOT NULL,
    apellido_paterno  = Column (VARCHAR(100), nullable=False) #paterno VARCHAR(100) NOT NULL,
    apellido_materno = Column (VARCHAR(100),nullable=True )  #VARCHAR(100) NULL,
    fecha_nacimiento = Column(DATE, nullable=False) #DATE NOT NULL,
    sexo_id = Column(BIGINT, nullable=False) #BIGINT NOT NULL,
    estado_civil_id = Column(BIGINT, nullable=False) #BIGINT NOT NULL,    
    nacionalidad_id = Column(BIGINT, nullable=False) #BIGINT NOT NULL, 
    username = Column(VARCHAR(250), nullable=False) #varchar(250) NOT NULL,    
    password = Column(VARCHAR(250), nullable=False) #NOT NULL,  
    activo = Column(Boolean, nullable=False) #boolean NOT NULL comment 'campo para activar o no al usuario 0 Inactivo 1 Activo',           
    created = Column (DateTime, nullable=False) #datetime NOT NULL,    
    updated = Column (DateTime, nullable=False)  #datetime NOT NULL,
    creator_user= Column(BIGINT, nullable=False) #user BIGINT NOT NULL,     
    updater_user = Column(BIGINT, nullable=False) #user BIGINT NOT NULL,   

    **********************************************************************
    * Estructura del Schema                                              *
    **********************************************************************
    id : int = Field (ge=1, lt= 2000)
    rut: str = Field (min_length=8, max_length=100)
    rut_provisorio : Optional[str]  = Field (min_length=0, max_length=100)
    nombres : str = Field (min_length=2, max_length=100)
    apellido_paterno :str   = Field (min_length=2, max_length=100)
    apellido_materno : str = Field (min_length=2, max_length=100)
    fecha_nacimiento : date
    sexo_id : int  = Field (ge=1, le= 2)
    estado_civil_id : int  = Field (ge=1, le= 5)
    nacionalidad_id : int   = Field (ge=1, le= 200)
    username : str  = Field (min_length=5, max_length=200)   
    password : str = Field (min_length=8, max_length=200)
    user : int = Field (ge=1, lt= 2000)
'''   
import os
import re
import uuid
import io
import csv
import pdb

import base64
from PIL import Image

import csv

from middleware.error_handler import ErrorHandler

from fastapi import File, UploadFile, Request
from fastapi.staticfiles import StaticFiles
import openpyxl
from controller.validaciones_user import ValidationController


# import all you need from fastapi-pagination
from sqlalchemy import select


from sqlalchemy import or_,and_, text
import datetime
from datetime import timedelta


#Importamos los modeloas necesarios
from models.user import Usuario as UsuarioModel
#rom models.estados_user import EstadosUsuario as EstadosUsuarioModel
#from models.historico_estados_user import HistorioEstadosUsuario as HistorioEstadosUsuarioModel
#from models.view_users_estados import viewUsersEstados as viewUsersEstadosModel
from models.msg import MSG as MSGModel



from schemas.user import User as UserSchema
from schemas.bitacora import Bitacora as BitacoraSchema

from models.bitacora import Bitacora as BitacoraModel

# importamos la utilidad para generar el hash del password
from utils.hasher import hash_password


# esto representa los metodos implementados en la tabla
class dashboardController():
    # metodo constructor que requerira una instancia a la Base de Datos
    def __init__(self,db) -> None:
        self.db = db


    # metodo para consultar todos los  los datos personales del usuario 
    def get_status_users(self):
        paso=1
        try:
            paso=2
            nRecord = self.db.query(viewUsersEstadosModel).count()

            if (nRecord > 0):
                paso=3
                data=self.db.query(viewUsersEstadosModel).order_by(viewUsersEstadosModel.diferencia.desc()).all()

                paso=4
                return ({"result":"1","estado":"data encontrada","data":data})                
            else:
                paso=5
                return ({"result":"-2","estado":"data no encontrada"})  
        
        except ValueError as e:
                return( {"result":"-3","cadenaError": f"Error {str(e)} paso {paso}"})
   
        
    def report_status_users (self, fechaInicio: str, fechaFin:str, estado : int ):
        paso=1
        try:
            # Formato de fecha
            formato_fecha = "%Y-%m-%d"

            # Convertir la cadena de fecha a un objeto datetime
            fechaI = datetime.datetime.strptime(fechaInicio, formato_fecha)            
            fechaF = datetime.datetime.strptime(fechaFin, formato_fecha)  
            paso=2
            # verificamos que existan registros
            if (estado !=0):
                paso=3
                # no se hay estado
                nRecord=self.db.query(viewUsersEstadosModel).filter(and_(viewUsersEstadosModel.created >= fechaI,viewUsersEstadosModel <= fechaF)).count()
                if (nRecord > 0):
                    paso=4
                    # hay registros
                    data=self.db.query(viewUsersEstadosModel).filter(and_(viewUsersEstadosModel.created >= fechaI,viewUsersEstadosModel <= fechaF)).all()

                    paso=4
                    return( {"result":"1","estado": "Registros encontrados","data":data})
                else:
                    # no hay registros que mostrar
                    paso=6
                    return( {"result":"-2","estado": "No hay registros que mostrar"})

            else:
                # se expeficifico un estado en especial  
                paso=7
                nRecord=self.db.query(viewUsersEstadosModel).filter(and_(viewUsersEstadosModel.created >= fechaInicio,
                                                                         viewUsersEstadosModel <= fechaFin, 
                                                                         viewUsersEstadosModel.estado==estado)).count()
                paso=8
                if (nRecord > 0):
                    # hay registros que mostrar 
                    paso=9        
                    data=self.db.query(viewUsersEstadosModel).filter(and_(viewUsersEstadosModel.created >= fechaInicio,
                                                                         viewUsersEstadosModel <= fechaFin, 
                                                                         viewUsersEstadosModel.estado==estado)).all()
                    
                    paso=10
                    return( {"result":"1","estado": "Registros encontrados","data":data})                                                   
                else:
                    # no hay registros que mostrar 
                    paso=11
                    return( {"result":"-2","estado": "No hay registros que mostrar"})
        except ValueError as e:
            return( {"result":"-3","cadenaError": f"Error {str(e)} paso {paso}"})  
        

    # funcion para reportar el historico de estados del usuario
    
    def reporte_historico_estados_users (self, fechaInicio: str, fechaFin:str, estado : str):

        paso=1
        try:
            # Formato de fecha
            formato_fecha = "%Y-%m-%d"
            paso=2
            # Convertir la cadena de fecha a un objeto datetime
            fechaI = datetime.datetime.strptime(fechaInicio, formato_fecha)  
            
            paso=3          
            fechaF = datetime.datetime.strptime(fechaFin, formato_fecha) 
            
            poso=4
            lista=estado.split("_") 
            
            paso=5
            # verificamos que existan registros
            
            paso=6
            # no se especifico un estado
            
            if (len(lista) == 0):
                paso=7
                nRecord=self.db.query(HistorioEstadosUsuarioModel).filter(and_(HistorioEstadosUsuarioModel.created >= fechaI,HistorioEstadosUsuarioModel <= fechaF)).count()
                if (nRecord > 0):
                    paso=8
                    # hay registros
                    data=self.db.query(viewUsersEstadosModel).filter(and_(viewUsersEstadosModel.created >= fechaI,viewUsersEstadosModel <= fechaF)).all()

                    paso=9
                    return( {"result":"1","estado": "Registros encontrados","data":data})
                else:
                    # no hay registros que mostrar
                    paso=20
                    return( {"result":"-2","estado": "No hay registros que mostrar"})
            else:
                # se especifico un estado
                paso=21

                cadena=""
                for row in lista:
                    if (row=="C1"):
                        cadena=cadena+"'1',"
                    elif (row=="C2"):
                        cadena=cadena+"'2',"
                    elif (row=="C3"):
                        cadena=cadena+"'3',"  
                    elif (row=="C4"):
                        cadena=cadena+"'4'," 
                    elif (row=="C5"):
                        cadena=cadena+"'5',"                                                                     
                    elif (row=="C6"):
                        cadena=cadena+"'6',"   
                    elif (row=="C7"):
                        cadena=cadena+"'7',"
                    elif (row=="C8"):
                        cadena=cadena+"'8',"
                    elif (row=="C9"):
                        cadena=cadena+"'9',"                                                                                                                   

                cadena=cadena+",,"
                cadena_final=cadena.rstrip(',')


                sqlSentence=" "
                sqlSentence=f"select count(id) as ttt from HistoricoEstadosUsuario where created>='{fechaI} 00:00' and created<='{fechaF} 23:59' and estado in ({cadena_final})"

                query = text(sqlSentence)
                # data2=self.db.execute(query)
                
                paso=22
                estado2=1
                #nRecord=self.db.query(HistorioEstadosUsuarioModel).filter(and_(HistorioEstadosUsuarioModel.created >= fechaI,or_(HistorioEstadosUsuarioModel.created <= fechaF,HistorioEstadosUsuarioModel.estado==estado2) )).count()
                data=self.db.execute(query)              
                
                data2=data.fetchone()
                nRecord=data2[0]

                if (nRecord > 0):
                    paso=23
                    # hay registros
                    #pdb.set_trace()
                    sqlSentence=f"select * from HistoricoEstadosUsuario where created>='{fechaI} 00:00' and created<='{fechaF} 23:59' and estado in ({cadena_final}) order by user_id,created"
                    query = text(sqlSentence)
                    data=self.db.execute(query)
                    data2=data.fetchall()
                    data3=[]
                    for row in data2:
                        '''
                            id	bigint(20) AI PK
                            estado_id	bigint(20)
                            user_id	bigint(20)
                            nombre	varchar(100)
                            token	varchar(350)
                            estado	int(11)
                            created	datetime
                            updated	datetime
                            delta	time
                        '''    

                        elemento={
                            "id": row.id,
                            "user_id":row.user_id,
                            "nombre":row.nombre,
                            "token":row.token,
                            "estado":row.estado,
                            "created":str(row.created),
                            "updated":str(row.updated),
                            "delta":str(row.delta)
                        }

                        data3.append(elemento)
                        
                        
                        # Field names (adjust based on your element object)
                        fieldnames = data3[0].keys()  # Get field names from the first element

                        # Open CSV file for writing
                        with open('/var/www/html/2callview/assets/reporte.csv', 'w', newline='') as csvfile:
                            writer = csv.DictWriter(csvfile, fieldnames=fieldnames)

                            # Write header row
                            writer.writeheader()

                            # Write data rows
                            for elemento in data3:
                                writer.writerow(elemento)

                        
                    paso=24
                    return( {"result":"1","estado": "Registros encontrados","data":data3,"archivo":"reporte.csv"})
                else:
                    # no hay registros que mostrar
                    paso=25
                    return( {"result":"-2","estado": "No hay registros que mostrar"})                
                
        except ValueError as e:
            return( {"result":"-3","cadenaError": f"Error {str(e)} paso {paso}"}) 
        
                                       
        

    # metodo enviar mensajes a los usuarios
    def send_message_user(self,id,remitente,asunto,texto):
        paso=1
        ahora=datetime.datetime.now()
        try:
            # buscamos al destinatario
            paso=2
            nRecord=self.db.query(UsuarioModel).filter(UsuarioModel.id==id).count()
            if (nRecord>0):
                paso=3
                userExists=self.db.query(UsuarioModel).filter(UsuarioModel.id==id).first()
                
                paso=4    
                nombre=userExists.nombres+" "+userExists.apellidos
                
                paso=5
                newMensaje=MSGModel(
                    remitente=remitente,
                    destinatario=id,
                    nombre=nombre,
                    subject=asunto,
                    msg=texto,
                    fecha_envio=ahora,
                    fecha_recepcion='1990-01-01',
                    estado=0
                )

                paso=6
                self.db.add(newMensaje)

                paso=7
                self.db.commit()

                paso=8
                return( {"result":"1","estado": "mensaje enviado"})                  
            else:    
                return( {"result":"-2","estado": "Usuario no encontrado"})     
        
        except ValueError as e:
            return( {"result":"-3","cadenaError": f"Error {str(e)} paso {paso}"})        
        

    # listamos los usuarios del sistema
    def list_users():
        paso=1
        try:
            paso=2
        except ValueError as e:
            return( {"result":"-3","cadenaError": f"Error {str(e)} paso {paso}"})            
