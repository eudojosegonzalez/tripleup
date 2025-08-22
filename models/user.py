'''
Modelo que define a la tabla Usuario
Esto se usa para el registro primario
Created 2026-06
'''
from config.database import Base
from sqlalchemy import Column,  VARCHAR, BIGINT, DATE, DateTime, Boolean, INTEGER

# Definicion de una tabla
class Usuario(Base):
    __tablename__="usuario"
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
	PRIMARY KEY (`id`),
    unique (`username`),
    unique (`codigo`),    
    constraint `fk_niveles_usuarios` foreign key (id_nivel) references `nivel`(`id`)
    on update cascade on delete restrict
    '''
    id = Column(BIGINT, primary_key=True, autoincrement=True)
    username = Column(VARCHAR(250), nullable=False) #varchar(250) NOT NULL,    
    password = Column(VARCHAR(250), nullable=False) #NOT NULL,  
    estado = Column(INTEGER, nullable=False)
    confirmado = Column(INTEGER, nullable=False)   
    id_nivel =  Column(INTEGER, nullable=False) #BIGINT NOT NULL,     
    codigo = Column(VARCHAR(150), nullable=False)
    created = Column (DateTime, nullable=False) #datetime NOT NULL,    
    updated = Column (DateTime, nullable=False)  #datetime NOT NULL,
    confirmated  = Column (DateTime, nullable=False)  #datetime NOT NULL,

    def to_dict(self):
        result = {
            "id":self.id,
            "username":self.username,
            "password":self.password,
            "estado":self.estado,
            "confirmado":self.confirmado,
            "id_nivel":self.id_nivel,
            "codigo":self.codigo,
            "created":self.created,
            "updated":self.updated,
            "confirmated":self.confirmated
        }
        return (result) 
