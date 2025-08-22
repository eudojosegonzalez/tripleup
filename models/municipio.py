'''
Modelo que define a la tabla Usuario
Esto se usa para el registro primario
Created 2026-06
'''
from config.database import Base
from sqlalchemy import Column,  VARCHAR, BIGINT, DATE, DateTime, Boolean, INTEGER, ForeignKey

# Definicion de una tabla
class Municipio(Base):
    __tablename__="municipio"
    '''
    `id` int(11) NOT NULL,
    `estado_id` int(11) NOT NULL,
    `nommunicipio` varchar(255) NOT NULL,
    PRIMARY KEY (`id`,`estado_id`),
    KEY `IDX_FE98F5E09F5A440B` (`estado_id`),
    CONSTRAINT `FK_FE98F5E09F5A440B` FOREIGN KEY (`estado_id`) REFERENCES `estado` (`id`)
        '''
    id = Column(BIGINT, primary_key=True, autoincrement=True)
    estado_id = Column(BIGINT, ForeignKey("estado.id", ondelete="RESTRICT") , nullable=False)
    nommunicipio = Column(VARCHAR(255), nullable=False) #varchar(250) NOT NULL,    

    def to_dict(self):
        result = {
            "id":self.id,
            "estado_id":self.estado_id,
            "nommunicipio":self.nommunicipio,
        }
        return (result) 
