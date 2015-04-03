__author__ = 'ClarkWong, Justsavor'

from app import db, app
from flask.ext.restful import reqparse, abort, Api, Resource, fields, marshal_with, marshal
from models import *
api = Api(app)

type_fields = {
    'id': fields.Integer,
    'name': fields.String,
    'type_id': fields.Integer
}

class TypeApi(Resource):

    def __init__(self):
        self.parser = reqparse.RequestParser()
        self.parser.add_argument('name', type=unicode, required=True, location='json')
        self.parser.add_argument('type_id', type=int, required=True, location='json')
        super(TypeApi, self).__init__()

    @marshal_with(type_fields)
    def get(self, type_id):
        type_self = Type.query.filter_by(id=type_id).first()
        if type_self:
            return type_self, 201
        else:
            abort(404, message='Type {} not found'.format(type_id))

    def delete(self, type_id):
        type_self = Type.query.filter_by(id=type_id).first()
        if type_self:
            db.session.delete(type_self)
            db.session.commit()
            return { 'message' : 'Delete Type {} succeed'.format(type_id)}, 201
        else:
            abort(404, message='Type {} not found'.format(type_id))

    @marshal_with(type_fields)
    def put(self, type_id):
        type_self = Type.query.filter_by(id=type_id).first()
        if type_self:
            args = self.parser.parse_args()
            for k,v in args.iteritems():
                if v!= None:
                    setattr(type_self, k, v)
            return type_self, 201
        else:
            abort(404, message='Type {} not found'.format(type_id))

class TypeListApi(Resource):

    def __init__(self):
        self.parser = reqparse.RequestParser()
        self.parser.add_argument('name', type=unicode, required=True, location='json')
        self.parser.add_argument('type_id', type=int, required=True, location='json')
        super(TypeListApi, self).__init__()

    def get(self):
        typeList = Type.query.all()
        if typeList:
            return [marshal(type_self, type_fields) for type_self in typeList]
        else:
            abort(404, message='No Type at all')

    @marshal_with(type_fields)
    def post(self):
        args = self.parser.parse_args()
        name = args['name']
        type_id = args['type_id']
        type_self = Type(name, type_id)
        db.session.add(type_self)
        db.session.commit()
        return type, 201

class TypeQueryApi(Resource):
     def __init__(self):
        self.parser = reqparse.RequestParser()
        self.parser.add_argument('name', type=unicode, required=True, location='json')
        self.parser.add_argument('type_id', type=int, required=True, location='json')
        super(TypeQueryApi, self).__init__()

     def post(self):
        args = self.parser.parse_args()
        name = args['name']
        type_id = args['type_id']
        typeList = Type.query.filter_by(name=name, type_id=type_id)
        if typeList:
            return [marshal(type_self, type_fields) for type_self in typeList]
        else:
            abort(404, message='No such type at all')

api.add_resource(TypeApi, '/api/v1/types/<type_id>', endpoint='type')
api.add_resource(TypeListApi, '/api/v1/types', endpoint='typeList')
api.add_resource(TypeQueryApi, '/api/v1/types/query', endpoint='typeQuery')