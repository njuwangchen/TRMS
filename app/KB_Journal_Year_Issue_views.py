__author__ = 'ClarkWong'

from app import db, api
from flask.ext.restful import reqparse, abort, Resource, fields, marshal_with
from models import KB_Journal_Year_Issue

KB_Journal_Year_Issue_fields = {
    'id': fields.Integer,
    'abbreviation': fields.String,
    'year': fields.Integer,
    'issue': fields.Integer,
    'editor': fields.String
}

class KB_Journal_Year_Issue_Api(Resource):
    def __init__(self):
        self.parser = reqparse.RequestParser()
        self.parser.add_argument('abbreviation', type=unicode, location='json')
        self.parser.add_argument('year', type=int, location='json')
        self.parser.add_argument('issue', type=int, location='json')
        self.parser.add_argument('editor', type=unicode, location='json')
        super(KB_Journal_Year_Issue_Api, self).__init__()

    @marshal_with(KB_Journal_Year_Issue_fields)
    def get(self, id):
        kb_c = KB_Journal_Year_Issue.query.get(id)
        if kb_c:
            return kb_c, 201
        else:
            abort(404)

    def delete(self, id):
        kb_c = KB_Journal_Year_Issue.query.get(id)
        if kb_c:
            db.session.delete(kb_c)
            db.session.commit()
            return "delete success!", 201
        else:
            abort(404)

    @marshal_with(KB_Journal_Year_Issue_fields)
    def put(self, id):
        kb_c = KB_Journal_Year_Issue.query.get(id)
        if kb_c:
            args = self.parser.parse_args()
            for k,v in args.iteritems():
                if v!=None:
                    setattr(kb_c, k, v)
            db.session.commit()
            return kb_c, 201
        else:
            abort(404)

class KB_Journal_Year_Issue_List_Api(Resource):
    def __init__(self):
        self.parser = reqparse.RequestParser()
        self.parser.add_argument('abbreviation', type=unicode, location='json', required=True)
        self.parser.add_argument('year', type=int, location='json', required=True)
        self.parser.add_argument('issue', type=int, location='json', required=True)
        self.parser.add_argument('editor', type=unicode, location='json', required=True)
        super(KB_Journal_Year_Issue_List_Api, self).__init__()

    @marshal_with(KB_Journal_Year_Issue_fields)
    def get(self):
        kb_c_list = KB_Journal_Year_Issue.query.all()
        if kb_c_list:
            return kb_c_list, 201
        else:
            abort(404)

    @marshal_with(KB_Journal_Year_Issue_fields)
    def post(self):
        args = self.parser.parse_args()
        abbreviation = args.get('abbreviation')
        year = args.get('year')
        issue = args.get('issue')
        editor = args.get('editor')
        kb_c = KB_Journal_Year_Issue(abbreviation, year, issue, editor)
        db.session.add(kb_c)
        db.session.commit()
        return kb_c, 201

class KB_Journal_Year_Issue_Query_Api(Resource):
    def __init__(self):
        self.parser = reqparse.RequestParser()
        self.parser.add_argument('abbreviation', type=unicode, location='json', required=True)
        self.parser.add_argument('year', type=int, location='json', required=True)
        self.parser.add_argument('issue', type=int, location='json', required=True)
        super(KB_Journal_Year_Issue_Query_Api, self).__init__()

    @marshal_with(KB_Journal_Year_Issue_fields)
    def post(self):
        args = self.parser.parse_args()
        abbreviation = args.get('abbreviation')
        year = args.get('year')
        issue = args.get('issue')
        kb_c = KB_Journal_Year_Issue.query.filter_by(abbreviation=abbreviation, year=year, issue=issue).first()
        if kb_c:
            return kb_c, 201
        else:
            abort(404)

api.add_resource(KB_Journal_Year_Issue_Api, '/api/v1/kb_journal_year_issue/<id>', endpoint='kb_journal_year_issue')
api.add_resource(KB_Journal_Year_Issue_List_Api, '/api/v1/kb_journal_year_issue', endpoint='kb_journal_year_issue_list')
api.add_resource(KB_Journal_Year_Issue_Query_Api, '/api/v1/kb_journal_year_issue/query', endpoint='kb_journal_year_issue_query')