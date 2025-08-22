'''
Este archivo contiene las funciones básicas del CRUD del Usuario
Created 2024-06
'''
'''
    **********************************************************************
    * Estructura del Modelo                                              *
    **********************************************************************
    __tablename__="usuario"
    id = Column(BIGINT, primary_key=True, autoincrement=True)
    username = Column(VARCHAR(250), nullable=False) #varchar(250) NOT NULL,    
    password = Column(VARCHAR(250), nullable=False) #NOT NULL,  
    estado = Column(INTEGER, nullable=False)
    confirmado = Column(INTEGER, nullable=False)   
    id_nivel =  Column(INTEGER, nullable=False) #BIGINT NOT NULL,     
    codigo = Column(VARCHAR(150), nullable=False)
    created = Column (DateTime, nullable=False) #datetime NOT NULL,    
    updated = Column (DateTime, nullable=False)  #datetime NOT NULL,
    creator_user= Column(BIGINT, nullable=False) #user BIGINT NOT NULL,     
    updater_user = Column(BIGINT, nullable=False) #user BIGINT NOT NULL,  

    **********************************************************************
    * Estructura del Schema                                              *
    **********************************************************************
    username : str  = Field (min_length=5, max_length=150)   
    password : str = Field (min_length=8, max_length=150)
    estado : int  
    confirmado : int      
    id_nivel : int  
    codigo : str = Field (min_length=8, max_length=150)

    model_config = {
        "json_schema_extra": {
            "examples": [
                {
                    "username":"pperez",
                    "password":"12345678",
                    "estado":1,
                    "conformado":0,
                    "id_nivel":1,
                    "codigo":"ABCDEFGHI",
                }
            ]
        }
    }    

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
from models.datos_personales import DatosPersonales as DatosPersonalesModel
from models.estado import Estado as EstadosModel
from models.municipio import Municipio as MunicipiosModel
from models.vista_datos_ubicacion import VistaDatosUbicacion as VistaDatosUbicacionModel
from models.datos_ubicacion import DatosUbicacion as DatosUbicacionModel



from schemas.user import User as UserSchema
from schemas.bitacora import Bitacora as BitacoraSchema
from schemas.datos_personales import DatosPersonales as DatosPersonalesSchema
from schemas.all_data_user import AllDataUser as AllDataUserSchema


from models.bitacora import Bitacora as BitacoraModel

# importamos la utilidad para generar el hash del password
from utils.hasher import hash_password
from utils.jwt_managr import create_token
from utils.email_services import sendMail
from utils.uniqueid import generar_codigo_desde_email

from datetime import datetime,timedelta




# esto representa los metodos implementados en la tabla
class userController():
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



    #metodo para insertar  los datos personales del usuario   
    # @params usuario: esquema de los datos del usuario que se desea insertar       
    def create_user(self,request:Request, usuario:UserSchema):
        #validaciones de los datos 
        emailOk=False
        emailOk=ValidationController.validarEmail(usuario.username)
        
        #validamos que los datos primarios esten validados
        paso=4
        if (emailOk ):

            #obtenemos la fecha/hora del servidor
            ahora=datetime.now()
            
            # contamos si existe un username identico en la base de datos
            userName=usuario.username

            paso=5
            nRecordUserName = self.db.query(UsuarioModel).filter(UsuarioModel.username == userName).count()  

            # verificamos que el username este disponible
            if (nRecordUserName > 0):
                # el username esta ocupado
                paso=8
                userExistsUserName = self.db.query(UsuarioModel).filter(UsuarioModel.username == userName).first()  
                return ({"result":"-2","estado":"Username ya existe, no puede volver a crearlo","userId": userExistsUserName.id,"userName":userExistsUserName.username })

            # verificamos que el codigo de referido exista
            if (len(usuario.codigo) != 0):
                nRecordUserCodigo = self.db.query(UsuarioModel).filter(UsuarioModel.codigo == usuario.codigo).count() 
                if (nRecordUserCodigo==0):
                    # no existe este codigo de referido devolvemos error
                    return ({"result":"-5","estado":"Código de referido no existe" })
                

            # no existe el usuario, procedemos a insertar el registro
            '''
            `id` bigint NOT NULL AUTO_INCREMENT,
            `username` varchar(150) NULL comment 'email del usuario',
            `password` varchar(150) NULL,
            `estado` int NOT NULL default '1' comment '0 inactivo 1 activo',
            `confirmado` int NOT NULL default '0' comment '0 no confirmado 1 confirmado',
            `id_nivel` bigint NOT NULL default '1' comment '1 usuario, 30 operador, 50 vendedor, 99 Administrador' ,
            `codigo` varchar(150) NOT NULL comment 'esta ees el codigo que se comparte con el afiliado',    
            `created` datetime NOT NULL,
            `updated` datetime NULL,
            `confirmated` datetime NULL,             
            '''

            # generar el codigo 
            codigoUnico=generar_codigo_desde_email(usuario.username)

            try:
                paso=10
                newUser=UsuarioModel(
                    username=usuario.username,
                    password=hash_password(usuario.password),
                    estado=1,
                    confirmado=0,
                    id_nivel=1,
                    codigo=codigoUnico,
                    created=ahora
                )
                paso=2
                self.db.add(newUser)
                paso=3
                self.db.commit()
                
                paso=4
                data=newUser.to_dict()

                # creamos el historico 
                '''
                id = Column(BIGINT, primary_key=True, autoincrement=True)
                user_id = Column(BIGINT,  ForeignKey("Usuario.id", ondelete="RESTRICT", onupdate="CASCADE"), nullable=False)
                observaciones = Column (TEXT, nullable=False)
                created=Column(DATETIME, nullable=False)        
                '''


                paso=5

                newBitacora=BitacoraModel (
                    user_id=newUser.id,
                    observaciones=f"Creacion de usuario nuevo en el sistema Nuevo Id de usuario:{newUser.id}, Nombre del nuevo usuario: {usuario.username} codigo asignado={usuario.codigo}",
                    created=ahora,
                )

                paso=6
                self.db.add(newBitacora)
                paso=7
                self.db.commit()                

                paso=8
                data=newUser.to_dict()

                paso=9
                #obtenemos la IP desde la cual se hace la solicitud
                #determinamos la ip del cliente
                client_ip = request.client.host

                # Handle cases where a proxy server is involved
                paso=10
                if request.headers.get("X-Forwarded-For"):
                    forwarded_ips = request.headers.get("X-Forwarded-For").split(",")
                    client_ip = forwarded_ips[0].strip()



                # obtenemos el uuid
                paso=11
                confirmation_uuid = str(uuid.uuid4())



                # datos para crear el token
                paso=16
                userDict={"username":usuario.username,"generated":ahora.timestamp(),"client_ip":client_ip,"identificador":confirmation_uuid}  
                paso=17                
                tokenEmail=create_token(userDict)
                paso=18
                enlaceConfirmacion=f"https://tripleup.net/validate-registration/{tokenEmail}"
                paso=19
                # creamos el cuerpo del mensaje
                cuerpo = f"""
                    <html>
                    <head>
                    </head>
                    <body>
                    <p>¡Hola ! </p>
                        <p>¡Estamos emocionados de darte la bienvenida a *TripleUP*! Tu registro como afiliado está casi listo, solo falta un paso para activar tu cuenta y comenzar a disfrutar de todos los beneficios.  </p>

                        <p>*📍 Activa tu cuenta ahora mismo:*  </p>
                        <p>Haz clic en el botón below para confirmar tu correo electrónico y acceder a tu panel de afiliado: </p> 

                        <p aling='center'><a href='{enlaceConfirmacion}' style='display: inline-block; padding: 10px 20px; background-color: #007bff; color: white; text-decoration: none; border-radius: 5px; border: none; cursor: pointer; font-size: 16px;font-family: Arial, sans-serif; transition: background-color 0.3s ease;'>Activar mi cuenta</a></p>

                        <p>*¿Qué pasa después?*  </p>
                        <p>✅ Accederás a tu *panel de afiliado* con herramientas exclusivas.  </p>
                        <p>✅ Obtendrás tu *enlace de referido único* y materiales promocionales.  </p>
                        <p>✅ Podrás empezar a generar ingresos recomendando TripleUP.  </p>

                        <p>*¿Problemas con el botón?*  </p>
                        <p>Copia y pega este enlace en tu navegador:  </p>
                        <p>{enlaceConfirmacion}</p>

                        <p>*¿Preguntas?*  </p>
                        <p>Estamos aquí para ayudarte. Contáctanos en *soporte@tripleup.com* o responde a este correo.  </p>

                        <p>¡Gracias por unirte a la familia TripleUP! 🚀  </p>

                        <p>Con entusiasmo,  <p>
                        <p>*El equipo de TripleUP*  <p>
                        <p>[www.tripleup.com](https://tripleup.net) | [Instagram](https://instagram.com/tripleupve) | [Tiktok](https://www.tiktok.com/@tripleupv) 
                    </body>
                    </html>
                    """
                
                ''' 
                usuario info@tripleup.net
                clave D6ny5vebEGvbscdzdAp4
                servidores  smtp eagle.mxlogin.com
                puerto 465

                IMAP Server: eagle.mxlogin.com
                SMTP Server: eagle.mxlogin.com

                PORTS:
                IMAP SSL: 993
                IMAP Non-SSL: 143
                POP3 SSL: 995
                POP3 Non-SSL: 110
                SMTP SSL: 465
                SMTP Non-SSL/STARTTLS: 25, 587      

                id = Column(BIGINT, primary_key=True, autoincrement=True)
                username = Column(VARCHAR(250), nullable=False) #varchar(250) NOT NULL,
                body = Column (TEXT, nullable=False)
                identificador  = Column(VARCHAR(150), nullable=False) #varchar(250) NOT NULL,
                confirmado = Column(INTEGER, nullable=False)   
                created = Column (DateTime, nullable=False) #datetime NOT NULL,    
                confirmated  = Column (DateTime, nullable=False)  #datetime NOT NULL,                          
                  
                '''
                # insertamos el registro en la tabla de confoirmaciones
                paso=20
                newConfirmationUserModel = ConfirmationUserModel(
                    username=usuario.username,
                    body=cuerpo,
                    identificador=confirmation_uuid,
                    confirmado=0,
                    created=ahora,
                    confirmated='1990-01-01'
                )

                paso=21
                self.db.add(newConfirmationUserModel)
                paso=22
                self.db.commit()                  


                # si tiene codigo de referido intentamos crear la relacion padre-hijo-nieto
                if (len(usuario.codigo) !=0):
                    # creamos la asociacion con el padre, esta referido por usuario.codigo
                    # buscamos el id del padre por el codigo
                    paso=23
                    nRecordUser = self.db.query(UsuarioModel).filter(UsuarioModel.codigo==usuario.codigo).count()

                    paso=24
                    if (nRecordUser>0):            
                        paso=25    
                        # encontrado   
                        usuarioRecord=self.db.query(UsuarioModel).filter(UsuarioModel.codigo==usuario.codigo).first()
                        # determinamos el id del usuario padre

                        paso=26
                        idUser=usuarioRecord.id
                        # buscamos en la familia si existe
                        '''
                        `id` bigint NOT NULL AUTO_INCREMENT,
                        `user_id` bigint NOT NULL comment 'usuario ascendente',    
                        `codigo_ascendente` varchar(150) NULL comment 'codigo de quien refiere (padre)' ,
                        `familiar_id` bigint NOT NULL comment 'id del usuario referido, hijo o nieto',	
                        `codigo_descendente` varchar(150) NULL comment 'codigo de quien refiere (padre)' ,    
                        `tipo` int NULL comment '1 Hijo 2 Nieto' ,
                        `created` datetime NOT NULL,
                        `updated` datetime NOT NULL,
                        PRIMARY KEY (`id`),
                        unique (`user_id`,`codigo_ascendente`,`familiar_id`,`codigo_descendente`),
                        constraint `fk_user_familia_afiliado` foreign key (`user_id`) references `usuario`(`id`) 
                        on update cascade on delete restrict                     
                        '''
                        paso=27
                        nRecordFamilyUser = self.db.query(FamilyUserModel).\
                        filter(FamilyUserModel.user_id==idUser).\
                        filter(FamilyUserModel.codigo_ascendente==usuario.codigo).\
                        filter(FamilyUserModel.familiar_id==newUser.id).\
                        filter(FamilyUserModel.codigo_descendente==codigoUnico).count()
                        
                        paso=28
                        if (nRecordFamilyUser == 0):
                            paso=29
                            # No existe se agrega el hijo al padre
                            newRecordFamilyUser = FamilyUserModel (
                                user_id=idUser,
                                codigo_ascendente=usuario.codigo,
                                familiar_id=newUser.id,
                                codigo_descendente=codigoUnico,
                                tipo=1,
                                created=ahora,
                                updated="1990-01-01"
                            )


                            paso=30
                            self.db.add(newRecordFamilyUser)
                            paso=31
                            self.db.commit()  

                            # buscamos si este padre tiene a su vez otro padre, para anexarle el recien inscrito como nieto
                            nRecordFamilyUserAbuelo = self.db.query(FamilyUserModel).\
                            filter(FamilyUserModel.codigo_descendente==usuario.codigo).\
                            filter(FamilyUserModel.tipo==1).count()  

                            if (nRecordFamilyUserAbuelo > 0):
                                # existe, determinamos el codigo_ascendente
                                RecordFamilyUserAbuelo=self.db.query(FamilyUserModel).\
                                filter(FamilyUserModel.codigo_descendente==usuario.codigo).\
                                filter(FamilyUserModel.tipo==1).first() 

                                codigoAscendenteAbuelo=RecordFamilyUserAbuelo.codigo_ascendente
                                idAscendenteAbuelo=RecordFamilyUserAbuelo.user_id

                                # insertamos el registro del abuelo
                                newRecordFamilyUserAbuelo = FamilyUserModel (
                                    user_id=idUser,
                                    codigo_ascendente=codigoAscendenteAbuelo,
                                    familiar_id=idAscendenteAbuelo,
                                    codigo_descendente=codigoUnico,
                                    tipo=2,
                                    created=ahora,
                                    updated="1990-01-01"
                                )


                                paso=30
                                self.db.add(newRecordFamilyUserAbuelo)
                                paso=31
                                self.db.commit()  

                        else:
                            # existe no se puede agregar de nuevo
                            # no encontrado
                            return( {"result":"-4","estado": "Usuario creado, no se pudo enlazar a su familia"})                        
                    else:
                        # no tiene padre es un vendor o un ente juridico
                        a=a+1
                else:    
                    # no encontrado
                    return( {"result":"1","estado": "Usuario creado como vendedor o ente juridico sin familia"})

                #enviamos el mail
                resultadoMail= sendMail(cuerpo,usuario.username)

                if (resultadoMail["result"]=="1"):
                    return( {"result":"1","mensaje":"Se creao al usuario, se envió un email de confirmación"}) 
                else:
                    return( {"result":"-3","estado": "Usuario creado, no se pudo enviar el correo de confirmación", "paso":{resultadoMail["paso"]}})
            
            except ValueError as e:
                return( {"result":"-3","estado": "Usuario creado, no se pudo enviar el correo de confirmación"})
        
        else:
            cadenaError="Existen errores de formato en los datos:"
            if (not emailOk):
                cadenaError=cadenaError + " El email está mal formateado"                 
            return( {"result":"-4","cadenaError":cadenaError}) 
        

    # este metodo genera el link de compartir
    def share_code(self,request:Request,userid : int):
        paso=1
        # buscamos el id del usuario
        try:
            paso=2
            nRecordUserName = self.db.query(UsuarioModel).filter(UsuarioModel.id == userid).count()
            if (nRecordUserName > 0):
                paso=3
                #extraemos el codigo
                RecordUser = self.db.query(UsuarioModel).filter(UsuarioModel.id == userid).first()
                return({"result":"1","codigo":RecordUser.codigo}) 
            else:
                paso=4
                return( {"result":"-1","estado": "Este usuario no existe"})
        except ValueError as e:
            return( {"result":"-3","estado": "Ocurrio un error que no pudo ser controlado","paso":paso})
        

    # este metodo genera el link de compartir
    def validate_email(self,request:Request,email : str,identificador:str):
        paso=1
        #obtenemos la fecha/hora del servidor
        ahora=datetime.now()
        
        # buscamos el id del usuario
        try:
            paso=2
            nRecordUser = self.db.query(ConfirmationUserModel)\
            .filter(ConfirmationUserModel.username==email)\
            .filter(ConfirmationUserModel.identificador==identificador).count()
            if (nRecordUser > 0):
                paso=3
                # buscamos el registro para actualizarlo
                recordUser = self.db.query(ConfirmationUserModel)\
                .filter(ConfirmationUserModel.username==email)\
                .filter(ConfirmationUserModel.identificador==identificador).first()

                # no esta confirmado
                paso=4
                if (recordUser.confirmado==0):
                    paso=5
                    # actualizamos el estado en la tabla conmfirmation_user
                    recordUser.confirmado=1
                    paso=6
                    recordUser.confirmated=ahora
                    paso=7
                    self.db.commit()

                    # actualizamos el estado en la tabla usuario
                    paso=8
                    recordUser2=self.db.query(UsuarioModel).filter(UsuarioModel.username==email).first()
                    paso=9
                    recordUser2.confirmado=1
                    paso=10
                    recordUser2.updated=ahora
                    paso=11
                    recordUser2.confirmated=ahora
                    paso=12
                    self.db.commit()

                    # esta conformacio
                    return( {"result":"1","estado": "Usuario confirmado"})
                else:
                    # esta conformacio
                    pas=8
                    return( {"result":"-2","estado": "Este usuario ya está confirmado"})
            else:
                paso=9
                return( {"result":"-1","estado": "Este usuario no existe"})
        except ValueError as e:
            return( {"result":"-3","estado": f"Ocurrio un error que no pudo ser controlado paso:{paso}"})       

    # metodo para consultar todos los  los datos personales del usuario 
    def list_users(self):
        result = self.db.query(UsuarioModel).all()
        return (result)
    

    # metodo para consultar por Id al usuario
    # @params userId: id del Usuario que se desea consultar
    def get_user(self, userId):
        paso=1
        try:
            paso=2
            nRecord=self.db.query(UsuarioModel).filter(UsuarioModel.id==userId).count()
            if (nRecord > 0):
                paso=3

                # buscamos el correo del suaurio
                recordUser=self.db.query(UsuarioModel).filter(UsuarioModel.id==userId).first()

                # consulta los datos personales
                paso=4
                nRecordDatosPersonales=self.db.query(DatosPersonalesModel).filter(DatosPersonalesModel.user_id==userId).count()

                paso=5
                namePersonales="N/C"
                if (nRecordDatosPersonales >0):
                    paso=6
                    RecordDatosPersonales=self.db.query(DatosPersonalesModel).filter(DatosPersonalesModel.user_id==userId).first()
                    namePersonales=(RecordDatosPersonales.nombres).strip()+" "+(RecordDatosPersonales.apellidos).strip()

                # consultar los familiares directos
                paso=7
                nRecorFamiliaresDirectos=self.db.query(FamilyUserModel).filter(FamilyUserModel.user_id==userId).filter(FamilyUserModel.tipo==1).count()

                # consultar los familiares indirectosdirectos
                paso=8
                nRecorFamiliaresIndirectos=self.db.query(FamilyUserModel).filter(FamilyUserModel.user_id==userId).filter(FamilyUserModel.tipo==2).count()


                # consultar las ganancias
                ganancias=0.00

                if (recordUser.estado==1):
                    paso=10
                    estadoUser="Activo"
                else:
                    paso=11
                    estadoUser="Inactivo"

                # imagen
                paso=12
                imagen="https://randomuser.me/api/portraits/women/68.jpg"

                data={
                    "name":namePersonales,
                    "email":recordUser.username,
                    "avatar":imagen,
                    "registered":recordUser.created,
                    "estatus":estadoUser,
                    "directReferrals": nRecorFamiliaresDirectos,
                    "indirectReferrals": nRecorFamiliaresIndirectos,
                    "earnings": ganancias,
                    "referralCode": recordUser.codigo,
                }

                paso=13
                return ({"result":"1","estado":"Usuario encontrado","data":data })                            
            else:
                paso=14
                return ({"result":"-2","estado":"Usuario no encontrado"})                         
        except ValueError as e:
            return( {"result":"-1","cadenaError": f"Error {str(e)} paso {paso}"})
        


   # metodo para consultar por Id del usuario losd atos personales
    # @params userId: id del Usuario que se desea consultar
    def get_personal_data_user(self, userId):
        paso=1
        try:
            paso=2
            nRecord=self.db.query(DatosPersonalesModel).filter(DatosPersonalesModel.user_id==userId).count()
            if (nRecord > 0):
                paso=3

                # buscamos el correo del suaurio
                recordUser=self.db.query(DatosPersonalesModel).filter(DatosPersonalesModel.user_id==userId).first()

                data=recordUser.to_dict()

                paso=13
                return ({"result":"1","estado":"Usuario encontrado","data":data })                            
            else:
                paso=14
                return ({"result":"-2","estado":"Usuario no encontrado"})                         
        except ValueError as e:
            return( {"result":"-1","cadenaError": f"Error {str(e)} paso {paso}"})



    # metodo para consultar por Id del usuario losd atos personales
    # @params userId: id del Usuario que se desea consultar
    def get_personal_address(self, userId):
        paso=1
        try:
            paso=2
            nRecord=self.db.query(VistaDatosUbicacionModel).filter(VistaDatosUbicacionModel.user_id==userId).count()
            if (nRecord > 0):
                paso=3

                # buscamos el correo del suaurio
                recordUser=self.db.query(DatosPersonalesModel).filter(DatosPersonalesModel.user_id==userId).first()

                data=recordUser.to_dict()

                paso=13
                return ({"result":"1","estado":"Datos de ubicacion encontrado","data":data })                            
            else:
                paso=14
                return ({"result":"-2","estado":"Datos de ubicacion no encontrado"})                         
        except ValueError as e:
            return( {"result":"-1","cadenaError": f"Error {str(e)} paso {paso}"})




   # este metodo permite extraer la familia de un usuario usando el Id
    def get_family(self,userId : int):
        paso=1
        try:
            paso=2
            nRecord=self.db.query(UsuarioModel).filter(UsuarioModel.id==userId).count()
            if (nRecord > 0):
                paso=2

                '''
                Debemos buscar todos los hijos y por cada hijo debemos devolver la siguiente estructura

                {
                    'id': 1,
                    'codigoReferido': 'REF123456',
                    'nombre': 'Juan',
                    'apellido': 'Pérez',
                    'productosAdquiridos': ['Producto A','Producto B'],
                    'promedioGanancias': 120.50,
                    'referidosIndirectos': 5,
                    'promedioGananciasIndirectos': 30.75,
                    'pnl': 12.3,
                    'gananciasTotales': 500.00,
                    'fechaRegistro': '2023-05-10T14:23:00Z',
                    'ultimaActividad': '2025-06-24T09:15:00Z',
                    'nivel': 'Oro',
                    'estado': 'activo',
                    'verificado': true,
                    'contacto': "{'email': 'juan.perez@email.com','telefono': '+58 123-4567890'}",
                    'tendenciaGanancias': 'subiendo',
                    'notas': 'Referido muy activo, excelente conversión.',
                }

                tabla de familia de un afiliado (familia_afiliado)
                -----------------------------------------------------
                    `id` bigint NOT NULL AUTO_INCREMENT,
                    `user_id` bigint NOT NULL comment 'usuario ascendente',    
                    `codigo_ascendente` varchar(150) NULL comment 'codigo de quien refiere (padre)' ,
                    `familiar_id` bigint NOT NULL comment 'id del usuario referido, hijo o nieto',	
                    `codigo_descendente` varchar(150) NULL comment 'codigo de quien refiere (padre)' ,    
                    `tipo` int NULL comment '1 Hijo 2 Nieto' ,
                    `created` datetime NOT NULL,
                    `updated` datetime NOT NULL,       


                
                Consulta view_familiares
                ------------------------------------------------------
                id	bigint(20)
                user_id	bigint(20)
                nombres	varchar(100)
                apellidos	varchar(100)
                sexo	int(11)
                fecha_nac	date
                created	datetime
                updated	datetime
                tipo	int(11)
                codigo_ascendente	varchar(150)
                codigo_descendente	varchar(150)
                id_ascendente	bigint(20)       

                '''

                paso=4
                # contamos los hijos del usuario
                nRecordFamily = self.db.query(FamilyUserModel).filter(FamilyUserModel.user_id==userId).filter(FamilyUserModel.tipo==1).count()

                paso=5
                if (nRecordFamily > 0):
                    paso=6
                    # tiene familia extraemos los hijos
                    # recorremos recordFamily paraa construir la salida
                    #data=recordFamily.to_dict()
                    #sqlQuery=f"select * from view_familiares where id_ascendente='userId' and tipo='1'"
                    #recordFamily=self.db.query(sqlQuery).all()

                    #query = text("SELECT * FROM view_familiares WHERE id_ascendente = :user_id AND tipo = '1'")

                    query = select(
                            literal_column("id"),
                            literal_column("user_id"),
                            literal_column("nombres") , # Esto asume que tu vista ya tiene esta columna
                            literal_column("apellidos"), # Esto asume que tu vista ya tiene esta columna
                            literal_column("sexo"), # Esto asume que tu vista ya tiene esta columna
                            literal_column("fecha_nac"), # Esto asume que tu vista ya tiene esta columna
                            literal_column("created"), # Esto asume que tu vista ya tiene esta columna
                            literal_column("updated"), # Esto asume que tu vista ya tiene esta columna
                            literal_column("tipo"), # Esto asume que tu vista ya tiene esta columna
                            literal_column("codigo_ascendente"), # Esto asume que tu vista ya tiene esta columna
                            literal_column("codigo_descendente"), # Esto asume que tu vista ya tiene esta columna                            
                            literal_column("id_ascendente") # Esto asume que tu vista ya tiene esta columna                            
                        ).select_from(text("view_familiares")) # Aquí también usamos text() para la vista
                    
                    paso=7
                    query = query.where(
                        literal_column("id_ascendente") == userId,
                        literal_column("tipo") == 1
                    )
                

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
                                id: 1,
                                codigoReferido: 'REF123456',
                                nombre: 'Juan',
                                apellido: 'Pérez',
                                productosAdquiridos: ['Producto A','Producto B'],
                                promedioGanancias: 120.50,
                                referidosIndirectos: 5,
                                promedioGananciasIndirectos: 30.75,
                                pnl: 12.3,
                                gananciasTotales: 500.00,
                                fechaRegistro: '2023-05-10T14:23:00Z',
                                ultimaActividad: '2025-06-24T09:15:00Z',
                                nivel: 'Oro',
                                estado: 'activo',
                                verificado: true,
                                contacto: {
                                    email: 'juan.perez@email.com',
                                    telefono: '+58 123-4567890'
                                },
                                tendenciaGanancias: 'subiendo',
                                notas: 'Referido muy activo, excelente conversión.',
                        
                            }                          
                            '''
                            paso=11                            
                            arregloProductos=["Producto A","Producto B"]

                            paso=12
                            promedioGanancias=100

                            paso=13
                            referidosIndirectos=5

                            paso=14
                            promedioGananciasIndirectos = 100

                            paso=15
                            pnl=100

                            paso=16
                            gananciasTotales = 1000

                            paso=17
                            if (promedioGanancias > 1000):
                                paso=18
                                nivel="Oro"
                            elif ((promedioGanancias <= 1000) and (promedioGanancias > 500)): 
                                paso=19
                                nivel="Plata"
                            else:
                                paso=20
                                nivel="Bronce"
                            
                            paso=21
                            estadoFamiliar="Activo"

                            paso=22
                            verificado=True

                            paso=23
                            infoContacto = {"correo":"correo_familiar","telefono":"02410007766"}

                            paso=24
                            tendenciaGanancia="Alza"

                            paso=25
                            notas="Observaciones"

                            paso=26
                            nuevo_registro = {
                                        "id": row.id,
                                        "codigoReferido": row.codigo_ascendente, # Este es un ejemplo, ajústalo a tu lógica real
                                        "nombre": row.nombres,
                                        "apellido": row.apellidos,
                                        "productosAdquiridos": arregloProductos,
                                        "promedioGanancias": promedioGanancias,
                                        "referidosIndirectos": referidosIndirectos,
                                        "promedioGananciasIndirectos": promedioGananciasIndirectos,
                                        "pnl": pnl,
                                        "gananciasTotales": gananciasTotales,
                                        "fechaRegistro": row.created,
                                        "ultimaActividad": row.updated,
                                        "nivel": nivel , # Lógica de ejemplo para nivel
                                        "estado": estadoFamiliar, # Suponiendo un estado por defecto, o basado en alguna lógica
                                        "verificado": verificado, # Suponiendo que son verificados, o basado en algún campo
                                        "contacto": infoContacto,
                                        "tendenciaGanancias": tendenciaGanancia,
                                        "notas": notas,
                                    }

                            paso=27    
                            arregloSalida.append(nuevo_registro)                        
                        
                        # Si quieres los resultados como diccionarios
                        # Si quieres los resultados como diccionarios
                        # recordFamily = [dict(row) for row in result.mappings()]           

                        paso=28
                        return ({"result":"1","estado":"Familia encontrada","nRecord":nRecordFamily,"data":arregloSalida})                       

                    else:
                        paso=500
                        return ({"result":"-4","estado":"Usuario no tiene familia"})
        
                else:
                    paso=1000
                    return ({"result":"-2","estado":"Usuario no encontrado"})                     

            else:
                paso=2000
                return ({"result":"-2","estado":"Usuario no encontrado"})                         
        except ValueError as e:
            return( {"result":"-1","cadenaError": f"Error {str(e)} paso {paso}"})   
        

    # metodo para actualizar datos personales del usuario
    # @params user_updater: Id del usuario que  actualizará los datos
    # @params data: esquema que representa los datos del usuario
    def update_personal_data_user(self, data : DatosPersonalesSchema, userId):
        ahora=datetime.now()
        try:       
            paso=1
            # buscamos si los datos personales del usuario existen 
            nRecordDatosPersonales=self.db.query(DatosPersonalesModel).filter(DatosPersonalesModel.user_id==userId).count()
            if (nRecordDatosPersonales > 0):
                paso=2
                # existe podemos actualizar
                RecordDatosPersonales=self.db.query(DatosPersonalesModel).filter(DatosPersonalesModel.user_id==userId).first()
                '''
                user_id = Column (BIGINT, ForeignKey("usuario.id", ondelete="RESTRICT") , nullable=False)
                nombres =Column(VARCHAR (100), nullable=False)
                apellidos =Column(VARCHAR (100), nullable=False)
                sexo =Column(INTEGER, nullable=False)
                fecha_nac = Column(DATE, nullable=False)
                created = Column (DateTime, nullable=False) #datetime NOT NULL,    
                updated = Column (DateTime, nullable=False)  #datetime NOT NULL,                
                '''
                paso=3
                RecordDatosPersonales.nac=data.nac.strip(),
                RecordDatosPersonales.identificacion=data.identificacion.strip(),
                RecordDatosPersonales.nombres=data.nombres.strip().upper()
                RecordDatosPersonales.apellidos=data.apellidos.strip().upper()
                RecordDatosPersonales.sexo=data.sexo
                RecordDatosPersonales.fecha_nac=data.fecha_nac
                RecordDatosPersonales.updated=ahora

                paso=4
                self.db.commit()   

                paso=5
                data=RecordDatosPersonales.to_dict()

                paso=6
                return ({"result":"1","estado":"Usuario Actualizado","data":data})
            else:
                # no existe debemos crear
                paso=7
                newUserPersonalData=DatosPersonalesModel(
                        user_id=userId,
                        nac=data.nac.strip(),
                        identificacion=data.identificacion.strip(),
                        nombres=data.nombres.strip().upper(),
                        apellidos=data.apellidos.strip().upper(),
                        sexo=data.sexo,
                        fecha_nac=data.fecha_nac,
                        created=ahora,
                        updated=ahora
                    )
               
                paso=8
                self.db.add(newUserPersonalData)
                paso=9
                self.db.commit()
                
                paso=10
                data=newUserPersonalData.to_dict()

                paso=11               
                return ({"result":"2","estado":"Datos Personales Creados","data":data})

        
        except ValueError as e:
            return( {"result":"-3","cadenaError": f"Error {str(e)} paso {paso}" })   
        

    # metodo para actualizar datos de ubicacion del usuario
    # @params user_updater: Id del usuario que  actualizará los datos
    # @params data: esquema que representa los datos del usuario
    def update_ubication_data_user(self, data : DatosPersonalesSchema, userId):
        ahora=datetime.now()
        try:       
            paso=1
            # buscamos si los datos personales del usuario existen 
            nRecordDatosPersonales=self.db.query(DatosPersonalesModel).filter(DatosPersonalesModel.user_id==userId).count()
            if (nRecordDatosPersonales > 0):
                paso=2
                # existe podemos actualizar
                RecordDatosPersonales=self.db.query(DatosPersonalesModel).filter(DatosPersonalesModel.user_id==userId).first()
                '''
                user_id = Column (BIGINT, ForeignKey("usuario.id", ondelete="RESTRICT") , nullable=False)
                nombres =Column(VARCHAR (100), nullable=False)
                apellidos =Column(VARCHAR (100), nullable=False)
                sexo =Column(INTEGER, nullable=False)
                fecha_nac = Column(DATE, nullable=False)
                created = Column (DateTime, nullable=False) #datetime NOT NULL,    
                updated = Column (DateTime, nullable=False)  #datetime NOT NULL,                
                '''
                paso=3
                RecordDatosPersonales.nac=data.nac.strip(),
                RecordDatosPersonales.identificacion=data.identificacion.strip(),
                RecordDatosPersonales.nombres=data.nombres.strip().upper()
                RecordDatosPersonales.apellidos=data.apellidos.strip().upper()
                RecordDatosPersonales.sexo=data.sexo
                RecordDatosPersonales.fecha_nac=data.fecha_nac
                RecordDatosPersonales.updated=ahora

                paso=4
                self.db.commit()   

                paso=5
                data=RecordDatosPersonales.to_dict()

                paso=6
                return ({"result":"1","estado":"Usuario Actualizado","data":data})
            else:
                # no existe debemos crear
                paso=7
                newUserPersonalData=DatosPersonalesModel(
                        user_id=userId,
                        nac=data.nac.strip(),
                        identificacion=data.identificacion.strip(),
                        nombres=data.nombres.strip().upper(),
                        apellidos=data.apellidos.strip().upper(),
                        sexo=data.sexo,
                        fecha_nac=data.fecha_nac,
                        created=ahora,
                        updated=ahora
                    )
               
                paso=8
                self.db.add(newUserPersonalData)
                paso=9
                self.db.commit()
                
                paso=10
                data=newUserPersonalData.to_dict()

                paso=11               
                return ({"result":"2","estado":"Datos Personales Creados","data":data})

        
        except ValueError as e:
            return( {"result":"-3","cadenaError": f"Error {str(e)} paso {paso}" })  

    # metodo para actualizar datos de contacto del usuario
    # @params user_updater: Id del usuario que  actualizará los datos
    # @params data: esquema que representa los datos del usuario
    def update_contact_data_user(self, data : DatosPersonalesSchema, userId):
        ahora=datetime.now()
        try:       
            paso=1
            # buscamos si los datos personales del usuario existen 
            nRecordDatosPersonales=self.db.query(DatosPersonalesModel).filter(DatosPersonalesModel.user_id==userId).count()
            if (nRecordDatosPersonales > 0):
                paso=2
                # existe podemos actualizar
                RecordDatosPersonales=self.db.query(DatosPersonalesModel).filter(DatosPersonalesModel.user_id==userId).first()
                '''
                user_id = Column (BIGINT, ForeignKey("usuario.id", ondelete="RESTRICT") , nullable=False)
                nombres =Column(VARCHAR (100), nullable=False)
                apellidos =Column(VARCHAR (100), nullable=False)
                sexo =Column(INTEGER, nullable=False)
                fecha_nac = Column(DATE, nullable=False)
                created = Column (DateTime, nullable=False) #datetime NOT NULL,    
                updated = Column (DateTime, nullable=False)  #datetime NOT NULL,                
                '''
                paso=3
                RecordDatosPersonales.nac=data.nac.strip(),
                RecordDatosPersonales.identificacion=data.identificacion.strip(),
                RecordDatosPersonales.nombres=data.nombres.strip().upper()
                RecordDatosPersonales.apellidos=data.apellidos.strip().upper()
                RecordDatosPersonales.sexo=data.sexo
                RecordDatosPersonales.fecha_nac=data.fecha_nac
                RecordDatosPersonales.updated=ahora

                paso=4
                self.db.commit()   

                paso=5
                data=RecordDatosPersonales.to_dict()

                paso=6
                return ({"result":"1","estado":"Usuario Actualizado","data":data})
            else:
                # no existe debemos crear
                paso=7
                newUserPersonalData=DatosPersonalesModel(
                        user_id=userId,
                        nac=data.nac.strip(),
                        identificacion=data.identificacion.strip(),
                        nombres=data.nombres.strip().upper(),
                        apellidos=data.apellidos.strip().upper(),
                        sexo=data.sexo,
                        fecha_nac=data.fecha_nac,
                        created=ahora,
                        updated=ahora
                    )
               
                paso=8
                self.db.add(newUserPersonalData)
                paso=9
                self.db.commit()
                
                paso=10
                data=newUserPersonalData.to_dict()

                paso=11               
                return ({"result":"2","estado":"Datos Personales Creados","data":data})

        
        except ValueError as e:
            return( {"result":"-3","cadenaError": f"Error {str(e)} paso {paso}" })                   


   # metodo para actualizar datos de contacto y de ubicacion de forma combinada del usuario
    # @params data: esquema que representa los datos del usuario
    def update_all_data_user(self, data : AllDataUserSchema, userId):
        ahora=datetime.now()
        try:       
            paso=1
            # buscamos si los datos personales del usuario existen 
            nRecordDatosPersonales=self.db.query(DatosPersonalesModel).filter(DatosPersonalesModel.user_id==userId).count()
            if (nRecordDatosPersonales > 0):
                paso=2
                # existe podemos actualizar
                RecordDatosPersonales=self.db.query(DatosPersonalesModel).filter(DatosPersonalesModel.user_id==userId).first()
                '''
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

                    id	bigint(20) AI PK
                    user_id	bigint(20)
                    nac	varchar(1)
                    numero	varchar(30)
                    identidad	varchar(1)
                    apellido	varchar(100)
                    nombre	varchar(100)
                    fecha_nac	date
                    sexo	int(11)
                    created	datetime
                    updated	datetime                         
                '''
                paso=3
                RecordDatosPersonales.nac=data.nacionalidad,
                RecordDatosPersonales.numero=data.numeroCedula
                RecordDatosPersonales.identidad=data.identidad.strip(),
                RecordDatosPersonales.nombre=data.nombre.strip().upper()
                RecordDatosPersonales.apellido=data.apellido.strip().upper()
                RecordDatosPersonales.sexo=data.sexo
                RecordDatosPersonales.fecha_nac=data.fechaNacimiento
                RecordDatosPersonales.updated=ahora

                paso=4
                self.db.commit()   
            
            else:
                # no existe debemos crear los datos personales
                paso=7
                '''
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

                    id	bigint(20) AI PK
                    user_id	bigint(20)
                    nac	varchar(1)
                    numero	varchar(30)
                    identidad	varchar(1)
                    apellido	varchar(100)
                    nombre	varchar(100)
                    fecha_nac	date
                    sexo	int(11)
                    created	datetime
                    updated	datetime                         
                '''
                newUserPersonalData=DatosPersonalesModel(
                        user_id=userId,
                        nac=data.nacionalidad.strip(),
                        numero=data.numeroCedula,
                        identidad=data.identidad.strip(),
                        nombre=data.nombre.strip().upper(),
                        apellido=data.apellido.strip().upper(),
                        sexo=data.sexo,
                        fecha_nac=data.fechaNacimiento,
                        created=ahora,
                        updated=ahora
                    )
               
                paso=8
                self.db.add(newUserPersonalData)
                paso=9
                self.db.commit()


            # creamos los datos de ubicacion
            paso=20
            nRecordDatosUbicacion=self.db.query(DatosUbicacionModel).filter(DatosUbicacionModel.user_id==userId).count()

            paso=21
            if (nRecordDatosUbicacion > 0):
                paso=22
                # existe podemos actualizar
                RecordDatosUbicacion=self.db.query(DatosUbicacionModel).filter(DatosUbicacionModel.user_id==userId).first()
                '''
                    `id` bigint(20) NOT NULL AUTO_INCREMENT,
                    `user_id` bigint(20) NOT NULL,
                    `direccion1` varchar(250) NOT NULL,
                    `direccion2` varchar(250) DEFAULT NULL,
                    `estado_id` int(11) NOT NULL,
                    `municipio_id` int(11) NOT NULL,
                    `created` datetime NOT NULL,
                    `updated` datetime NOT NULL,
                    PRIMARY KEY (`id`),
                    KEY `fk_usuario_datos_personales` (`user_id`),
                    KEY `fk_estado_datos_personales` (`estado_id`),
                    KEY `fk_municipio_datos_personales` (`municipio_id`),
                    CONSTRAINT `fk_estado_datos_personales` FOREIGN KEY (`estado_id`) REFERENCES `estado` (`id`) ON UPDATE CASCADE,
                    CONSTRAINT `fk_municipio_datos_personales` FOREIGN KEY (`municipio_id`) REFERENCES `municipio` (`id`) ON UPDATE CASCADE,
                    CONSTRAINT `fk_usuario_datos_personales` FOREIGN KEY (`user_id`) REFERENCES `usuario` (`id`) ON UPDATE CASCADE                
                '''
                paso=23
                RecordDatosUbicacion.direccion1=data.direccion.strip()
                RecordDatosUbicacion.estado_id=data.estado,
                RecordDatosUbicacion.municipio_id=data.municipio
                RecordDatosUbicacion.updated=ahora

                paso=24 
                self.db.add(RecordDatosUbicacion)
                paso=25
                self.db.commit()

            else:
                # no existe los creamos
                paso=30
                newRecordDatosUbicacion = DatosUbicacionModel (
                    user_id=userId,
                    direccion1=data.direccion.strip(),
                    estado_id=data.estado,
                    municipio_id=data.municipio,
                    created = ahora,
                    updated = ahora
                )

                paso=31
                self.db.add(newRecordDatosUbicacion)
                paso=32
                self.db.commit()


            paso=50           
            return ({"result":"1","estado":"Datos Personales Actualizados","data":data})

        
        except ValueError as e:
            return( {"result":"-3","cadenaError": f"Error {str(e)} paso {paso}" })                   



    # metodo para actualizar datos personales del usuario
    # @params user_updater: Id del usuario que  actualizará los datos
    # @params data: esquema que representa los datos del usuario
    def update_user(self, user_updater: int, data : UserSchema , userId):
        ahora=datetime.datetime.now()
        try:       
            #validaciones de los datos 
            rutOk=False
            nombreOk=False
            apellidoOk=False

            #validamos el rut
            '''
            paso=0   
            rutOk=ValidationController.validarRut(data.rut)
            
            
            #validamos el nombre
            paso=1
            nombreOk=ValidationController.validar_nombre(data.nombres.strip().upper())
            
            #validamos el apellido paterno
            paso=2
            apellidoOk=ValidationController.validar_nombre(data.apellidos.strip().upper())
            

            #validamos que los datos primarios esten validados
            paso=4
            if (rutOk and nombreOk and apellidoOk ):
                paso=5
                nRecordUser = self.db.query(UsuarioModel).filter(UsuarioModel.id==userId).count()
                if (nRecordUser>0):

                    #verificamos que ese usuario no este siendo usado por otro
                    paso=7
                    nRecordUsername=self.db.query(UsuarioModel).filter(and_(UsuarioModel.username == data.username, UsuarioModel.id != userId)).count()

                    #verificamos que ese rut no este registrado en el sistema
                    paso=10
                    nRecordRut=self.db.query(UsuarioModel).filter(and_(UsuarioModel.rut == data.rut,UsuarioModel.id != userId)).count() 


                    if (nRecordUsername > 0):
                        # se el rut ya esta siendo usado por otra persona
                        #buscamos el id de este dato que existe 
                        paso=14
                        userExists=self.db.query(UsuarioModel).filter(and_(UsuarioModel.username == data.username, UsuarioModel.id != userId)).first()
                        return ({"result":"-2","estado":"Este Username ya esta siendo ocupado en el sistema","UserId": userExists.id})     
                    elif (nRecordRut > 0):    
                        # se el rut ya esta siendo usado por otra persona
                        #buscamos el id de este dato que existe 
                        paso=15
                        userExists=self.db.query(UsuarioModel).filter(and_(UsuarioModel.rut == data.rut,UsuarioModel.id != userId)).first()
                        return ({"result":"-4","estado":"Este RUT ya esta registrado a nombre de otro usuario","UserId":userExists.id})        
                    else:
                        paso=6
                        userExists =self.db.query(UsuarioModel).filter(UsuarioModel.id==userId).first()


                        paso=7
                        if (userExists.rut != data.rut):
                            userExists.rut=data.rut
                        userExists.apellidos=data.apellidos.upper().strip()
                        userExists.nombres=data.nombres.upper().strip()
                        userExists.fecha_nacimiento=data.fecha_nacimiento
                        userExists.sexo_id=data.sexo_id
                        if (userExists.username != data.username):
                            userExists.username=data.username.strip().lower()
                        userExists.activo=data.activo
                        userExists.updated=datetime.datetime.now()
                        userExists.updater_user=user_updater

                        #creamos el historico de los datos del usuario
                        # buscamos los datos del creador del registro
                        dataCreator=self.db.query(UsuarioModel).filter(UsuarioModel.id==user_updater).first()

                        paso=5
                        newBitacora=BitacoraModel (
                            user_id=user_updater,
                            nombre=f"{dataCreator.nombres} {dataCreator.apellidos}",
                            accion=f"Actualizacion en el sistema Nuevo Id de usuario:{userExists.id}, Nombre del usuario: {((userExists.nombres).upper()).strip()} {((userExists.apellidos).upper()).strip()}",
                            fecha_ingreso=ahora,
                            fecha_egreso=ahora,
                            delta='00:01'

                        )

                        paso=6
                        self.db.add(newBitacora)
                        paso=7
                        self.db.commit()                           

                        paso=18
                        self.db.commit()
                        # se actualizó la data personal del usuario
                        data=userExists.to_dict()

                        return ({"result":"1","estado":"Usuario Actualizado","data":data})
                else:
                    # no existe el ID del usuario
                    return ({"result":"-1","estado":"Usuario no encontrado","UserId":id})
            else:
                cadenaError="Existen errores de formatro en los datos:"
                if (not rutOk):
                    cadenaError=cadenaError + " El Rut está mal formateado"
                if (not rutProvisorioOk):
                    cadenaError=cadenaError + " El Rut Provisorio está mal formateado"                    

                if (not nombreOk):
                    cadenaError=cadenaError + " El Nombre tiene caracteres inválidos"
                
                if (not apellidoPaternoOk):
                    cadenaError=cadenaError + " El apellido Paterno tiene caracteres inválidos"

                if (not apellidoMaternoOk):
                    cadenaError=cadenaError + " El apellido Materno tiene caracteres inválidos"                    

                return( {"result":"-6","cadenaError":cadenaError})    
                '''
            data={"datos":"1"}
            return ({"result":"1","estado":"Usuario Actualizado","data":data})
        
        except ValueError as e:
            return( {"result":"-3","cadenaError": f"Error {str(e)} paso {paso}" })   



    #metodo para activar al usuario del sistema
    # @params user_updater: Id del usuario que  actualizará los datos
    # @params data: esquema que representa los datos del usuario
    def activate_user (self, user_updater: int, userId:int  ):
        ahora=datetime.datetime.now()
        paso=1
        try:       
            ''' 
            #verificamos que el usuario exista
            paso=1
            nRecordUser=self.db.query(UsuarioModel).filter(UsuarioModel.id==userId).count()
            
            if (nRecordUser > 0):
                paso=2
                # extremos los datos para guardar en el historico
                user = self.db.query(UsuarioModel).filter(UsuarioModel.id==userId).first()

                paso=4
                user.activo=1
                user.updated=datetime.datetime.now()
                user.updater_user=user_updater

                paso=5
                self.db.commit()

                # creamos el historico 

                id = Column(BIGINT, primary_key=True, autoincrement=True)
                user_id = Column(BIGINT,  ForeignKey("Usuario.id", ondelete="RESTRICT", onupdate="CASCADE"), nullable=False)
                nombre=Column(VARCHAR(100), nullable=False)
                accion=Column(VARCHAR(250), nullable=False)
                fecha_ingreso=Column(DATETIME, nullable=False)
                fecha_egreso=Column(DATETIME, nullable=False)
                delta=Column(TIME, nullable=False)                


                # buscamos los datos del creador del registro
                dataCreator=self.db.query(UsuarioModel).filter(UsuarioModel.id==user_updater).first()

                paso=5
                newBitacora=BitacoraModel (
                    user_id=user_updater,
                    nombre=f"{dataCreator.nombres} {dataCreator.apellidos}",
                    accion=f"Se Activo al usuario:{user.id}, Nombre del usuario: {((user.nombres).upper()).strip()} {((user.apellidos).upper()).strip()}",
                    fecha_ingreso=ahora,
                    fecha_egreso=ahora,
                    delta='00:01'

                )

                paso=6
                self.db.add(newBitacora)
                paso=7
                self.db.commit()   

                data=user.to_dict()
                # se actualizó la data personal del usuario
                return ({"result":"1","estado":"Se activo al usuario","data":data})
            else:
                # no existe el ID del usuario
                return ({"result":"-1","estado":"Usuario no encontrado","UserId":userId})
                '''
            
            data={"data":"1"}
            return ({"result":"1","estado":"Se activo al usuario","data":data})

        except ValueError as e:
                return( {"result":"-3","cadenaError": f"Error {str(e)} paso {paso}"})
        

    #metodo para desactivar al usuario del sistema
    # @params user_updater: Id del usuario que  actualizará los datos
    # @params data: esquema que representa los datos del usuario
    def deactivate_user (self, user_updater: int, userId:int  ):
        ahora=datetime.datetime.now()
        paso=1
        try:   
            '''
            #verificamos que el usuario exista
            paso=1
            nRecordUser=self.db.query(UsuarioModel).filter(UsuarioModel.id==userId).count()
            
            if (nRecordUser > 0):
                paso=2
                # extremos los datos para guardar en el historico
                user = self.db.query(UsuarioModel).filter(UsuarioModel.id==userId).first()

                # creamos un registro en el historico del usuario
                paso=4
                user.activo=0
                user.updated=datetime.datetime.now()
                user.updater_user=user_updater

                paso=5
                self.db.commit()

                # creamos el historico 

                id = Column(BIGINT, primary_key=True, autoincrement=True)
                user_id = Column(BIGINT,  ForeignKey("Usuario.id", ondelete="RESTRICT", onupdate="CASCADE"), nullable=False)
                nombre=Column(VARCHAR(100), nullable=False)
                accion=Column(VARCHAR(250), nullable=False)
                fecha_ingreso=Column(DATETIME, nullable=False)
                fecha_egreso=Column(DATETIME, nullable=False)
                delta=Column(TIME, nullable=False)                
  

                # buscamos los datos del creador del registro
                dataCreator=self.db.query(UsuarioModel).filter(UsuarioModel.id==user_updater).first()

                paso=5
                newBitacora=BitacoraModel (
                    user_id=user_updater,
                    nombre=f"{dataCreator.nombres} {dataCreator.apellidos}",
                    accion=f"Se Desactivo al usuario:{user.id}, Nombre del usuario: {((user.nombres).upper()).strip()} {((user.apellidos).upper()).strip()}",
                    fecha_ingreso=ahora,
                    fecha_egreso=ahora,
                    delta='00:01'

                )

                paso=6
                self.db.add(newBitacora)
                paso=7
                self.db.commit()   

                data=user.to_dict()
                # se actualizó la data personal del usuario
                return ({"result":"1","estado":"Se desactivo al usuario","data":data})
            else:
                # no existe el ID del usuario
                return ({"result":"-1","estado":"Usuario no encontrado","UserId":userId})
                '''
            
            data={"datos":"1"}
            return ({"result":"1","estado":"Se desactivo al usuario","data":data})
        
        except ValueError as e:
                return( {"result":"-3","cadenaError": f"Error {str(e)} paso {paso}"})
        


    #metodo para activar al usuario del sistema
    # @params user_updater: Id del usuario que  actualizará los datos
    # @params data: esquema que representa los datos del usuario
    def change_estatus_user (self, estado:int, userId:int, token: str  ):

        ahora=datetime.datetime.now()
        paso=1
        try:       
            '''
            #verificamos que el usuario exista
            paso=1
            nRecordUser=self.db.query(UsuarioModel).filter(UsuarioModel.id==userId).count()
            
            if (nRecordUser > 0):
                paso=2
                # extraemos los datos para guardar en el historico
                user = self.db.query(UsuarioModel).filter(UsuarioModel.id==userId).first()

                # buscamos si existe el usuario con ese token en la bd
                paso=3
                nRecord=self.db.query(EstadosUsuarioModel).filter(EstadosUsuarioModel.user_id==userId).count()
                
                
                if (nRecord > 0):
                    # existe actualizamos 
                    paso=4

                    estadoExists=self.db.query(EstadosUsuarioModel).filter(EstadosUsuarioModel.user_id==userId).first()

                    #----------------------------- ojo aqui -------------------------------
                    # hacemos esta verificacion para determinar si debemos actualizar o no el monto en que fue creado
                    # esto para poder determinar de forma corecta el delta
                    cambio=False
                    if (estado != estadoExists.estado ):
                        estadoExists.created=ahora
                        cambio=True
                    
                    #actualizamos el resto de los campos
                    estadoExists.estado=estado
                    estadoExists.updated=ahora
                    estadoExists.token

                    paso=5
                    self.db.commit()

                    delta=ahora-estadoExists.created
                    tiempo_diferencia = delta.seconds // 3600, (delta.seconds % 3600) // 60, delta.seconds % 60
                    diferencia_formateada = "{:02}:{:02}:{:02}".format(*tiempo_diferencia)

                    # creamos el historico 

                    `id` bigint(20) NOT NULL AUTO_INCREMENT,
                    `estado_id` bigint(20) NOT NULL,
                    `user_id` bigint(20) NOT NULL,
                    `nombre` varchar(100) NOT NULL,	
                    `token` varchar(150) NOT NULL,	    
                    `estado` int NOT NULL,	    
                    `created` datetime NOT NULL,
                    `updated` datetime NOT NULL,
                    `delta` time NOT NULL,
                    PRIMARY KEY (`id`)                   

                    #cambio el estado debmos crear un historio de estados para los efectos de las estadisticas
                    # debemos crear un registro en la bitacora
                    if (cambio):
                        newHistoricoEstado=HistorioEstadosUsuarioModel(
                            estado_id=estadoExists.id,
                            user_id=estadoExists.user_id,
                            nombre=estadoExists.nombre,
                            token=estadoExists.token,
                            estado=estadoExists.estado,
                            created=estadoExists.created,
                            updated=ahora,
                            delta= diferencia_formateada
                        )


                        paso=6
                        self.db.add(newHistoricoEstado)
                        paso=7
                        self.db.commit()                      

                        #pdb.set_trace()

                        id = Column(BIGINT, primary_key=True, autoincrement=True)
                        user_id = Column(BIGINT,  ForeignKey("Usuario.id", ondelete="RESTRICT", onupdate="CASCADE"), nullable=False)
                        nombre=Column(VARCHAR(100), nullable=False)
                        accion=Column(VARCHAR(250), nullable=False)
                        fecha_ingreso=Column(DATETIME, nullable=False)
                        fecha_egreso=Column(DATETIME, nullable=False)
                        delta=Column(TIME, nullable=False)                


                        # buscamos los datos del creador del registro
                        dataCreator=self.db.query(UsuarioModel).filter(UsuarioModel.id==userId).first()

                        paso=8


                        newBitacora=BitacoraModel (
                            user_id=userId,
                            nombre=f"{dataCreator.nombres} {dataCreator.apellidos}",
                            accion=f"Se cambio el estado del usuario:{user.id}, Nombre del usuario: {((user.nombres).upper()).strip()} {((user.apellidos).upper()).strip()} , Estado:{estado}",
                            fecha_ingreso=ahora,
                            fecha_egreso=ahora,
                            delta=diferencia_formateada

                        )

                        paso=9
                        self.db.add(newBitacora)
                        paso=10
                        self.db.commit()   
                    else:
                        paso=12
                        #actualizamos el delta en el historico
                        estadoId=estadoExists.id

                        paso=13
                        historicoExists=self.db.query(HistorioEstadosUsuarioModel).filter(HistorioEstadosUsuarioModel.estado_id==estadoId).order_by(HistorioEstadosUsuarioModel.id.desc()).first()

                        paso=14
                        historicoExists.updated=ahora
                        historicoExists.delta=diferencia_formateada

                        paso=15
                        self.db.commit()  

                    paso=16
                    data=estadoExists.to_dict()
                    # se actualizó la data personal del usuario

                    paso=12
                    return ({"result":"1","estado":"Se cambio el estado del usuario","data":data})

                else:    
                    # no existe creamos el registro 
                    
                    id = Column(BIGINT, primary_key=True, autoincrement=True)
                    nombre = Column (VARCHAR(100), nullable=False) #VARCHAR(100) NOT NULL,
                    user_id = Column(BIGINT,  ForeignKey("Usuario.id", ondelete="RESTRICT", onupdate="CASCADE"), nullable=False)
                    token = Column (VARCHAR(150), nullable=False) #VARCHAR(100) NOT NULL,
                    estado =Column(INTEGER, nullable=False)
                    created = Column (DateTime, nullable=False) #datetime NOT NULL,    
                    updated = Column (DateTime, nullable=False)  #datetime NOT NULL,                    
                    
                    paso=10
                    newEstadoUser=EstadosUsuarioModel(
                        user_id=userId,
                        nombre=f"{user.nombres} {user.apellidos}",
                        token=token,
                        estado=estado,
                        created=ahora,
                        updated=ahora

                    )

                    paso=11
                    self.db.add(newEstadoUser)
                    paso=12
                    self.db.commit()   

                    paso=13
                    data=newEstadoUser.to_dict()
                    # se actualizó la data personal del usuario

                    # creamos el historico 

                    newHistoricoEstado=HistorioEstadosUsuarioModel(
                        estado_id=newEstadoUser.id,
                        user_id=newEstadoUser.user_id,
                        nombre=newEstadoUser.nombre,
                        token=newEstadoUser.token,
                        estado=newEstadoUser.estado,
                        created=ahora,
                        updated=ahora,
                        delta='00:00:01'
                    )

                    paso=14
                    self.db.add(newHistoricoEstado)
                    paso=15
                    self.db.commit()    


                    # buscamos los datos del creador del registro
                    paso=16
                    dataCreator=self.db.query(UsuarioModel).filter(UsuarioModel.id==userId).first()

                    paso=17
                    newBitacora=BitacoraModel (
                        user_id=userId,
                        nombre=f"{dataCreator.nombres} {dataCreator.apellidos}",
                        accion=f"Se cambio el estado del usuario:{user.id}, Nombre del usuario: {((user.nombres).upper()).strip()} {((user.apellidos).upper()).strip()}, Estado:{estado}",
                        fecha_ingreso=ahora,
                        fecha_egreso=ahora,
                        delta='00:01'

                    )

                    paso=18
                    self.db.add(newBitacora)

                    paso=19
                    self.db.commit()                      

                    paso=20
                    return ({"result":"1","estado":"Se cambio el estado del usuario","data":data})
             
  
            else:
                # no existe el ID del usuario
                return ({"result":"-1","estado":"Usuario no encontrado","UserId":userId})
                '''
        
            data={"datos":"1"}
            return ({"result":"1","estado":"Se cambio el estado del usuario","data":data})  
        except ValueError as e:
                return( {"result":"-3","cadenaError": f"Error {str(e)} paso {paso}"})
        
    def get_estados (self):

        try:       
            paso=1
            # buscamos si los datos personales del usuario existen 
            nRecordEstados=self.db.query(EstadosModel).count()
            if (nRecordEstados > 0):
                paso=2
                # existe podemos actualizar
                RecordEstados=self.db.query(EstadosModel).all()

                paso = 4
                # Creamos una lista vacía para almacenar los diccionarios
                lista_de_diccionarios = []
                
                paso = 5
                # Iteramos sobre cada objeto de la consulta
                for estado_obj in RecordEstados:
                    # Usamos el método to_dict() del modelo para convertir cada objeto a un diccionario
                    lista_de_diccionarios.append(estado_obj.to_dict())
                
                paso = 6
                # Asignamos la lista de diccionarios a la variable `data`
                data = lista_de_diccionarios                

                paso=7
                return ({"result":"1","estado":"Estados Encontrados","data":data})
            else:
                paso=11               
                return ({"result":"-1","estado":"No se han definido Estados en el sistema"})

        
        except ValueError as e:
            return( {"result":"-3","cadenaError": f"Error {str(e)} paso {paso}" })        