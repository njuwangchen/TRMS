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
        return [marshal(tag, tag_fields) for tag in tagList]

class TagBatchApi(Resource):
    def __init__(self):
        self.parser = reqparse.RequestParser()
        self.parser.add_argument('ids', type=list, required=True, location='json')
        super(TagBatchApi,self).__init__()

    def post(self):
        args = self.parser.parse_args()
        ids = args['ids']
        q = Tag.query
        result = []
        for single in ids:
            tmp = q.filter_by(id = single)
            if tmp:
                result.append(tmp.first())

        return [marshal(tag, tag_fields) for tag in result]


api.add_resource(TagBatchApi, '/api/v1/tags/batch', endpoint='tagBatch')
api.add_resource(TagListApi, '/api/v1/tags', endpoint='tagList')