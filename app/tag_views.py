__author__ = 'ClarkWong,Justsavor'

from app import db, app
from flask.ext.restful import reqparse, abort, Api, Resource, fields, marshal_with, marshal
from models import *

api = Api(app)

tag_fields = {
    'id': fields.Integer,
    'name': fields.String
}

class TagListApi(Resource):

    def __init__(self):
        self.parser = reqparse.RequestParser()
        self.parser.add_argument('name', type=unicode, required=True, location='json')
        super(TagListApi,self).__init__()

    def get(self):
        tagList = Tag.query.all()
        if tagList:
            return [marshal(tag, tag_fields) for tag in tagList]
        else:
            abort(404, message='No Tag at all')


api.add_resource(TagListApi, '/api/v1/tags', endpoint='tagList')