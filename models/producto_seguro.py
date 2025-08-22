'''
Modelo que define a la tabla Usuario
Esto se usa para el registro primario
Created 2026-06
'''
from config.database import Base
from sqlalchemy import Column,  VARCHAR, BIGINT, DATE, DateTime, Boolean, INTEGER, ForeignKey, TEXT, FLOAT, NUMERIC

# Definicion de una tabla
class ProductoPoliza(Base):
    __tablename__="producto_poliza"
    '''
    `id` bigint(20) NOT NULL AUTO_INCREMENT,
    `nombre` varchar(150) NOT NULL,
    `aseguradora_id` bigint(20) NOT NULL,
    `tipo_poliza` varchar(150) NOT NULL,
    `montoCobertura` decimal(18,2) NOT NULL DEFAULT 0.00,
    `periodoPago` varchar(100) NOT NULL DEFAULT 'mensual',
    `rating` int(11) NOT NULL DEFAULT 0,
    `costo` decimal(13,4) NOT NULL,
    `precio` decimal(13,4) NOT NULL,
    `cuotas` decimal(13,4) NOT NULL,
    `estado` int(11) NOT NULL,
    `descripcion` text NOT NULL,
    `plazo_espera` varchar(250) NOT NULL,
    `imagen` varchar(250) DEFAULT NULL,
    `created` datetime NOT NULL,
    `updated` datetime NOT NULL,
    `creator_user` bigint(20) NOT NULL,
    `updater_user` bigint(20) NOT NULL,
    PRIMARY KEY (`id`),
    KEY `fk_aseguradora_producto` (`aseguradora_id`),
    CONSTRAINT `fk_aseguradora_producto` FOREIGN KEY (`aseguradora_id`) REFERENCES `aseguradora` (`id`) ON UPDATE CASCADE
    '''
    id = Column(BIGINT, primary_key=True, autoincrement=True)
    nombre = Column(VARCHAR(150), nullable=False) #varchar(250) NOT NULL,    
    aseguradora_id= Column (BIGINT, ForeignKey("aseguradora.id", ondelete="RESTRICT", onupdate="CASCADE"), nullable=False)  
    tipo_poliza = Column(VARCHAR(150), nullable=False) #NOT NULL,  
    montoCobertura = Column(NUMERIC(18,2), nullable=False)
    periodoPago =Column(VARCHAR(100), nullable=False) #NOT NULL,  
    rating = Column(INTEGER, nullable=False )
    costo = Column(NUMERIC(13,4), nullable=False)
    precio = Column(NUMERIC(13,4), nullable=False)
    cuotas = Column(NUMERIC(13,4), nullable=False)
    estado = Column(INTEGER , nullable=False)
    descripcion = Column(TEXT, nullable=False) #varchar(250) NOT NULL,  
    plazo_espera = Column(VARCHAR(250), nullable=False)
    imagen = Column (VARCHAR(250), nullable=True)
    created = Column (DateTime, nullable=False) #datetime NOT NULL,    T
    updated = Column (DateTime, nullable=False) #datetime NOT NULL,    T
    creator_user= Column (BIGINT, ForeignKey("usuario.id", ondelete="RESTRICT", onupdate="CASCADE"), nullable=False)  
    updater_user= Column (BIGINT, ForeignKey("usuario.id", ondelete="RESTRICT", onupdate="CASCADE"), nullable=False) 


    def to_dict(self):
        result = {
            "id ": self.id,
            "nombre" : self.nombre,
            "aseguradora_id" : self.aseguradora_id,
            "tipo_poliza" : self.tipo_poliza,
            "montoCobertura" : self.montoCobertura,
            "periodoPago" : self.periodoPago,
            "rating" : self.rating,
            "costo"  : self.costo,
            "precio" : self.precio,
            "cuotas" : self.cuotas,
            "estado" : self.estado,
            "descripcion" : self.descripcion,
            "plazo_espera" : self.plazo_espera,
            "created"  : self.created,
            "updated" : self.updated,
            "creator_user" : self.creator_user,
            "updater_user" : self.updater_user
        }
        return (result) 
