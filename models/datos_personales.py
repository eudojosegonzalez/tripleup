'''
Modelo que define a la tabla Usuario
Esto se usa para el registro primario
Created 2026-06
'''
from config.database import Base
from sqlalchemy import Column,  VARCHAR, BIGINT, DATE, DateTime, Boolean, INTEGER, ForeignKey, UniqueConstraint

# Definicion de una tabla
class DatosPersonales(Base):
    __tablename__="datos_personales"
    '''
CREATE TABLE tripleup.`datos_personales` (
	`id` bigint(20) NOT NULL AUTO_INCREMENT,
	`user_id` bigint(20) NOT NULL,
	`nac`  varchar(1) not null,
	`numero` varchar(30) not null,
	`identidad` varchar(1) not null,
	`apellido` varchar(100) not null,
	`nombre` varchar(100) not null,
	`fecha_nac`  date not null,
	`sexo` int not null,
	`created` datetime NOT NULL,
	`updated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `usuario_datos_personales` (`user_id`),
  unique (`nac`,`identificacion`),
  CONSTRAINT `usuario_datos_personales` FOREIGN KEY (`user_id`) REFERENCES `usuario` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Tabla de datos personales del usuario';

    '''
    id = Column(BIGINT, primary_key=True, autoincrement=True)
    user_id = Column (BIGINT, ForeignKey("usuario.id", ondelete="RESTRICT") , nullable=False)
    nac = Column(VARCHAR(1), nullable=False)
    numero = Column(VARCHAR(30), nullable=False)
    identidad =Column(VARCHAR(1),nullable=False)
    apellido =Column(VARCHAR (100), nullable=False)
    nombre =Column(VARCHAR (100), nullable=False)
    fecha_nac = Column(DATE, nullable=False)
    sexo =Column(INTEGER, nullable=False)
    created = Column (DateTime, nullable=False) #datetime NOT NULL,    
    updated = Column (DateTime, nullable=False)  #datetime NOT NULL,

    def to_dict(self):
        result = {
            "id" : self.id,
            "user_id" : self.user_id,
            "nac":self.nac,
            "numero":self.numero,
            "identidad": self.identidad,
            "apellido" : self.apellido,
            "nombre" : self.nombre,
            "fecha_nac" : self.fecha_nac,
            "sexo" : self.sexo,
            "created" : self.created,
            "updated" : self.updated
        }
        return (result) 

    # Definimos las restricciones de la tabla aquí
    __table_args__ = (UniqueConstraint('nac', 'numero', name='_nac_numero_uc'),)