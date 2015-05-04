__author__ = 'ClarkWong'

from app import db, api
from flask.ext.restful import reqparse, abort, Resource, fields, marshal_with
from models import KB_Journal

KB_Journal_fields = {
    'id': fields.Integer,
    'abbreviation': fields.String,
    'full': fields.String
}

class KB_Journal_Api(Resource):
    def __init__(self):
        self.parser = reqparse.RequestParser()
        self.parser.add_argument('abbreviation', type=unicode, location='json')
        self.parser.add_argument('full', type=unicode, location='json')
        super(KB_Journal_Api, self).__init__()

    @marshal_with(KB_Journal_fields)
    def get(self, id):
        kb_c = KB_Journal.query.get(id)
        if kb_c:
            return kb_c, 201
        else:
            abort(404)

    def delete(self, id):
        kb_c = KB_Journal.query.get(id)
        if kb_c:
            db.session.delete(kb_c)
            db.session.commit()
            return "delete success!", 201
        else:
            abort(404)

    @marshal_with(KB_Journal_fields)
    def put(self, id):
        kb_c = KB_Journal.query.get(id)
        if kb_c:
            args = self.parser.parse_args()
            for k,v in args.iteritems():
                if v!=None:
                    setattr(kb_c, k, v)
            db.session.commit()
            return kb_c, 201
        else:
            abort(404)

class KB_Journal_List_Api(Resource):
    def __init__(self):
        self.parser = reqparse.RequestParser()
        self.parser.add_argument('abbreviation', type=unicode, location='json', required=True)
        self.parser.add_argument('full', type=unicode, location='json', required=True)
        super(KB_Journal_List_Api, self).__init__()

    @marshal_with(KB_Journal_fields)
    def get(self):
        kb_c_list = KB_Journal.query.all()
        if kb_c_list:
            return kb_c_list, 201
        else:
            abort(404)

    @marshal_with(KB_Journal_fields)
    def post(self):
        args = self.parser.parse_args()
        abbreviation = args.get('abbreviation')
        full = args.get('full')
        kb_c = KB_Journal(abbreviation, full)
        db.session.add(kb_c)
        db.session.commit()
        return kb_c, 201

class KB_Journal_Query_Api(Resource):
    def __init__(self):
        self.parser = reqparse.RequestParser()
        self.parser.add_argument('abbreviation', type=unicode, location='json', required=True)
        super(KB_Journal_Query_Api, self).__init__()

    @marshal_with(KB_Journal_fields)
    def post(self):
        args = self.parser.parse_args()
        abbreviation = args.get('abbreviation')
        kb_c = KB_Journal.query.filter_by(abbreviation=abbreviation).first()
        if kb_c:
            return kb_c, 201
        else:
            abort(404)

api.add_resource(KB_Journal_Api, '/api/v1/kb_journal/<id>', endpoint='kb_journal')
api.add_resource(KB_Journal_List_Api, '/api/v1/kb_journal', endpoint='kb_journal_list')
api.add_resource(KB_Journal_Query_Api, '/api/v1/kb_journal/query', endpoint='kb_journal_query')
