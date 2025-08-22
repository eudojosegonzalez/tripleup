'''
Este archivo contiene las funciones básicas del CRUD de Datos Geograficos
Created 2025-08
'''
import os
import re
import uuid
import io
import csv
import pdb
import asyncio

import base64
from PIL import Image

import asyncio


import uuid


from middleware.error_handler import ErrorHandler

from fastapi import File, UploadFile, Request
from fastapi.staticfiles import StaticFiles
import openpyxl
from controller.validaciones_user import ValidationController


# import all you need from fastapi-pagination
from sqlalchemy import select,text
from sqlalchemy.sql import literal_column
from sqlalchemy import or_,and_

import datetime
from datetime import timedelta


#Importamos los modeloas necesarios
from models.estado import Estado as EstadosModel
from models.municipio import Municipio as MunicipiosModel

from datetime import datetime,timedelta




# esto representa los metodos implementados en la tabla
class GeographicalController():
    # metodo constructor que requerira una instancia a la Base de Datos
    def __init__(self,db) -> None:
        self.db = db

    # obtener los estados registrados en sistema        
    def get_estados (self):

        try:       
            paso=1
            # buscamos si los datos personales del usuario existen 
            nRecordEstados=self.db.query(EstadosModel).count()
            if (nRecordEstados > 0):
                paso=2
                # existe podemos actualizar
                RecordEstados=self.db.query(EstadosModel).all()

                paso = 4
                # Creamos una lista vacía para almacenar los diccionarios
                lista_de_diccionarios = []
                
                paso = 5
                # Iteramos sobre cada objeto de la consulta
                for estado_obj in RecordEstados:
                    # Usamos el método to_dict() del modelo para convertir cada objeto a un diccionario
                    lista_de_diccionarios.append(estado_obj.to_dict())
                
                paso = 6
                # Asignamos la lista de diccionarios a la variable `data`
                data = lista_de_diccionarios                

                paso=7
                return ({"result":"1","estado":"Estados Encontrados","data":data})
            else:
                paso=11               
                return ({"result":"-1","estado":"No se han definido Estados en el sistema"})

        
        except ValueError as e:
            return( {"result":"-3","cadenaError": f"Error {str(e)} paso {paso}" })        
        

   # obtener los estados registrados en sistema        
    def get_municipios (self,id : int):

        try:       
            paso=1
            # buscamos si los datos personales del usuario existen 
            nRecordMunicipios=self.db.query(MunicipiosModel).filter(MunicipiosModel.estado_id==id).count()
            if (nRecordMunicipios > 0):
                paso=2
                # existe podemos actualizar
                RecordMunicipios=self.db.query(MunicipiosModel).filter(MunicipiosModel.estado_id==id).all()

                paso = 4
                # Creamos una lista vacía para almacenar los diccionarios
                lista_de_diccionarios = []
                
                paso = 5
                # Iteramos sobre cada objeto de la consulta
                for estado_obj in RecordMunicipios:
                    # Usamos el método to_dict() del modelo para convertir cada objeto a un diccionario
                    lista_de_diccionarios.append(estado_obj.to_dict())
                
                paso = 6
                # Asignamos la lista de diccionarios a la variable `data`
                data = lista_de_diccionarios                

                paso=7
                return ({"result":"1","estado":"Municipios Encontrados","data":data})
            else:
                paso=11               
                return ({"result":"-1","estado":"No se han definido Municipios paraa este Estado en el sistema"})

        
        except ValueError as e:
            return( {"result":"-3","cadenaError": f"Error {str(e)} paso {paso}" }) 