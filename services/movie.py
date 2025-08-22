from models.movie import Movie as MovieModel
from schemas.movie import Movie

# esto representa los metodos implementados en la tabla
class MovieService():
    # metodo constructor que requerira una instancia a la Base de Datos
    def __init__(self,db) -> None:
        self.db = db

    # metodo para consultar todas las peliculas usando un servicio
    def get_movies(self):
        result= self.db.query(MovieModel).all()
        return result
    
    #metodo para consultar por Id
    def get_movie(self, id):
        result= self.db.query(MovieModel).filter(MovieModel.id==id).first()
        return result   

    #metodo para consultar por categoria
    def get_movie_category(self, category):
        result= self.db.query(MovieModel).filter(MovieModel.category==category).all()
        return result  
    
    #metodo para insertar datos    
    def create_movie(self, movie:Movie):
        new_movie=MovieModel(**movie.dict())
        self.db.add(new_movie)
        self.db.commit()
        return
    
    #metodo para actualizar datos
    def update_movie (self, id: int, data : Movie ):
        movie = self.db.query(MovieModel).filter(MovieModel.id==id).first()
        movie.title=data.title
        movie.year=data.year
        movie.overview=data.overview
        movie.rating=data.rating
        movie.category=data.category
        self.db.commit()
        return
    
    # metodo para eliminar una pelicula
    def delete_movie (self, id : int):
        #forma 1
        # result= self.db.query(MovieModel).filter(MovieModel.id==id).first()
        # self.db.delete(result)

        #forma 2
        result= self.db.query(MovieModel).filter(MovieModel.id==id).delete()
        self.db.commit()
        return
        


    