__author__ = 'ClarkWong'

from app import app
from flask.ext.restful import reqparse, abort, Api, Resource, fields, marshal_with, marshal
from models import *
api = Api(app)

code_files_fields = {
    'id': fields.Integer,
    'code_id': fields.Integer,
    'size': fields.Float,
    'uri': fields.String,
    'file_name': fields.String
}

class Code_filesApi(Resource):

    def __init__(self):
        self.parser = reqparse.RequestParser()
        self.parser.add_argument('code_id', type=int, location='json')
        self.parser.add_argument('size', type=float, location='json')
        self.parser.add_argument('url', type=unicode, location='json')
        self.parser.add_argument('file_name', type=unicode, location='json')
        super(Code_filesApi, self).__init__()

    def delete(self, code_files_id):
        code_files = Code_files.query.filter_by(id=code_files_id).first()
        if code_files:
            db.session.delete(code_files)
            db.session.commit()
            return { 'message' : 'Delete Code_files {} succeed'.format(code_files_id)}, 201
        else:
            abort(404, message='Code_files {} not found'.format(code_files_id))

    @marshal_with(code_files_fields)
    def put(self, code_files_id):
        code_files = Code_files.query.get(code_files_id)
        if code_files:
            args = self.parser.parse_args()
            for k,v in args.iteritems():
                if v!= None:
                    setattr(code_files, k, v)
            db.session.commit()
            return code_files, 201
        else:
            abort(404, message='Code_files {} not found'.format(code_files_id))


class Code_filesListApi(Resource):

    def __init__(self):
        self.parser = reqparse.RequestParser()
        self.parser.add_argument('code_id', type=int, required=True, location='json')
        self.parser.add_argument('size', type=float, location='json')
        self.parser.add_argument('uri', type=unicode, location='json')
        super(Code_filesListApi, self).__init__()


    @marshal_with(code_files_fields)
    def post(self):
        args = self.parser.parse_args()
        code_id = args['code_id']
        code_files = Code_files(code_id)
        for k,v in args.iteritems():
            if v:
                setattr(code_files,k,v)
        db.session.add(code_files)
        db.session.commit()
        return code_files, 201

class Code_filesQueryApi(Resource):
     def __init__(self):
        self.parser = reqparse.RequestParser()
        self.parser.add_argument('code_id', type=int, required=True, location='json')
        self.parser.add_argument('size', type=float,  location='json')
        self.parser.add_argument('uri', type=unicode, location='json')
        super(Code_filesQueryApi, self).__init__()

     def post(self):
        args = self.parser.parse_args()
        q = Code_files.query
        for attr, value in args.items():
            if value:
                q = q.filter(getattr(Code_files, attr).like("%%%s%%" % value))
        if q:
            return [marshal(code_files, code_files_fields) for code_files in q]
        else:
            abort(404, message='No such code_files at all')

api.add_resource(Code_filesApi, '/api/v1/code_files/<code_files_id>', endpoint='code_files')
api.add_resource(Code_filesListApi, '/api/v1/code_files', endpoint='code_filesList')
api.add_resource(Code_filesQueryApi, '/api/v1/code_files/query', endpoint='code_filesQuery')