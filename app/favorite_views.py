__author__ = 'ClarkWong'

from app import db, app
from flask.ext.restful import reqparse, abort, Api, Resource, fields, marshal_with, marshal
from models import *

api = Api(app)

favorite_fields = {
    'id': fields.Integer,
    'user_id': fields.Integer,
    'name': fields.String,
}

class favoriteListApi(Resource):

    def __init__(self):
        self.parser = reqparse.RequestParser()
        self.parser.add_argument('user_id', type=int, required=True, location='json')
        self.parser.add_argument('name', type=unicode, required=True, location='json')
        super(favoriteListApi, self).__init__()

    # add a new favorite
    # code finished
    # test finished
    @marshal_with(favorite_fields)
    def post(self):
        args = self.parser.parse_args()
        user_id = args['user_id']
        name = args['name']
        favorite = Favorite(user_id=user_id, name=name)
        db.session.add(favorite)
        db.session.commit()
        return favorite, 201

    # retrieve all favorites
    # code finished
    # test finished
    def get(self):
        favoriteList = Favorite.query.all()
        if favoriteList:
            return [marshal(favorite, favorite_fields) for favorite in favoriteList]
        else:
            abort(404, message='No Favorite at all')

api.add_resource(favoriteListApi, '/api/v1/favorites', endpoint='favoriteList')