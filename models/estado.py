'''
Modelo que define a la tabla Usuario
Esto se usa para el registro primario
Created 2026-06
'''
from config.database import Base
from sqlalchemy import Column,  VARCHAR, BIGINT, DATE, DateTime, Boolean, INTEGER

# Definicion de una tabla
class Estado(Base):
    __tablename__="estado"
    '''
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `nomestado` varchar(255) NOT NULL,
    PRIMARY KEY (`id`)
        '''
    id = Column(BIGINT, primary_key=True, autoincrement=True)
    nomestado = Column(VARCHAR(255), nullable=False) #varchar(250) NOT NULL,    

    def to_dict(self):
        result = {
            "id":self.id,
            "nomestado":self.nomestado,
        }
        return (result) 
