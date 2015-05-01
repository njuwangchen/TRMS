__author__ = 'ClarkWong'

from app import db, api
from flask.ext.restful import reqparse, abort, Resource, fields, marshal_with, marshal
from models import User


user_fields = {
    'id' : fields.Integer,
    'name' : fields.String,
    'password' : fields.String,
    'privilege' : fields.Integer,
    'countLiteratureCreated': fields.Integer,
    'countLiteratureUpdated': fields.Integer,
    'countDataSetCreated': fields.Integer,
    'countDataSetUpdated': fields.Integer,
    'countCodeCreated': fields.Integer,
    'countCodeUpdated': fields.Integer,
    'countReportCreated': fields.Integer,
    'countReportUpdated': fields.Integer,
    'countComment': fields.Integer
}

class UserApi(Resource):

    def __init__(self):
        self.parser = reqparse.RequestParser()
        self.parser.add_argument('name', type=unicode, location='json')
        self.parser.add_argument('password', type=unicode, location='json')
        self.parser.add_argument('privilege', type=int, location='json')

        super(UserApi, self).__init__()

    @marshal_with(user_fields)
    def get(self, user_id):
        user = User.query.filter_by(id=user_id).first()
        if user:
            return user, 201
        else:
            abort(404, message='User {} not found'.format(user_id))

    def delete(self, user_id):
        user = User.query.filter_by(id=user_id).first()
        if user:
            db.session.delete(user)
            db.session.commit()
            return { 'message' : 'Delete User {} succeed'.format(user_id)}, 201
        else:
            abort(404, message='User {} not found'.format(user_id))

    @marshal_with(user_fields)
    def put(self, user_id):
        user = User.query.filter_by(id=user_id).first()
        if user:
            args = self.parser.parse_args()
            for k,v in args.iteritems():
                if v!= None:
                    setattr(user, k, v)
            db.session.commit()
            return user, 201
        else:
            abort(404, message='User {} not found'.format(user_id))


class UserListApi(Resource):

    def __init__(self):
        self.parser = reqparse.RequestParser()
        self.parser.add_argument('name', type=unicode, required=True, location='json')
        self.parser.add_argument('password', type=unicode, required=True, location='json')
        self.parser.add_argument('privilege', type=int, required=True, location='json')
        self.parser.add_argument('countLiteratureCreated', type=int, location='json')
        self.parser.add_argument('countLiteratureUpdated', type=int, location='json')
        self.parser.add_argument('countDataSetCreated', type=int, location='json')
        self.parser.add_argument('countDataSetUpdated', type=int, location='json')
        self.parser.add_argument('countCodeCreated', type=int, location='json')
        self.parser.add_argument('countCodeUpdated', type=int, location='json')
        self.parser.add_argument('countReportCreated', type=int, location='json')
        self.parser.add_argument('countReportUpdated', type=int, location='json')
        self.parser.add_argument('countComment', type=int, location='json')
        super(UserListApi, self).__init__()

    def get(self):
        userList = User.query.all()
        if userList:
            for user in userList:
                user.countLiteratureCreated = 0
            return [marshal(user, user_fields) for user in userList]
        else:
            abort(404, message='No User at all')

    @marshal_with(user_fields)
    def post(self):
        args = self.parser.parse_args()
        name = args['name']
        password = args['password']
        privilege = args['privilege']
        user = User(name, password, privilege)
        db.session.add(user)
        db.session.commit()
        return user, 201

class UserLoginApi(Resource):
    def __init__(self):
        self.parser = reqparse.RequestParser()
        self.parser.add_argument('username', type=unicode, required=True, location='json')
        self.parser.add_argument('password', type=unicode, required=True, location='json')
        super(UserLoginApi,self).__init__()

    def post(self):
        args = self.parser.parse_args()
        print args
        q = User.query.filter_by(name=args['username']).first()
        if q:
            if q.password == args['password']:
                return q.id
            else:
                return 'FALSE'
        else:
            return 'FALSE'

api.add_resource(UserListApi, '/api/v1/users', endpoint='userList')
api.add_resource(UserApi, '/api/v1/users/<user_id>', endpoint='user')
api.add_resource(UserLoginApi,'/api/v1/users/login', endpoint='userLogin')