__author__ = 'ClarkWong'

from flask import Flask
from flask.ext.sqlalchemy import SQLAlchemy
from flask.ext.cors import CORS
from flask.ext.restful import Api

app = Flask(__name__)
app.config.from_object('config')

db = SQLAlchemy(app)
cor = CORS(app, allow_headers='Content-Type')

api = Api(app)

from app import models
from app import attribute_views, cite_views, code_literature_views, code_views, comment_views, data_set_literature_views, data_set_views, favorite_resource_views, favorite_views, literature_meta_views, ppt_views, tag_resource_views, tag_views, type_views, user_views, video_views, upload_views, report_views, report_attachment_views, report_recording_views