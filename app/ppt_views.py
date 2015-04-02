__author__ = 'ClarkWong, Justsavor'

from app import db, app
from flask.ext.restful import reqparse, abort, Api, Resource, fields, marshal_with, marshal
from models import *
api = Api(app)

ppt_fields = {
    'id': fields.Integer,
    'literature_id': fields.Integer,
    'size': fields.Float,
    'uri': fields.String
}

class PptApi(Resource):

    def __init__(self):
        self.parser = reqparse.RequestParser()
        self.parser.add_argument('literature_id', type=int, required=True, location='json')
        self.parser.add_argument('size', type=float, location='json')
        self.parser.add_argument('uri', type=unicode, location='json')
        super(PptApi, self).__init__()

    def delete(self, ppt_id):
        ppt = Ppt.query.filter_by(id=ppt_id).first()
        if ppt:
            db.session.delete(ppt)
            db.session.commit()
            return { 'message' : 'Delete Ppt {} succeed'.format(ppt_id)}, 201
        else:
            abort(404, message='Ppt {} not found'.format(ppt_id))


class PptListApi(Resource):

    def __init__(self):
        self.parser = reqparse.RequestParser()
        self.parser.add_argument('literature_id', type=int, required=True, location='json')
        self.parser.add_argument('size', type=float, location='json')
        self.parser.add_argument('uri', type=unicode, location='json')
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
        ppt = Ppt(literature_id=args['literature_id'])
        for k,v in args.iteritems():
            if v:
                setattr(ppt,k,v)
        db.session.add(ppt)
        db.session.commit()
        return ppt, 201

class PptQueryApi(Resource):
     def __init__(self):
        self.parser = reqparse.RequestParser()
        self.parser.add_argument('literature_id', type=int, required=True,location='json')
        self.parser.add_argument('size', type=float, location='json')
        self.parser.add_argument('uri', type=unicode, location='json')
        super(PptQueryApi, self).__init__()

     def post(self):
        args = self.parser.parse_args()
        q = Ppt.query
        for attr, value in args.items():
            if value:
                q = q.filter(getattr(Ppt, attr).like("%%%s%%" % value))
        if q:
            return [marshal(ppt, ppt_fields) for ppt in q]
        else:
            abort(404, message='No such ppt at all')

api.add_resource(PptApi, '/api/v1/ppts/<ppt_id>', endpoint='ppt')
api.add_resource(PptListApi, '/api/v1/ppts', endpoint='pptList')
api.add_resource(PptQueryApi, '/api/v1/ppts/query', endpoint='pptQuery')