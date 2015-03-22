__author__ = 'ClarkWong, Justsavor'

from app import db, app
from flask.ext.restful import reqparse, abort, Api, Resource, fields, marshal_with, marshal
from models import *
api = Api(app)

ppt_fields = {
    'id': fields.Integer,
    'title': fields.String,
    'literature_id': fields.Integer,
    'creator_id': fields.Integer,
    'updater_id': fields.Integer,
    'create_time': fields.DateTime,
    'update_time': fields.DateTime,
    'description': fields.String,
    'size': fields.Float,
    'uri': fields.String,
    'pages': fields.Integer
}

class PptApi(Resource):

    def __init__(self):
        self.parser = reqparse.RequestParser()
        self.parser.add_argument('title', type=str, required=True, location='json')
        self.parser.add_argument('literature_id', type=int, required=True, location='json')
        self.parser.add_argument('creator_id', type=int, required=True, location='json')
        self.parser.add_argument('updater_id', type=int, required=True, location='json')
        self.parser.add_argument('create_time', required=True, location='json')
        self.parser.add_argument('update_time', required=True, location='json')
        self.parser.add_argument('description', type=str, required=True, location='json')
        self.parser.add_argument('size', type=float, required=True, location='json')
        self.parser.add_argument('url', type=str, required=True, location='json')
        self.parser.add_argument('pages', type=int, required=True, location='json')
        super(PptApi, self).__init__()

    @marshal_with(ppt_fields)
    def get(self, ppt_id):
        ppt = Ppt.query.filter_by(id=ppt_id).first()
        if ppt:
            return ppt, 201
        else:
            abort(404, message='ppt {} not found'.format(ppt_id))

    def delete(self, ppt_id):
        ppt = Ppt.query.filter_by(id=ppt_id).first()
        if ppt:
            db.session.delete(ppt)
            db.session.commit()
            return { 'message' : 'Delete Ppt {} succeed'.format(ppt_id)}, 201
        else:
            abort(404, message='Ppt {} not found'.format(ppt_id))

    @marshal_with(ppt_fields)
    def put(self, ppt_id):
        ppt = Ppt.query.filter_by(id=ppt_id).first()
        if ppt:
            args = self.parser.parse_args()
            for k,v in args.iteritems():
                if v!= None:
                    setattr(ppt, k, v)
            return ppt, 201
        else:
            abort(404, message='Ppt {} not found'.format(ppt_id))

class PptListApi(Resource):

    def __init__(self):
        self.parser = reqparse.RequestParser()
        self.parser.add_argument('title', type=str, required=True, location='json')
        self.parser.add_argument('literature_id', type=int, required=True, location='json')
        self.parser.add_argument('creator_id', type=int, required=True, location='json')
        self.parser.add_argument('updater_id', type=int, required=True, location='json')
        self.parser.add_argument('create_time', required=True, location='json')
        self.parser.add_argument('update_time', required=True, location='json')
        self.parser.add_argument('description', type=str, required=True, location='json')
        self.parser.add_argument('size', type=float, required=True, location='json')
        self.parser.add_argument('url', type=str, required=True, location='json')
        self.parser.add_argument('pages', type=int, required=True, location='json')
        super(PptListApi, self).__init__()

    def get(self):
        pptList = Ppt.query.all()
        if pptList:
            return [marshal(ppt, ppt_fields) for ppt in pptList]
        else:
            abort(404, message='No Ppt at all')

    @marshal_with(ppt_fields)
    def post(self):
        args = self.parser.parse_args()
        title = args['title']
        literature_id = args['literature_id']
        creator_id = args['creator_id']
        updater_id = args['updater_id']
        create_time = args['create_time']
        update_time = args['update_time']
        description = args['description']
        size = args['size']
        url = args['url']
        pages = args['pages']
        ppt = Ppt(title, literature_id, creator_id, updater_id, create_time, update_time, description, size, url, pages)
        db.session.add(ppt)
        db.session.commit()
        return ppt, 201

class PptQueryApi(Resource):
     def __init__(self):
        self.parser = reqparse.RequestParser()
        self.parser.add_argument('title', type=str, required=True, location='json')
        self.parser.add_argument('literature_id', type=int, required=True, location='json')
        self.parser.add_argument('creator_id', type=int, required=True, location='json')
        self.parser.add_argument('updater_id', type=int, required=True, location='json')
        self.parser.add_argument('create_time', required=True, location='json')
        self.parser.add_argument('update_time', required=True, location='json')
        self.parser.add_argument('description', type=str, required=True, location='json')
        self.parser.add_argument('size', type=float, required=True, location='json')
        self.parser.add_argument('url', type=str, required=True, location='json')
        self.parser.add_argument('pages', type=int, required=True, location='json')
        super(PptQueryApi, self).__init__()

     def post(self):
        args = self.parser.parse_args()
        title = args['title']
        literature_id = args['literature_id']
        creator_id = args['creator_id']
        updater_id = args['updater_id']
        create_time = args['create_time']
        update_time = args['update_time']
        description = args['description']
        size = args['size']
        url = args['url']
        pages = args['pages']
        pptList = Ppt.query.filter_by(title=title, literature_id=literature_id, creator_id=creator_id, updater_id=updater_id, create_time=create_time, update_time=update_time, description=description, size=size, url=url, pages=pages)
        if pptList:
            return [marshal(ppt, ppt_fields) for ppt in pptList]
        else:
            abort(404, message='No such ppt at all')

api.add_resource(PptApi, '/api/v1/ppts/<ppt_id>', endpoint='ppt')
api.add_resource(PptListApi, '/api/v1/ppts', endpoint='pptList')
api.add_resource(PptQueryApi, '/api/v1/ppts/query', endpoint='pptQuery')