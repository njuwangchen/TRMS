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
        self.parser.add_argument('favorite_time', required=True, location='json')
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
        favorite_resource = Favorite_resource(resource_id=resource_id, type=type_data, favorite_id=favorite_id,favorite_time = args['favorite_time'])
        db.session.add(favorite_resource)
        db.session.commit()
        return favorite_resource, 201

api.add_resource(favorite_resourceApi, '/api/v1/favorite_resources', endpoint='favorite_resource')

class favorite_resourceQuery(Resource):
    def __init__(self):
        self.parser = reqparse.RequestParser()
        self.parser.add_argument('resource_id', type=int, location='json')
        self.parser.add_argument('type', type=int,location='json')
        self.parser.add_argument('favorites', type=list, location='json')
        super(favorite_resourceQuery,self).__init__()

    def post(self):
        args = self.parser.parse_args()
        q = Favorite_resource.query
        qList = [];
        for k,v in args.items():
            if v:
                if k == 'favorites':
                    for each in v:
                        for innerq in q.filter(getattr(Favorite_resource,'favorite_id') == (each['id'])).all():
                            qList.append(innerq)
                else:
                    q = q.filter(getattr(Favorite_resource, k) == v)
        type_list = [marshal(favorite_resource,favorite_resource_fields) for favorite_resource in q.all()]
        qList = [marshal(favorite_resource,favorite_resource_fields) for favorite_resource in qList]
        result = [];
        for element in type_list:
            for inner_element in qList:
                if element['id'] == inner_element['id']:
                    result.append(element)
        res_id_list = [i['resource_id'] for i in result]
        res_id_list = list(set(res_id_list))

        return res_id_list


api.add_resource(favorite_resourceQuery,'/api/v1/favorite_resource/query', endpoint='favorite_resourceQuery')