__author__ = 'ClarkWong'

from flask import Flask
from flask.ext.sqlalchemy import SQLAlchemy
from flask.ext.cors import CORS

app = Flask(__name__)
app.config.from_object('config')

db = SQLAlchemy(app)
cor = CORS(app, allow_headers='Content-Type')

from app import models