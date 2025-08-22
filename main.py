#importamos la libreria para cargar los archivos de entorno
import dotenv


#importamos FASTAIP
import ssl
import sys
from fastapi import FastAPI
from fastapi.responses import  RedirectResponse
from fastapi.middleware.cors import CORSMiddleware


#Importamos los archivos de conforuracion de la base de datos
from config.database import engine, Base

#importamos el routers
from routers.user import user_router
from routers.admin_dashboard import admin_dashboarad_router
from routers.geographical import geographical_router
#from routers.callcenter import callcenter_router


#importamos el manejador de errores
from middleware.error_handler import ErrorHandler

#descripcion de los endpoints
tags_metadata = [
       {
        "name": "Auth",
        "description": "Operaciones de validación de usuario y generación de tokens",
    },
    {
        "name": "CallCenter",
        "description": "Operaciones relacionados con el call center",
    },  
    {
        "name": "Dashboard",
        "description": "Operaciones relacionados con el Dashboard del administrador",
    },  
    {
        "name": "Affiliate",
        "description": "Operaciones relacionados con los afiliados del sistema",
    },   
    {
        "name": "Geographical",
        "description": "Operaciones relacionados con los datos geográficos del sistema",
    },            
]

#cargamos las variables de entorno
dotenv.load_dotenv()

#Cargamos la documentacion de las rutas
app = FastAPI(openapi_tags=tags_metadata,debug=True)
app.title='TripleUp'
app.version='V1.0'


ssl_context = ssl.SSLContext(ssl.PROTOCOL_TLS_SERVER)
ssl_context.load_cert_chain('cert.pem', keyfile='privkey.pem')


# manejador de errores
app.add_middleware(ErrorHandler)

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
	allow_credentials=True,
	allow_methods=["*"],
	allow_headers=["*"],
	expose_headers=["*"],
	max_age=3600,
)

#inclusión de los endpoints
app.include_router(user_router)
app.include_router(admin_dashboarad_router)
app.include_router(geographical_router)
#app.include_router(callcenter_router)



# esto crea la base de datos si no existe al empezar la app
Base.metadata.create_all(bind=engine)


@app.get('/',tags=['Home'])
def home():
    # redireccionamos a la documentación de la API
    return RedirectResponse("/docs")


