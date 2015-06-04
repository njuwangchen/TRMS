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

class favoriteApi(Resource):

    def __init__(self):
        self.parser = reqparse.RequestParser()
        self.parser.add_argument('user_id', type=int, location='json')
        self.parser.add_argument('name', type=unicode, location='json')
        super(favoriteApi, self).__init__()

    def delete(self,favorite_id):
        favorite = Favorite.query.filter_by(id=favorite_id).first()
        fav_res = Favorite_resource.query.filter_by(favorite_id=favorite_id).all()
        if favorite:
            db.session.delete(favorite)
            for favr in fav_res:
                db.session.delete(favr)
            db.session.commit()
            return 201
        else:
            abort("not found",404)

    @marshal_with(favorite_fields)
    def put(self,favorite_id):
        args = self.parser.parse_args()
        favorite = Favorite.query.filter_by(id=favorite_id).first()
        favorite.name = args['name']
        db.session.commit()
        return favorite,201



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

class favoriteQuery(Resource):

    def __init__(self):
        self.parser = reqparse.RequestParser()
        self.parser.add_argument('user_id', type=int, location='json')
        self.parser.add_argument('name', type=unicode, location='json')
        super(favoriteQuery, self).__init__()


    def post(self):
        args = self.parser.parse_args()
        q = Favorite.query
        for attr, value in args.items():
            if value:
                q = q.filter(getattr(Favorite, attr).like("%%%s%%" % value))
        if q:
            return [marshal(favor,favorite_fields) for favor in q],201
        else:
            abort(404,message='favorites not found')

api.add_resource(favoriteListApi, '/api/v1/favorites', endpoint='favoriteList')
api.add_resource(favoriteQuery,'/api/v1/favorites/query', endpoint='favoriteQuery')
api.add_resource(favoriteApi,'/api/v1/favorites/<favorite_id>',endpoint="favoriteApi")