__author__ = 'ClarkWong'

from app import db, api
from flask.ext.restful import reqparse, abort, Resource, fields, marshal_with, marshal
from models import Code


code_fields={
    'id' : fields.Integer,
    'title': fields.String,
    'creator_id': fields.Integer,
    'updater_id': fields.Integer,
    'create_time': fields.String,
    'update_time': fields.String,
    'description': fields.String,
    'size': fields.Float,
    'uri': fields.String,
    'language': fields.String
}

class CodeApi(Resource):

    def __init__(self):
        self.parser = reqparse.RequestParser()
        self.parser.add_argument('title', type=unicode,required=True,location='json')
        self.parser.add_argument('creator_id', type=int,required=True,location='json')
        self.parser.add_argument('updater_id', type=int,location='json')
        self.parser.add_argument('create_time',required=True,location='json')
        self.parser.add_argument('update_time', location='json')
        self.parser.add_argument('description', type=unicode,location='json')
        self.parser.add_argument('size', type=float,location='json')
        self.parser.add_argument('uri', type=unicode,location='json')
        self.parser.add_argument('language', type=unicode,location='json')
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
        self.parser.add_argument('title', type=unicode,required=True,location='json')
        self.parser.add_argument('creator_id', type=int,required=True,location='json')
        self.parser.add_argument('updater_id', type=int,location='json')
        self.parser.add_argument('create_time',required=True,location='json')
        self.parser.add_argument('update_time', location='json')
        self.parser.add_argument('description', type=unicode,location='json')
        self.parser.add_argument('size', type=float,location='json')
        self.parser.add_argument('uri', type=unicode,location='json')
        self.parser.add_argument('language', type=unicode,location='json')
        super(CodeListApi, self).__init__()

    def get(self):
        codeList = Code.query.all()
        if codeList:
            return [marshal(code, code_fields) for code in codeList]
        else:
            abort(404, message='No Code at all')

    @marshal_with(code_fields)
    def post(self):
        args = self.parser.parse_args()
        title = args['title']
        creator_id = args['creator_id']
        create_time = args['create_time']
        code = Code(title=title, creator_id=creator_id, create_time=create_time)
        for k,v in args.iteritems():
            if v:
                setattr(code,k,v)
        db.session.add(code)
        db.session.commit()
        return code, 201

class CodeQuery(Resource):
    def __init__(self):
        self.parser = reqparse.RequestParser()
        self.parser.add_argument('title', type=unicode,location='json')
        self.parser.add_argument('creator_id', type=int,location='json')
        self.parser.add_argument('updater_id', type=int,location='json')
        self.parser.add_argument('create_time',location='json')
        self.parser.add_argument('update_time', location='json')
        self.parser.add_argument('description', type=unicode,location='json')
        self.parser.add_argument('size', type=float,location='json')
        self.parser.add_argument('uri', type=unicode,location='json')
        self.parser.add_argument('language', type=unicode,location='json')
        super(CodeQuery, self).__init__()

    def post(self):
        args = self.parser.parse_args()
        q = Code.query
        for attr, value in args.items():
            if value:
                q = q.filter(getattr(Code, attr).like("%%%s%%" % value))
        if q:
            return [marshal(code, code_fields) for code in q]
        else:
            abort(404, message='No such code at all')


    # def post(self):
    #     args = self.parser.parse_args()
    #     creator_id = args['creator_id']
    #     update_id = args['update_id']
    #     codeList = Code.query.filter_by(update_id=update_id,creator_id=creator_id)
    #     if codeList:
    #         return [marshal(code, code_fields) for code in codeList]
    #     else:
    #         abort(404, message='No code at all')


api.add_resource(CodeQuery, '/api/v1/codes/query', endpoint='codequery')
api.add_resource(CodeListApi, '/api/v1/codes', endpoint='codeList')
api.add_resource(CodeApi, '/api/v1/codes/<code_id>', endpoint='code')