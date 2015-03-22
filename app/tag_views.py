__author__ = 'ClarkWong,Justsavor'

from app import db, app
from flask.ext.restful import reqparse, abort, Api, Resource, fields, marshal_with, marshal
from models import *

api = Api(app)

tag_fields = {
    'id': fields.Integer,
    'name': fields.String
}

class TagApi(Resource):

    def __init__(self):
        self.parser = reqparse.RequestParser()
        self.parser.add_argument('name', type=str, required=True, locatio='json')
        super(TagApi,self).__init__()

    def delete(self, tag_id):
        tag = Tag.query.filter_by(id=tag_id).first()
        if tag:
            db.session.delete(tag)
            db.session.commit()
            return { 'message' : 'Delete Tag {} succeed'.format(tag_id)}, 201
        else:
            abort(404, message='Tag {} not found'.format(tag_id))

class TagListApi(Resource):

    def __init__(self):
        self.parser = reqparse.RequestParser()
        self.parser.add_argument('name', type=str, required=True, location='json')
        super(TagListApi,self).__init__()

    @marshal_with(tag_fields)
    def post(self):
        args = self.parser.parse_args()
        args = self.parser.parse_args()
        name = args['name']
        tag = Tag(name)
        db.session.add(tag)
        db.session.commit()
        return tag, 201

api.add_resource(TagApi, '/api/v1/cites/<tag_id>', endpoint='tag')
api.add_resource(TagListApi, '/api/v1/tags', endpoint='tagList')