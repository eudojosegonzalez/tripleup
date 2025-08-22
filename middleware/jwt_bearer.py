'''
Este archivo contiene las rutinas necesarias paraa el anejo del token de acceso del cliente
Created 2023-12
'''
from fastapi import Request,HTTPException
from fastapi.security import HTTPAuthorizationCredentials, HTTPBearer
from utils.jwt_managr import create_token,validate_token

# esta funcion valida el token antes de ejectuar operciones en la Base de Datos
class JWTBearer(HTTPBearer):
    # esto se agrega por que es una funcion asincrona que tiene un largo proceso de espera
    async def __call__(self, request: Request):
        auth = await super().__call__(request)
        data= validate_token (auth.credentials)
        if (not data):
            raise HTTPException(status_code=403,detail="Credenciales invalidas")