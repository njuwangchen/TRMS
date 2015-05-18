__author__ = 'ClarkWong,Justsavor'

from app import db, app
from flask.ext.restful import reqparse, abort, Api, Resource, fields, marshal_with, marshal
from models import *

api = Api(app)

tag_fields = {
    'id': fields.Integer,
    'name': fields.String,
    'type':fields.String
}


class TagApi(Resource):

    def __init__(self):
        self.parser = reqparse.RequestParser()
        self.parser.add_argument('id', type=int, location='json')
        self.parser.add_argument('name', type=unicode, location='json')
        self.parser.add_argument('type', type=unicode, location='json')
        super(TagApi,self).__init__()

    @marshal_with(tag_fields)
    def put(self,tag_id):
        args = self.parser.parse_args()
        tag = Tag.query.filter_by(id = tag_id).first()
        setattr(tag,'type',args['type'])
        setattr(tag,'name',args['name'])
        db.session.commit()

        return tag,201

class TagListApi(Resource):

    def __init__(self):
        self.parser = reqparse.RequestParser()
        self.parser.add_argument('name', type=unicode, required=True, location='json')
        self.parser.add_argument('type', type=unicode, required=True, location='json')

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
api.add_resource(TagApi, '/api/v1/tags/<tag_id>', endpoint='tag')