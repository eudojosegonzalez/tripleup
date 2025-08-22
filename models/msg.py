'''
Modelo que define a la tabla Mensajed
Created 2024-06
'''
from config.database import Base
from sqlalchemy import Column,  VARCHAR, BIGINT, DATE, DateTime, Boolean, INTEGER,TEXT, DATETIME

# Definicion de una tabla
class MSG(Base):
    __tablename__="MSG"
    '''
	`id` bigint(20) NOT NULL AUTO_INCREMENT,
	`remitente` bigint(20) NOT NULL,
	`destinatario` bigint(20) NOT NULL,  
	`nombre` varchar(100) NOT NULL,
	`subject` varchar(250) NOT NULL,
	`msg` text NOT NULL,    
	`fecha_envio` datetime NOT NULL,
	`fecha_recepcion` datetime NOT NULL,
	`estado` integer NOT NULL,
    PRIMARY KEY (`id`)
    '''
    id = Column(BIGINT, primary_key=True, autoincrement=True)
    remitente = Column(BIGINT, nullable= False)
    destinatario = Column(BIGINT, nullable= False)
    nombre=Column(VARCHAR(100),nullable=False)
    subject=Column(VARCHAR(100),nullable=False)
    msg =Column(TEXT,nullable=False)
    fecha_envio=Column(DATETIME, nullable=False)
    fecha_recepcion=Column(DATETIME, nullable=True)
    estado = Column(INTEGER, nullable= False)

    def to_dict(self):
        result = {
            "id":self.id,
            "remitente":self.remitente,
            "destinatario":self.destinatario,
            "nombre":self.nombre,
            "subject":self.subject,
            "msg":self.msg,
            "fecha_envio":str(self.fecha_envio),
            "fecha_recepcion":str(self.fecha_recepcion),
            "estado":self.estado,
        }
        return (result) 

 