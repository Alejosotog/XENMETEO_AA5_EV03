# Importamos librerías necesarias
from flask import Flask, request, jsonify
from config import Config
from models import db, User
from flask_bcrypt import Bcrypt

# Creamos la aplicación Flask
app = Flask(__name__)
app.config.from_object(Config)

# Inicializamos base de datos
db.init_app(app)

# Inicializamos bcrypt para encriptar contraseñas
bcrypt = Bcrypt(app)

# Creamos la base de datos si no existe
with app.app_context():
    db.create_all()

# -----------------------------------------
# ENDPOINT: Registro de usuario
# -----------------------------------------
@app.route('/api/xenmeteo/register', methods=['POST'])
def register():
    """
    Permite registrar un nuevo usuario en Xenmeteo.
    """

    data = request.get_json()

    username = data.get('username')
    email = data.get('email')
    password = data.get('password')

    # Validación básica
    if not username or not email or not password:
        return jsonify({"error": "Todos los campos son obligatorios"}), 400

    # Verificar si ya existe el usuario
    if User.query.filter_by(username=username).first():
        return jsonify({"error": "El usuario ya existe"}), 400

    # Encriptar contraseña
    hashed_password = bcrypt.generate_password_hash(password).decode('utf-8')

    # Crear nuevo usuario
    new_user = User(username=username, email=email, password=hashed_password)

    db.session.add(new_user)
    db.session.commit()

    return jsonify({"message": "Usuario registrado exitosamente en Xenmeteo"}), 201


# -----------------------------------------
# ENDPOINT: Login
# -----------------------------------------
@app.route('/api/xenmeteo/login', methods=['POST'])
def login():
    """
    Permite autenticar un usuario en Xenmeteo.
    """

    data = request.get_json()

    username = data.get('username')
    password = data.get('password')

    user = User.query.filter_by(username=username).first()

    # Validar credenciales
    if user and bcrypt.check_password_hash(user.password, password):
        return jsonify({
            "message": "Autenticación satisfactoria",
            "usuario": username
        }), 200
    else:
        return jsonify({"error": "Error en la autenticación"}), 401


# Ejecutar servidor
if __name__ == '__main__':
    app.run(debug=True)
