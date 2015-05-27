__author__ = 'ClarkWong'

from app import app
from flask.ext.restful import reqparse, abort, Api, Resource, fields, marshal_with, marshal
from models import *
api = Api(app)

data_set_files_fields = {
    'id': fields.Integer,
    'data_set_id': fields.Integer,
    'size': fields.Float,
    'uri': fields.String,
    'file_name': fields.String
}

class Data_set_filesApi(Resource):

    def __init__(self):
        self.parser = reqparse.RequestParser()
        self.parser.add_argument('data_set_id', type=int, location='json')
        self.parser.add_argument('size', type=float, location='json')
        self.parser.add_argument('url', type=unicode, location='json')
        self.parser.add_argument('file_name', type=unicode, location='json')
        super(Data_set_filesApi, self).__init__()

    def delete(self, data_set_files_id):
        data_set_files = Data_set_files.query.filter_by(id=data_set_files_id).first()
        if data_set_files:
            db.session.delete(data_set_files)
            db.session.commit()
            return { 'message' : 'Delete Data_set_files {} succeed'.format(data_set_files_id)}, 201
        else:
            abort(404, message='Data_set_files {} not found'.format(data_set_files_id))

    @marshal_with(data_set_files_fields)
    def put(self, data_set_files_id):
        data_set_files = Data_set_files.query.get(data_set_files_id)
        if data_set_files:
            args = self.parser.parse_args()
            for k,v in args.iteritems():
                if v!= None:
                    setattr(data_set_files, k, v)
            db.session.commit()
            return data_set_files, 201
        else:
            abort(404, message='Data_set_files {} not found'.format(data_set_files_id))


class Data_set_filesListApi(Resource):

    def __init__(self):
        self.parser = reqparse.RequestParser()
        self.parser.add_argument('data_set_id', type=int, required=True, location='json')
        self.parser.add_argument('size', type=float, location='json')
        self.parser.add_argument('uri', type=unicode, location='json')
        super(Data_set_filesListApi, self).__init__()


    @marshal_with(data_set_files_fields)
    def post(self):
        args = self.parser.parse_args()
        data_set_id = args['data_set_id']
        data_set_files = Data_set_files(data_set_id)
        for k,v in args.iteritems():
            if v:
                setattr(data_set_files,k,v)
        db.session.add(data_set_files)
        db.session.commit()
        return data_set_files, 201

class Data_set_filesQueryApi(Resource):
     def __init__(self):
        self.parser = reqparse.RequestParser()
        self.parser.add_argument('data_set_id', type=int, required=True, location='json')
        self.parser.add_argument('size', type=float,  location='json')
        self.parser.add_argument('uri', type=unicode, location='json')
        super(Data_set_filesQueryApi, self).__init__()

     def post(self):
        args = self.parser.parse_args()
        q = Data_set_files.query
        for attr, value in args.items():
            if value:
                q = q.filter(getattr(Data_set_files, attr).like("%%%s%%" % value))
        if q:
            return [marshal(data_set_files, data_set_files_fields) for data_set_files in q]
        else:
            abort(404, message='No such data_set_files at all')

api.add_resource(Data_set_filesApi, '/api/v1/data_set_files/<data_set_files_id>', endpoint='data_set_files')
api.add_resource(Data_set_filesListApi, '/api/v1/data_set_files', endpoint='data_set_filesList')
api.add_resource(Data_set_filesQueryApi, '/api/v1/data_set_files/query', endpoint='data_set_filesQuery')