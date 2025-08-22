'''
Modelo que define a la tabla datos de ubicacion
Esto se usa para el registro primario
Created 2025-08
'''
from config.database import Base
from sqlalchemy import Column,  VARCHAR, BIGINT, DATE, DateTime, Boolean, INTEGER, ForeignKey, UniqueConstraint

# Definicion de una tabla
class DatosUbicacion(Base):
    __tablename__="datos_ubicacion"
    '''
    CREATE TABLE `datos_ubicacion` (
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
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Tabla de datos de direccion del usuario';

    '''
    id = Column(BIGINT, primary_key=True, autoincrement=True)
    user_id = Column (BIGINT, ForeignKey("usuario.id", ondelete="RESTRICT") , nullable=False)
    direccion1 = Column (VARCHAR(250), nullable=False)
    direccion2  = Column (VARCHAR(250), nullable=True)
    estado_id  = Column (BIGINT, ForeignKey("estado.id", ondelete="RESTRICT") , nullable=False)
    municipio_id  = Column (BIGINT, ForeignKey("municipio.id", ondelete="RESTRICT") , nullable=False)
    created= Column (DATE, nullable=False)
    updated = Column (DATE, nullable=False)

    def to_dict(self):
        result = {
            'id' : self.id,
            'user_id'  : self.user_id,
            'direccion1' : self.direccion1,
            'direccion2'  : self.direccion2,
            'estado_id'   : self.estado_id,
            'municipio_id'  : self.municipio_id,
            'created'  : self.created,
            'updated'  : self.updated
        }
        return (result) 

