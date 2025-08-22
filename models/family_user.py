'''
Modelo que define a la tabla de Familiares de los Usuarios
Created 2026-06
'''
from config.database import Base
from sqlalchemy import Column,  VARCHAR, BIGINT, DATE, DateTime, Boolean, INTEGER, ForeignKey,TEXT

# Definicion de una tabla
class FamilyUser(Base):
    __tablename__="familia_afiliado"
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
    id = Column(BIGINT, primary_key=True, autoincrement=True)
    user_id = Column(BIGINT, ForeignKey("usuario.id", ondelete="RESTRICT", onupdate="CASCADE"), nullable=False) #varchar(250) NOT NULL,    
    codigo_ascendente = Column(VARCHAR(150), nullable=False) #NOT NULL,  
    familiar_id = Column(BIGINT, nullable=False) #varchar(250) NOT NULL,    
    codigo_descendente = Column(VARCHAR(150), nullable=False) #NOT NULL,  
    tipo = Column (INTEGER, nullable=False)
    created = Column (DateTime, nullable=False) #datetime NOT NULL,    
    updated = Column (DateTime, nullable=False)  #datetime NOT NULL,


    def to_dict(self):
        result = {
            "id":self.id,
            "user_id":self.user_id,
            "codigo_ascendente":self.codigo_ascendente,
            "familiar_id":self.familiar_id,
            "codigo_descendente":self.codigo_descendente,
            "tipo":self.tipo,
            "created":self.created,
            "updated":self.updated,
        }
        return (result) 
