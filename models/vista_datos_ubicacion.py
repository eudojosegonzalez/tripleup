'''
Modelo que define a la tabla Usuario
Esto se usa para el registro primario
Created 2026-06
'''
from config.database import Base
from sqlalchemy import Column,  VARCHAR, BIGINT, DATE, DateTime, Boolean, INTEGER, ForeignKey, UniqueConstraint

# Definicion de una tabla
class VistaDatosUbicacion(Base):
    __tablename__="vista_ubicacion_usuario"
    '''
	id	bigint(20)
	user_id	bigint(20)
	direccion1	varchar(250)
	direccion2	varchar(250)
	estado_id	int(11)
	municipio_id	int(11)
	created	datetime
	updated	datetime
	nomestado	varchar(255)
	nommunicipio	varchar(255)

    '''
    id = Column(BIGINT, primary_key=True, autoincrement=True)
    user_id = Column (BIGINT, ForeignKey("usuario.id", ondelete="RESTRICT") , nullable=False)
    direccion1 = Column(VARCHAR(250), nullable=False)
    direccion2 = Column(VARCHAR(250), nullable=True)
    estado_id = Column (INTEGER, ForeignKey("estado.id", ondelete="RESTRICT") , nullable=False)
    municipio_id = Column (INTEGER, ForeignKey("municipio.id", ondelete="RESTRICT") , nullable=False)
    created = Column (DateTime, nullable=False) #datetime NOT NULL,    
    updated = Column (DateTime, nullable=False)  #datetime NOT NULL,
    nomestado = Column(VARCHAR(250), nullable=False)
    nommunicipio = Column(VARCHAR(250), nullable=False)

    def to_dict(self):
        result = {
            "id" : self.id,
            "user_id" : self.user_id,
            "direccion1": self.direccion1,
            "direccion2": self.direccion2,
            "estado_id":self.estado_id,
            "municipio_id":self.municipio_id,
            "created" : self.created,
            "updated" : self.updated,
            "nomestado":self.nomestado,
            "nommunicipio":self.nommunicipio
        }
        return (result) 
