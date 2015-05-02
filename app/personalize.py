__author__ = 'BAO'
from app import db, api
from flask.ext.restful import reqparse, abort, Resource, fields, marshal_with, marshal
from models import Personalized

personalize_fields = {
    "id":fields.Integer,
    "user_id":fields.Integer,
    "literature_id":fields.Integer,
    "uri":fields.String
}


class PersonalizeListApi(Resource):
    def __init__(self):
        self.parser = reqparse.RequestParser()
        self.parser.add_argument('user_id', type=int, location='json')
        self.parser.add_argument('literature_id', type=int, location='json')
        super(PersonalizeListApi, self).__init__()


    @marshal_with(personalize_fields)
    def post(self):
        args = self.parser.parse_args()
        q = Personalized.query.filter_by(user_id = args['user_id'],literature_id = args['literature_id']).first()
        return q,201;

api.add_resource(PersonalizeListApi, '/api/v1/personalize', endpoint='personalizeList')


class PersonalizeQueryApi(Resource):
     def __init__(self):
        self.parser = reqparse.RequestParser()
        self.parser.add_argument('user_id', type=int, location='json')
        self.parser.add_argument('literature_id', type=int, location='json')
        super(PersonalizeQueryApi, self).__init__()

     @marshal_with(personalize_fields)
     def post(self):
        args = self.parser.parse_args()
        q = Personalized.query
        for attr, value in args.items():
            if value:
                q = q.filter(getattr(Personalized, attr).like("%%%s%%" % value))

        return q.first(),201

api.add_resource(PersonalizeQueryApi, '/api/v1/personalize/query', endpoint='personalizeQuery')
