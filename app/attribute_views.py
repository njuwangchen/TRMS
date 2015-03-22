__author__ = 'ClarkWong'

from app import db, api
from flask.ext.restful import reqparse, abort, Resource, fields, marshal_with, marshal
from models import Attribute

attribute_fields={
    "id":fields.Integer,
    "name":fields.String,
    "type":fields.Integer
}

class AttributeApi(Resource):

    def __init__(self):
        self.parser = reqparse.RequestParser()
        self.parser.add_argument('name',self,type=str,location="json")
        self.parser.add_argument('type',self,type=int,location="json")
        super(AttributeApi,self).__init__()

    @marshal_with(attribute_fields)
    def get(self, attribute_id):
        attribute = Attribute.query.filter_by(id=attribute_id).first()
        if attribute:
            return attribute, 201
        else:
            abort(404, message='Attribute {} not found'.format(attribute_id))

    def delete(self, attribute_id):
        attribute = Attribute.query.filter_by(id=attribute_id).first()
        if attribute:
            db.session.delete(attribute)
            db.session.commit()
            return { 'message' : 'Delete Attribute {} succeed'.format(attribute_id)}, 201
        else:
            abort(404, message='Attribute {} not found'.format(attribute_id))

    @marshal_with(attribute_fields)
    def put(self, attribute_id):
        attribute = Attribute.query.filter_by(id=attribute_id).first()
        if attribute:
            args = self.parser.parse_args()
            for k,v in args.iteritems():
                if v!= None:
                    setattr(attribute, k, v)
            db.session.commit()
            return attribute, 201
        else:
            abort(404, message='Attribute {} not found'.format(attribute_id))

class AttributeListApi(Resource):
    
    def __init__(self):
        self.parser = reqparse.RequestParser()
        self.parser.add_argument('name',self,type=str,location="json")
        self.parser.add_argument('type',self,type=int,location="json")
        super(AttributeListApi,self).__init__()
    
    def get(self):
        attributeList = Attribute.query.all()
        if attributeList:
            return [marshal(attribute, attribute_fields) for attribute in attributeList]
        else:
            abort(404, message='No Attribute at all')
#    def __init__(self, attributeer, attribute_time, star, resource_id, type, content=''):

    @marshal_with(attribute_fields)
    def post(self):
        args = self.parser.parse_args()
        name = args['name']
        type = args['type']
        attribute = Attribute(name, type)
        db.session.add(attribute)
        db.session.commit()
        return attribute, 201

class AttributeQuery(Resource):
    def __init__(self):
        self.parser = reqparse.RequestParser()
        self.parser.add_argument('name',self,type=str,location="json")
        self.parser.add_argument('type',self,type=int,location="json")
        super(AttributeListApi,self).__init__()
        
    def post(self):
        args = self.parser.parse_args()
        name = args['name']
        type = args['type']
        attributeList = Attribute.query.filter_by(name=name,type=type)
        if attributeList:
            return [marshal(attribute, attribute_fields) for attribute in attributeList]
        else:
            abort(404, message='No attribute at all')

api.add_resource(AttributeQuery, '/api/v1/attributes/query', endpoint='attributequery')
api.add_resource(AttributeListApi, '/api/v1/attributes', endpoint='attributeList')
api.add_resource(AttributeApi, '/api/v1/attributes/<attribute_id>', endpoint='attribute')