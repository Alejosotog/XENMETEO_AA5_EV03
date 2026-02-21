from flask_sqlalchemy import SQLAlchemy

# Creamos la instancia de base de datos
db = SQLAlchemy()

# Modelo Usuario para Xenmeteo
class User(db.Model):
    """
    Modelo que representa un usuario del sistema Xenmeteo
    """
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(100), unique=True, nullable=False)
    email = db.Column(db.String(120), unique=True, nullable=False)
    password = db.Column(db.String(200), nullable=False)      