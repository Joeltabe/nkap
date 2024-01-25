from flask import Flask
from firebase_admin import credentials,initialize_app

cred = credentials.Certificate("api/key.json")
default_app = initialize_app(cred)

def create_app():
    app = Flask(__name__)
    app.config['SECRET_KEY'] = '123abcdef'


    from.signup import signup
    from.login import login


    app.register_blueprint(login, url_prefix='/users')
    app.register_blueprint(signup, url_prefix='/users')

    return app
