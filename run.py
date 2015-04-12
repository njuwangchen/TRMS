from app import app
from flask.ext.cors import CORS
cors = CORS(app, resources=r'/api/*', allow_headers='Content-Type')

if __name__ == '__main__':
    app.run(debug = True)