'''
Modelo que define a la tabla datos de contacto
Esto se usa para el registro primario
Created 2025-08
'''
from config.database import Base
from sqlalchemy import Column,  VARCHAR, BIGINT, DATE, DateTime, Boolean, INTEGER, ForeignKey, UniqueConstraint

# Definicion de una tabla
class DatosContacto(Base):
    __tablename__="datos_contacto"
    '''
    CREATE TABLE tripleup.`datos_contacto` (
    `id` bigint(20) NOT NULL AUTO_INCREMENT,
    `user_id` bigint(20) NOT NULL,
    `celular` varchar(50) NOT NULL,
    `celular_alternativo` varchar(50) DEFAULT NULL,
    `created` datetime NOT NULL,
    `updated` datetime NOT NULL,
    PRIMARY KEY (`id`),
    KEY `fk_usuario_datos_contacto` (`user_id`),
    CONSTRAINT `fk_usuario_datos_contacto` FOREIGN KEY (`user_id`) REFERENCES `usuario` (`id`) ON UPDATE CASCADE
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Tabla de datos de contacto del usuario';

    '''
    id = Column(BIGINT, primary_key=True, autoincrement=True)
    user_id = Column (BIGINT, ForeignKey("usuario.id", ondelete="RESTRICT") , nullable=False)
    celular = Column (VARCHAR(50), nullable=False)
    celular_alternativo = Column (VARCHAR(50), nullable=True)
    created = Column (DateTime, nullable=False) #datetime NOT NULL,    
    updated = Column (DateTime, nullable=False)  #datetime NOT NULL,

    def to_dict(self):
        result = {
            "id" : self.id,
            "user_id" : self.user_id,
            "celular" : self.celular,
            "celuilar_alternativo": self.celular_alternativo,
            "created" : self.created,
            "updated" : self.updated
        }
        return (result) 

