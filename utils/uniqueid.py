import hashlib
import random

def generar_codigo_desde_email(email):
    """
    Genera un hash MD5 de un correo electrónico y lo convierte en una
    cadena alfanumérica de 10 caracteres (mayúsculas y números).
    """
    if not isinstance(email, str):
        raise TypeError("La entrada debe ser una cadena de texto (string).")
    if not email:
        raise ValueError("El correo electrónico no puede estar vacío.")

    # 1. Convertir el correo electrónico a su hash MD5
    # Los hashes MD5 siempre son de 32 caracteres hexadecimales.
    md5_hash = hashlib.sha256(email.lower().encode('utf-8')).hexdigest()

    # 2. Mapear caracteres hexadecimales a alfanuméricos (0-9, A-Z)
    # y seleccionar 10 caracteres del hash para formar la cadena.
    
    # Define los caracteres válidos para el código final
    caracteres_validos = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    
    codigo_resultante = ""
    
    # Usaremos una parte del hash MD5 para obtener los 10 dígitos.
    # El MD5 es de 32 caracteres. Podemos usar los primeros 10, o los últimos,
    # o una combinación. Para asegurar que siempre obtengamos 10 caracteres,
    # tomaremos los primeros 10 y los "mapearemos" a nuestro conjunto de caracteres válidos.
    
    # Iterar sobre los primeros 10 caracteres del hash MD5
    for i in range(12):
        # Tomar el valor numérico del carácter hexadecimal
        # Por ejemplo, 'a' es 10, 'f' es 15. '0' es 0, '9' es 9.
        valor_hex = int(md5_hash[i], 16)
        
        # Mapear este valor a un índice dentro de nuestros caracteres_validos (0-35)
        # Usamos el operador módulo para asegurar que el índice esté dentro del rango.
        indice = valor_hex % len(caracteres_validos)
        
        codigo_resultante += caracteres_validos[indice]
            
    return codigo_resultante

# --- Ejemplo de uso ---
if __name__ == "__main__":
    
    correos_prueba = [
        "ejemplo@dominio.com",
        "otro.usuario@servicio.net",
        "mi_nombre.apellido@mail.co.uk",
        "prueba123@xyz.org",
        "contacto@empresa.com",
        "ejemplo@dominio.com" ,# Para demostrar que el mismo email da el mismo código
        "eudojosegonzalez@gmail.com",
        "eudojosegonzalez@hotmail.com",
        "xarcx2@gmail.com"        
    ]

    print("--- Generando Códigos Alfanuméricos desde Correos ---")
    for email in correos_prueba:
        try:
            codigo = generar_codigo_desde_email(email)
            print(f"Correo: {email:<30} -> Código: {codigo}")
        except (TypeError, ValueError) as e:
            print(f"Error con correo '{email}': {e}")
    
    print("\n--- Probando con entrada inválida ---")
    try:
        generar_codigo_desde_email(12345)
    except (TypeError, ValueError) as e:
        print(f"Error esperado al usar un número: {e}")
    
    try:
        generar_codigo_desde_email("")
    except (TypeError, ValueError) as e:
        print(f"Error esperado al usar una cadena vacía: {e}")