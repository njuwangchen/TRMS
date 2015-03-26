__author__ = 'ClarkWong'

from app import db, app
from flask.ext.restful import reqparse, abort, Api, Resource, fields, marshal_with, marshal
from models import *

api = Api(app)

favorite_resource_fields = {
    'id': fields.Integer,
    'resource_id': fields.Integer,
    'type': fields.Integer,
    'favorite_id': fields.Integer
}

class favorite_resourceApi(Resource):

    def __init__(self):
        self.parser = reqparse.RequestParser()
        self.parser.add_argument('resource_id', type=int, required=True, location='json')
        self.parser.add_argument('type', type=int, required=True, location='json')
        self.parser.add_argument('favorite_id', type=int, required=True, location='json')
        super(favorite_resourceApi, self).__init__()

    # add a new favorite_resource
    # code finished
    # test finished
    @marshal_with(favorite_resource_fields)
    def post(self):
        args = self.parser.parse_args()
        resource_id = args['resource_id']
        type_data = args['type']
        favorite_id = args['favorite_id']
        favorite_resource = Favorite_resource(resource_id=resource_id, type=type_data, favorite_id=favorite_id)
        db.session.add(favorite_resource)
        db.session.commit()
        return favorite_resource, 201

api.add_resource(favorite_resourceApi, '/api/v1/favorite_resource', endpoint='favorite_resource')