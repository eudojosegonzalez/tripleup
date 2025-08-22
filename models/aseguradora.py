'''
Modelo que define a la tabla Usuario
Esto se usa para el registro primario
Created 2026-06
'''
from config.database import Base
from sqlalchemy import Column,  VARCHAR, BIGINT, DATE, DateTime, Boolean, INTEGER, ForeignKey, TEXT

# Definicion de una tabla
class Aseguradora(Base):
    __tablename__="aseguradora"
    '''
	`id` bigint NOT NULL AUTO_INCREMENT,
	`descripcion` varchar(150) NOT NULL ,
	`logo` varchar(250) NOT NULL ,
	`verificado` int NOT NULL default '1',    
	`emergencia` text NULL ,    
	`soporte` text NULL ,       
	`created` datetime NOT NULL,
	`updated` datetime NOT NULL,
	`creator_user` bigint(20) NOT NULL,
	`updater_user` bigint(20) NOT NULL,
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

    def to_dict(self):
        result = {
            "id":self.id,
            "descripcion":self.descripcion,
            "logo":self.logo,
            "verificado":self.verificado,
            "emergencia":self.emergencia,
            "soporte":self.soporte,
            "created":self.created,
            "updated":self.updated,
            "creator_user":self.creator_user,
            "updater_user":self.updater_user
        }
        return (result) 
