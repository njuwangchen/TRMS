__author__ = 'ClarkWong, Justsavor'

from app import db, app
from flask.ext.restful import reqparse, abort, Api, Resource, fields, marshal_with, marshal
from models import *
api = Api(app)

tag_resource_fields = {
    'id': fields.Integer,
    'resource_id': fields.Integer,
    'type': fields.Integer,
    'tag_id': fields.Integer
}

class Tag_resourceApi(Resource):

    def __init__(self):
        self.parser = reqparse.RequestParser()
        self.parser.add_argument('resource_id', type=int, required=True, location='json')
        self.parser.add_argument('type', type=int, required=True, location='json')
        self.parser.add_argument('tag_id', type=int, required=True, location='json')
        super(Tag_resourceApi, self).__init__()

    @marshal_with(tag_resource_fields)
    def get(self, tag_resource_id):
        tag_resource = Tag_resource.query.filter_by(id=tag_resource_id).first()
        if tag_resource:
            return tag_resource, 201
        else:
            abort(404, message='Tag_resource {} not found'.format(tag_resource_id))

    def delete(self, tag_resource_id):
        tag_resource = Tag_resource.query.filter_by(id=tag_resource_id).first()
        if tag_resource:
            db.session.delete(tag_resource)
            db.session.commit()
            return { 'message' : 'Delete Tag_resource {} succeed'.format(tag_resource_id)}, 201
        else:
            abort(404, message='Tag_resource {} not found'.format(tag_resource_id))

    @marshal_with(tag_resource_fields)
    def put(self, tag_resource_id):
        tag_resource = Tag_resource.query.filter_by(id=tag_resource_id).first()
        if tag_resource:
            args = self.parser.parse_args()
            for k,v in args.iteritems():
                if v!= None:
                    setattr(tag_resource, k, v)
            return tag_resource, 201
        else:
            abort(404, message='Tag_resource {} not found'.format(tag_resource_id))

class Tag_resourceListApi(Resource):

    def __init__(self):
        self.parser = reqparse.RequestParser()
        self.parser.add_argument('resource_id', type=int, required=True, location='json')
        self.parser.add_argument('type', type=int, required=True, location='json')
        self.parser.add_argument('tag_id', type=int, required=True, location='json')
        super(Tag_resourceListApi, self).__init__()

    def get(self):
        tag_resourceList = Tag_resource.query.all()
        if tag_resourceList:
            return [marshal(tag_resource, tag_resource_fields) for tag_resource in tag_resourceList]
        else:
            abort(404, message='No Tag_resource at all')

    @marshal_with(tag_resource_fields)
    def post(self):
        args = self.parser.parse_args()
        resource_id = args['resource_id']
        type = args['type']
        tag_id = args['tag_id']
        tag_resource = Tag_resource(resource_id, type, tag_id)
        db.session.add(tag_resource)
        db.session.commit()
        return tag_resource, 201

class Tag_resourceQueryApi(Resource):
     def __init__(self):
        self.parser = reqparse.RequestParser()
        self.parser.add_argument('resource_id', type=int, required=True, location='json')
        self.parser.add_argument('type', type=int, required=True, location='json')
        self.parser.add_argument('tag_id', type=int, required=True, location='json')
        super(Tag_resourceQueryApi, self).__init__()

     def post(self):
        args = self.parser.parse_args()
        resource_id = args['resource_id']
        type = args['type']
        tag_id = args['tag_id']
        tag_resourceList = Tag_resource.query.filter_by(resource_id=resource_id, type=type, tag_id=tag_id)
        if tag_resourceList:
            return [marshal(tag_resource, tag_resource_fields) for tag_resource in tag_resourceList]
        else:
            abort(404, message='No such tag_resource at all')

api.add_resource(Tag_resourceApi, '/api/v1/tag_resources/<tag_resource_id>', endpoint='tag_resource')
api.add_resource(Tag_resourceListApi, '/api/v1/Tag_resources', endpoint='tag_resourceList')
api.add_resource(Tag_resourceQueryApi, '/api/v1/tag_resources/query', endpoint='tag_resourceQuery')