'''
Modelo que define a la tabla Usuario
Esto se usa para el registro primario
Created 2026-06
'''
from config.database import Base
from sqlalchemy import Column,  VARCHAR, BIGINT, DATE, DateTime, Boolean, INTEGER, TEXT

# Definicion de una tabla
class ConfirmationUser(Base):
    __tablename__="confirmation_user"
    '''
        `id` bigint NOT NULL AUTO_INCREMENT,
        `username` varchar(150) NULL comment 'email del usuario',
        `body` text NULL comment 'email con el link de confirmación',
        `identificador` varchar(150) not null comment 'codigo unico de identificacion, usado para validar el email',
        `confirmado` int NOT NULL default '0' comment '0 no confirmado 1 confirmado',
        `created` datetime NOT NULL comment 'cuando se creo la conformación',
        `confirmated` datetime NULL comment 'cuando se confirmo el email del usuario' ,    
        PRIMARY KEY (`id`),
        unique (`username`),
        unique (`identificador`),    
        constraint `fk_usuario_confirmation_user` foreign key (id) references `user`(`id`)
        on update cascade on delete restrict
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci
    '''
    id = Column(BIGINT, primary_key=True, autoincrement=True)
    username = Column(VARCHAR(250), nullable=False) #varchar(250) NOT NULL,
    body = Column (TEXT, nullable=False)
    identificador  = Column(VARCHAR(150), nullable=False) #varchar(250) NOT NULL,
    confirmado = Column(INTEGER, nullable=False)   
    created = Column (DateTime, nullable=False) #datetime NOT NULL,    
    confirmated  = Column (DateTime, nullable=False)  #datetime NOT NULL,

    def to_dict(self):
        result = {
            "id":self.id,
            "username":self.username,
            "body":self.body,
            "identificador":self.identificador,
            "confirmado":self.confirmado,
            "created":self.created,
            "confirmated":self.confirmated

        }
        return (result) 
