import smtplib
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText

import asyncio

# esto es el envio de mensaje
def sendMail(cuerpo : str, destinatario: str):
    try:
        paso=1000

        # enviamos el correo
        # Adjuntar el contenido HTML al mensaje
        # Configuración del mensaje
        paso=1001
        msg = MIMEMultipart('alternative')
        paso=1002
        msg['From'] = "info@tripleup.net"
        paso=1003
        msg['To'] = destinatario
        paso=1004
        msg['Subject'] = "🎉 ¡Bienvenido/a a TripleUP – Activa tu cuenta ahora!"

        paso=1005
        parte_html = MIMEText(cuerpo, 'html')
        paso=1006              
        msg.attach(parte_html)
        

        paso=1007
        smtp_server="eagle.mxlogin.com"
        paso=1008              
        smtp_port=587
        paso=1009
        remitente_email="info@tripleup.net"
        paso=1010
        remitente_password="D6ny5vebEGvbscdzdAp4"


        # Conexión al servidor SMTP
        paso=1011
        server = smtplib.SMTP(smtp_server, smtp_port)
        paso=1012
        server.starttls()  # Habilitar seguridad TLS
        paso=1013
        server.login(remitente_email, remitente_password) # Iniciar sesión
        paso=1014
        text = msg.as_string()
        paso=1015
        #server.sendmail(remitente_email, destinatario, parte_html) # Enviar correo
        failed_recipients=server.sendmail(remitente_email, destinatario, msg.as_string())
        #server.send_message(parte_html) # Enviar correo
        paso=1016
        server.quit() # Cerrar conexión

        paso=1017
        if not failed_recipients:
            return ({"result":"1","estado":"enviado"})  
        else:
             return( {"result":"-2","estado": "No se pudo enviar el email"})      
        
          
    except ValueError as e:
        return( {"result":"-3","estado": "Ocurrió un error","paso":paso})
    

def main():
    cuerpo = input("Introduce cuerpo: ")
    destinatario = input("Introduce destinatario: ")  
    
    resultado=sendMail (cuerpo,destinatario)
    
    print (resultado)



if __name__ == "__main__":
    main()
