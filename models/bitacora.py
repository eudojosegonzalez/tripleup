'''
Modelo que define a la tabla Usuario
Created 2026-06
'''
from config.database import Base
from sqlalchemy import Column,  VARCHAR, BIGINT, DATETIME , INTEGER, ForeignKey, TIME, TEXT

# Definicion de una tabla
class Bitacora(Base):
    __tablename__="bitacora"
    '''
	`id` bigint NOT NULL AUTO_INCREMENT,
	`user_id` bigint NOT NULL ,
	`observaciones` text NOT NULL ,    
	`created` datetime NOT NULL,
	PRIMARY KEY (`id`),
    constraint `fk_usuario_bitacora_user` foreign key (`user_id`) references `usuario`(`id`)
    on update cascade on delete restrict
    '''
    id = Column(BIGINT, primary_key=True, autoincrement=True)
    user_id = Column(BIGINT,  ForeignKey("usuario.id", ondelete="RESTRICT", onupdate="CASCADE"), nullable=False)
    observaciones = Column (TEXT, nullable=False)
    created=Column(DATETIME, nullable=False)


    def to_dict(self):
        result = {
            "id":self.id,
            "user_id":self.user_id,
            "observaciones":self.observaciones,
            "created":str(self.created)
        }
        return (result) 

