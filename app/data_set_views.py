__author__ = 'ClarkWong'

from app import db, api
from flask.ext.restful import reqparse, abort, Resource, fields, marshal_with, marshal
from models import Data_set


data_set_fields={
    'id' : fields.Integer,
    'title': fields.String,
    'creator_id': fields.Integer,
    'updater_id': fields.Integer,
    'data_set_type_id': fields.Integer,
    'create_time': fields.String,
    'update_time': fields.String,
    'description': fields.String,
    'size': fields.Float,
    'uri': fields.String
}

class Data_setApi(Resource):
    def __init__(self):
        self.parser = reqparse.RequestParser()
        self.parser.add_argument('title', required=True, type=str,location='json')
        self.parser.add_argument('creator_id', type=int,required=True,location='json')
        self.parser.add_argument('data_set_type_id', type=int,required=True,location='json')
        self.parser.add_argument('updater_id', type=int,location='json')
        self.parser.add_argument('create_time',required=True,location='json')
        self.parser.add_argument('update_time', location='json')
        self.parser.add_argument('description', type=str,location='json')
        self.parser.add_argument('size', type=float,location='json')
        self.parser.add_argument('uri', type=str,location='json')
        super(Data_setApi, self).__init__()

    # @marshal_with(data_set_fields)
    # def get(self, data_set_id):
    #     data_set = Data_set.query.filter_by(id=data_set_id).first()
    #     if data_set:
    #         return data_set, 201
    #     else:
    #         abort(404, message='Data_set {} not found'.format(data_set_id))

    def delete(self, data_set_id):
        data_set = Data_set.query.filter_by(id=data_set_id).first()
        if data_set:
            db.session.delete(data_set)
            db.session.commit()
            return { 'message' : 'Delete Data_set {} succeed'.format(data_set_id)}, 201
        else:
            abort(404, message='Data_set {} not found'.format(data_set_id))

    # @marshal_with(data_set_fields)
    # def put(self, data_set_id):
    #     data_set = Data_set.query.filter_by(id=data_set_id).first()
    #     if data_set:
    #         args = self.parser.parse_args()
    #         for k,v in args.iteritems():
    #             if v!= None:
    #                 setattr(data_set, k, v)
    #         db.session.commit()
    #         return data_set, 201
    #     else:
    #         abort(404, message='Data_set {} not found'.format(data_set_id))

class Data_setListApi(Resource):

    def __init__(self):
        self.parser = reqparse.RequestParser()
        self.parser.add_argument('title', type=str,required=True,location='json')
        self.parser.add_argument('creator_id', type=int,required=True,location='json')
        self.parser.add_argument('data_set_type_id', type=int,required=True,location='json')
        self.parser.add_argument('updater_id', type=int,location='json')
        self.parser.add_argument('create_time',required=True,location='json')
        self.parser.add_argument('update_time', location='json')
        self.parser.add_argument('description', type=str,location='json')
        self.parser.add_argument('size', type=float,location='json')
        self.parser.add_argument('uri', type=str,location='json')
        super(Data_setListApi, self).__init__()

    def get(self):
        data_setList = Data_set.query.all()
        if data_setList:
            return [marshal(data_set, data_set_fields) for data_set in data_setList]
        else:
            abort(404, message='No Data_set at all')

    @marshal_with(data_set_fields)
    def post(self):
        args = self.parser.parse_args()
        title = args['title']
        data_set_type_id = args['data_set_type_id']
        creator_id = args['creator_id']
        create_time = args['create_time']
        data_set = Data_set(title=title, creator_id=creator_id, create_time=create_time,data_set_type_id=data_set_type_id)
        for k,v in args.iteritems():
            if v:
                setattr(data_set,k,v)
        db.session.add(data_set)
        db.session.commit()
        return data_set, 201

class Data_setQuery(Resource):
    def __init__(self):
        self.parser = reqparse.RequestParser()
        self.parser.add_argument('creator_id', type=int,required=True,location='json')
        self.parser.add_argument('update_id', type=int,required=True,location='json')
        super(Data_setQuery, self).__init__()


    # def post(self):
    #     args = self.parser.parse_args()
    #     creator_id = args['creator_id']
    #     update_id = args['update_id']
    #     data_setList = Data_set.query.filter_by(update_id=update_id,creator_id=creator_id)
    #     if data_setList:
    #         return [marshal(data_set, data_set_fields) for data_set in data_setList]
    #     else:
    #         abort(404, message='No data_set at all')


api.add_resource(Data_setQuery, '/api/v1/data_sets/query', endpoint='data_setquery')
api.add_resource(Data_setListApi, '/api/v1/data_sets', endpoint='data_setList')
api.add_resource(Data_setApi, '/api/v1/data_sets/<data_set_id>', endpoint='data_set')