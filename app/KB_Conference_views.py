__author__ = 'ClarkWong'

from app import db, api
from flask.ext.restful import reqparse, abort, Resource, fields, marshal_with
from models import KB_Conference

KB_Conference_fields = {
    'id': fields.Integer,
    'abbreviation': fields.String,
    'full': fields.String
}

class KB_Conference_Api(Resource):
    def __init__(self):
        self.parser = reqparse.RequestParser()
        self.parser.add_argument('abbreviation', type=unicode, location='json')
        self.parser.add_argument('full', type=unicode, location='json')
        super(KB_Conference_Api, self).__init__()

    @marshal_with(KB_Conference_fields)
    def get(self, id):
        kb_c = KB_Conference.query.get(id)
        if kb_c:
            return kb_c, 201
        else:
            abort(404)

    def delete(self, id):
        kb_c = KB_Conference.query.get(id)
        if kb_c:
            db.session.delete(kb_c)
            db.session.commit()
            return "delete success!", 201
        else:
            abort(404)

    @marshal_with(KB_Conference_fields)
    def put(self, id):
        kb_c = KB_Conference.query.get(id)
        if kb_c:
            args = self.parser.parse_args()
            for k,v in args.iteritems():
                if v!=None:
                    setattr(kb_c, k, v)
            db.session.commit()
            return kb_c, 201
        else:
            abort(404)

class KB_Conference_List_Api(Resource):
    def __init__(self):
        self.parser = reqparse.RequestParser()
        self.parser.add_argument('abbreviation', type=unicode, location='json', required=True)
        self.parser.add_argument('full', type=unicode, location='json', required=True)
        super(KB_Conference_List_Api, self).__init__()

    @marshal_with(KB_Conference_fields)
    def get(self):
        kb_c_list = KB_Conference.query.all()
        if kb_c_list:
            return kb_c_list, 201
        else:
            abort(404)

    @marshal_with(KB_Conference_fields)
    def post(self):
        args = self.parser.parse_args()
        abbreviation = args.get('abbreviation')
        full = args.get('full')
        kb_c = KB_Conference(abbreviation, full)
        db.session.add(kb_c)
        db.session.commit()
        return kb_c, 201

class KB_Conference_Query_Api(Resource):
    def __init__(self):
        self.parser = reqparse.RequestParser()
        self.parser.add_argument('abbreviation', type=unicode, location='json', required=True)
        super(KB_Conference_Query_Api, self).__init__()

    @marshal_with(KB_Conference_fields)
    def post(self):
        args = self.parser.parse_args()
        abbreviation = args.get('abbreviation')
        kb_c = KB_Conference.query.filter_by(abbreviation=abbreviation).first()
        if kb_c:
            return kb_c, 201
        else:
            abort(404)

api.add_resource(KB_Conference_Api, '/api/v1/kb_conference/<id>', endpoint='kb_conference')
api.add_resource(KB_Conference_List_Api, '/api/v1/kb_conference', endpoint='kb_conference_list')
api.add_resource(KB_Conference_Query_Api, '/api/v1/kb_conference/query', endpoint='kb_conference_query')
