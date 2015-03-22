__author__ = 'ClarkWong'

from app import db, api
from flask.ext.restful import reqparse, abort, Resource, fields, marshal_with, marshal
from models import Code


code_fields={
    'id' : fields.Integer,
    'title': fields.String,
    'creator_id': fields.Integer,
    'updater_id': fields.Integer,
    'create_time': fields.DateTime,
    'update_time': fields.DateTime,
    'description': fields.String,
    'size': fields.Float,
    'uri': fields.String,
    'language': fields.String
}

class CodeApi(Resource):

    def __init__(self):
        self.parser = reqparse.RequestParser()
        self.parser.add_argument('title', type=str,location='json')
        self.parser.add_argument('creator_id', type=int,required=True,location='json')
        self.parser.add_argument('updater_id', type=int,required=True,location='json')
        self.parser.add_argument('creator_time',required=True,location='json')
        self.parser.add_argument('update_time', location='json')
        self.parser.add_argument('description', type=str,location='json')
        self.parser.add_argument('size', type=float,location='json')
        self.parser.add_argument('uri', type=str,required=True,location='json')
        self.parser.add_argument('language', type=str,location='json')
        super(CodeApi, self).__init__()

    @marshal_with(code_fields)
    def get(self, code_id):
        code = Code.query.filter_by(id=code_id).first()
        if code:
            return code, 201
        else:
            abort(404, message='Code {} not found'.format(code_id))

    def delete(self, code_id):
        code = Code.query.filter_by(id=code_id).first()
        if code:
            db.session.delete(code)
            db.session.commit()
            return { 'message' : 'Delete Code {} succeed'.format(code_id)}, 201
        else:
            abort(404, message='Code {} not found'.format(code_id))

    @marshal_with(code_fields)
    def put(self, code_id):
        code = Code.query.filter_by(id=code_id).first()
        if code:
            args = self.parser.parse_args()
            for k,v in args.iteritems():
                if v!= None:
                    setattr(code, k, v)
            db.session.commit()
            return code, 201
        else:
            abort(404, message='Code {} not found'.format(code_id))

class CodeListApi(Resource):

    def __init__(self):
        self.parser = reqparse.RequestParser()
        self.parser.add_argument('title', type=str,location='json')
        self.parser.add_argument('creator_id', type=int,required=True,location='json')
        self.parser.add_argument('updater_id', type=int,required=True,location='json')
        self.parser.add_argument('creator_time',required=True,location='json')
        self.parser.add_argument('update_time', location='json')
        self.parser.add_argument('description', type=str,location='json')
        self.parser.add_argument('size', type=float,location='json')
        self.parser.add_argument('uri', type=str,required=True,location='json')
        self.parser.add_argument('language', type=str,location='json')
        super(CodeListApi, self).__init__()

    def get(self):
        codeList = Code.query.all()
        if codeList:
            return [marshal(code, code_fields) for code in codeList]
        else:
            abort(404, message='No Code at all')
#    def __init__(self, codeer, code_time, star, resource_id, type, content=''):

    @marshal_with(code_fields)
    def post(self):
        args = self.parser.parse_args()
        title = args['title']
        creator_id = args['creator_id']
        updater_id = args['updater_id']
        creator_time = args['creator_time']
        update_time = args['update_time']
        description = args['description']
        size = args['size']
        uri = args['uri']
        language = args['language']
        code = Code(title, creator_id, creator_time, updater_id, update_time, description, size, uri, language)
        db.session.add(code)
        db.session.commit()
        return code, 201

class CodeQuery(Resource):
    def __init__(self):
        self.parser = reqparse.RequestParser()
        self.parser.add_argument('creator_id', type=int,required=True,location='json')
        self.parser.add_argument('update_id', type=int,required=True,location='json')
        super(CodeQuery, self).__init__()


    def post(self):
        args = self.parser.parse_args()
        creator_id = args['creator_id']
        update_id = args['update_id']
        codeList = Code.query.filter_by(update_id=update_id,creator_id=creator_id)
        if codeList:
            return [marshal(code, code_fields) for code in codeList]
        else:
            abort(404, message='No code at all')


api.add_resource(CodeQuery, '/api/v1/codes/query', endpoint='codequery')
api.add_resource(CodeListApi, '/api/v1/codes', endpoint='codeList')
api.add_resource(CodeApi, '/api/v1/codes/<code_id>', endpoint='code')