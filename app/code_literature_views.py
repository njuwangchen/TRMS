__author__ = 'ClarkWong'

from app import db, api
from flask.ext.restful import reqparse, abort, Resource, fields, marshal_with, marshal
from models import *
from code_views import code_fields
from flask import jsonify


code_literature_fields={
    "code_id":fields.Integer,
    "literature_id":fields.Integer
}



class code_literatureListApi(Resource):

    def __init__(self):
        self.parser = reqparse.RequestParser()
        self.parser.add_argument('code_id', type=int,required=True, location='json')
        self.parser.add_argument('literature_id', type=int, required=True,location='json')
        super(code_literatureListApi, self).__init__()

    def post(self):
        args = self.parser.parse_args()
        code_id = args['code_id']
        literature_id = args['literature_id']
        literature = Literature_meta.query.filter_by(id=literature_id).first()
        code = Code.query.filter_by(id = code_id).first()
        literature.codes.append(code)
        db.session.commit()
        return "add success" , 201


class code_literatureQuery(Resource):
    def __init__(self):
        self.parser = reqparse.RequestParser()
        self.parser.add_argument('code_id', type=int, location='json')
        self.parser.add_argument('literature_id', type=int, required=True, location='json')
        super(code_literatureQuery, self).__init__()


    def post(self):
        args = self.parser.parse_args()
        literature = Literature_meta.query.filter_by(id = args['literature_id']).first()
        if literature:
            codes = [marshal(x,code_fields) for x in literature.codes]
            return codes

        else:
            abort(404, message='No code_literature at all')

class code_literatureDel(Resource):
    def __init__(self):
        self.parser = reqparse.RequestParser()
        self.parser.add_argument('code_id', type=int, required=True,location='json')
        self.parser.add_argument('literature_id', type=int, required=True, location='json')
        super(code_literatureDel, self).__init__()


    def post(self):
        args = self.parser.parse_args()
        literature = Literature_meta.query.filter_by(id=args['literature_id']).first()
        code = Code.query.filter_by(id=args['code_id']).first()
        literature.codes.remove(code)
        db.session.commit()
        return "delete success" , 201





api.add_resource(code_literatureQuery, '/api/v1/code_literatures/query', endpoint='code_literaturequery')
api.add_resource(code_literatureListApi, '/api/v1/code_literatures', endpoint='code_literatureList')
api.add_resource(code_literatureDel, '/api/v1/code_literatures/del', endpoint='code_literaturedel')
