__author__ = 'ClarkWong'

from app import db, app
from flask.ext.restful import reqparse, abort, Api, Resource, fields, marshal_with, marshal
from models import *
from data_set_views import data_set_fields

api = Api(app)

data_set_literature_fields = {
    'data_set_id' : fields.Integer,
    'literature_id' : fields.Integer,
}

class data_set_literatureDel(Resource):
    def __init__(self):
        self.parser = reqparse.RequestParser()
        self.parser.add_argument('code_id', type=int, required=True,location='json')
        self.parser.add_argument('literature_id', type=int, required=True, location='json')
        super(data_set_literatureDel, self).__init__()


    def post(self):
        args = self.parser.parse_args()
        literature = Literature_meta.query.filter_by(id=args['literature_id']).first()
        data_set = Data_set.query.filter_by(id=args['data_set_id']).first()
        literature.codes.remove(data_set)
        db.session.commit()
        return "delete success" , 201

class data_set_literatureListApi(Resource):

    def __init__(self):
        self.parser = reqparse.RequestParser()
        self.parser.add_argument('data_set_id', type=int,required=True, location='json')
        self.parser.add_argument('literature_id', type=int, required=True,location='json')
        super(data_set_literatureListApi, self).__init__()

    # add a data_set_literature
    # code unfinished because data_set_views is undefined
    # test unfinished
    def post(self):
        args = self.parser.parse_args()
        data_set_id = args['data_set_id']
        literature_id = args['literature_id']
        literature = Literature_meta.query.filter_by(id=literature_id).first()
        data_set = Data_set.query.filter_by(id=data_set_id).first()
        literature.data_sets.append(data_set)
        db.session.commit()
        return "add success" , 201

class data_set_literatureQueryApi(Resource):
    def __init__(self):
        self.parser = reqparse.RequestParser()
        self.parser.add_argument('data_set_id', type=int, location='json')
        self.parser.add_argument('literature_id', type=int, required=True, location='json')
        super(data_set_literatureQueryApi, self).__init__()

    # retrieve specific data_set_literatures
    # code unfinished
    # test unfinished
    def post(self):
        args = self.parser.parse_args()
        literature = Literature_meta.query.filter_by(id=args['literature_id']).first()
        if literature:
            data_sets = [marshal(x, data_set_fields) for x in literature.data_sets]
            return data_sets
        else:
            abort(404, message='No data_set_literature at all')

api.add_resource(data_set_literatureDel, '/api/v1/data_set_literature/', endpoint='data_set_literature')
api.add_resource(data_set_literatureQueryApi, '/api/v1/data_set_literature/query', endpoint='data_set_literatureQuery')