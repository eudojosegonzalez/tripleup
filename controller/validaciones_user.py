import re
from itertools import cycle
import datetime


class ValidationController():
    # metodo constructor que requerira una instancia a la Base de Datos
    def __init__(self,db) -> None:
        self.db = db

    # ---------------------------------------------------------------------
    # rutinas de validaciones 
    # ---------------------------------------------------------------------
        
        
    #funcion para validar que una cadena contenga caracteres válidos para nombres
    def validar_nombre(nombre):
        # Expresión regular para nombres
        patron = re.compile(r'^[a-zA-ZÁÉÍÓÚÑÜáéíóúñü ]+$')
        return patron.match(nombre) is not None    
    

    def validar_nombre2(nombre):
        # Patrón de regex que incluye letras mayúsculas y minúsculas, acentos, diéresis y virgulillas
        patron = r'^[a-zA-ZáéíóúÁÉÍÓÚñÑüÜäëïöäüöÄËÏÖÄÜÖ ]+$'
        
        # Utiliza el método match() para verificar si el nombre coincide con el patrón
        if re.match(patron, nombre):
            return True
        else:
            return False
    
    # funcion para validar el email    
    def validarEmail( email):
        """
        Valida si el valor es un email válido.

        Parámetros:
        email: El valor a validar.

        Retorno:
        True si el valor es un email válido, False en caso contrario.
        """
        expresion_regular = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*|\"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*\")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])"
        return re.match(expresion_regular, email) is not None          


    # funcion para validar las fechas
    def validar_fecha(fecha):
        try:
            # Convertir la cadena a un objeto datetime
            datetime.datetime.strptime(fecha, "%d/%m/%Y")
            return True
        except ValueError:
            return False


  
