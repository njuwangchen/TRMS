__author__ = 'ClarkWong,Justsavor'

from app import db, app
from flask.ext.restful import reqparse, abort, Api, Resource, fields, marshal_with, marshal
from models import *

api = Api(app)

cite_fields = {
    'id' : fields.Integer,
    'literature_id' : fields.Integer,
    'cited_id' : fields.Integer,
    'cite_type_id' : fields.Integer,
}

class CiteApi(Resource):

    def __init__(self):
        self.parser = reqparse.RequestParser()
        self.parser.add_argument('literature_id', type=int, required=True, location='json')
        self.parser.add_argument('cited_id', type=int, required=True, location='json')
        self.parser.add_argument('cite_type_id', type=int, required=True, location='json')
        super(CiteApi, self).__init__()

    @marshal_with(cite_fields)
    def get(self, cite_id):
        cite = Cite.query.filter_by(id=cite_id).first()
        if cite:
            return cite, 201
        else:
            abort(404, message='Cite {} not found'.format(cite_id))

    def delete(self, cite_id):
        cite = Cite.query.filter_by(id=cite_id).first()
        if cite:
            db.session.delete(cite)
            db.session.commit()
            return { 'message' : 'Delete Cite {} succeed'.format(cite_id)}, 201
        else:
            abort(404, message='Cite {} not found'.format(cite_id))

    @marshal_with(cite_fields)
    def put(self, cite_id):
        cite = Cite.query.filter_by(id=cite_id).first()
        if cite:
            args = self.parser.parse_args()
            for k,v in args.iteritems():
                if v!= None:
                    setattr(cite, k, v)
            # cite.literature_id = args.literature_id
            # cite.cited_id = args.cited_id
            # cite.cited_type_id = args.cited_type_id
            # db.session.commit()
            return cite, 201
        else:
            abort(404, message='Cite {} not found'.format(cite_id))

class CiteListApi(Resource):

    def __init__(self):
        self.parser = reqparse.RequestParser()
        self.parser.add_argument('literature_id', type=int, required=True, location='json')
        self.parser.add_argument('cited_id', type=int, required=True, location='json')
        self.parser.add_argument('cite_type_id', type=int, required=True, location='json')
        super(CiteListApi, self).__init__()

    def get(self):
        citeList = Cite.query.all()
        if citeList:
            return [marshal(cite, cite_fields) for cite in citeList]
        else:
            abort(404, message='No Cite at all')

    @marshal_with(cite_fields)
    def post(self):
        args = self.parser.parse_args()
        literature_id = args['literature_id']
        cited_id = args['cited_id']
        cite_type_id = args['cite_type_id']
        cite = Cite(literature_id, cited_id, cite_type_id)
        db.session.add(cite)
        db.session.commit()
        return cite, 201

class CiteQueryApi(Resource):
     def __init__(self):
        self.parser = reqparse.RequestParser()
        self.parser.add_argument('literature_id', type=int, required=True, location='json')
        self.parser.add_argument('cited_id', type=int, required=True, location='json')
        self.parser.add_argument('cite_type_id', type=int, required=True, location='json')
        super(CiteQueryApi, self).__init__()


     def post(self):
        args = self.parser.parse_args()
        literature_id = args['literature_id']
        cited_id = args['cited_id']
        cite_type_id = args['cite_type_id']
        citeList = Cite.query.filter_by(literature_id=literature_id, cited_id=cited_id, cite_type_id=cite_type_id)
        if citeList:
            return [marshal(cite, cite_fields) for cite in citeList]
        else:
            abort(404, message='No such cite at all')

api.add_resource(CiteApi,'/api/v1/cites/<cite_id>', endpoint='cite')
api.add_resource(CiteListApi,'/api/v1/cites', endpoint='citeList')
api.add_resource(CiteQueryApi,'/api/v1/cites/query', endpoint='citeQuery')