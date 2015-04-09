__author__ = 'justsavor'

from app import db, app
from flask.ext.restful import reqparse, abort, Api, Resource, fields, marshal_with, marshal
from models import *
import dateutil.parser
api = Api(app)

report_fields = {
    'id': fields.Integer,
    'title': fields.String,
    'report_date': fields.String,
    'reporter': fields.String,
    'company': fields.String,
    'reporter_title': fields.String,
    'location': fields.String,
    'creator_id': fields.Integer,
    'create_time': fields.String,
    'updater_id': fields.Integer,
    'update_time': fields.String,
}

class ReportApi(Resource):

    def __init__(self):
        self.parser = reqparse.RequestParser()
        self.parser.add_argument('title', type=unicode, location='json')
        self.parser.add_argument('report_date', location='json')
        self.parser.add_argument('reporter', type=unicode, location='json')
        self.parser.add_argument('company', type=unicode, location='json')
        self.parser.add_argument('reporter_title', type=unicode, location='json')
        self.parser.add_argument('location', type=unicode, location='json')
        self.parser.add_argument('creator_id', type=int, location='json')
        self.parser.add_argument('updater_id', type=int, location='json')
        self.parser.add_argument('create_time', location='json')
        self.parser.add_argument('update_time', location='json')
        super(ReportApi, self).__init__()

    @marshal_with(report_fields)
    def get(self, report_id):
        report = Report.query.filter_by(id=report_id).first()
        if report:
            return report, 201
        else:
            abort(404, message='Report {} not found'.format(report_id))

    @marshal_with(report_fields)
    def put(self, report_id):
        report = Report.query.filter_by(id=report_id).first()
        if report:
            args = self.parser.parse_args()
            args['report_date'] = dateutil.parser.parse(args['report_date'])
            args['create_time'] = dateutil.parser.parse(args['create_time'])
            args['update_time'] = dateutil.parser.parse(args['update_time'])
            for k,v in args.iteritems():
                if v!= None:
                    setattr(report, k, v)
            db.session.commit()
            return report, 201
        else:
            abort(404, message='Report {} not found'.format(report_id))

class ReportListApi(Resource):

    def __init__(self):
        self.parser = reqparse.RequestParser()
        self.parser.add_argument('title', type=unicode, required=True, location='json')
        self.parser.add_argument('report_date', location='json')
        self.parser.add_argument('reporter', type=unicode, location='json')
        self.parser.add_argument('company', type=unicode, location='json')
        self.parser.add_argument('reporter_title', type=unicode, location='json')
        self.parser.add_argument('location', type=unicode, location='json')
        self.parser.add_argument('creator_id', type=int, required=True, location='json')
        self.parser.add_argument('updater_id', type=int, location='json')
        self.parser.add_argument('create_time', required=True, location='json')
        self.parser.add_argument('update_time', location='json')

        super(ReportListApi, self).__init__()

    @marshal_with(report_fields)
    def get(self):
        report_list = Report.query.all()
        return report_list, 201

    @marshal_with(report_fields)
    def post(self):
        args = self.parser.parse_args()
        title = args['title']
        creator_id = args['creator_id']
        args['create_time']= dateutil.parser.parse(args['create_time'])
        create_time = args['create_time']
        report = Report(title=title, creator_id=creator_id, create_time=create_time)
        for k, v in args.iteritems():
            if v!= None:
                setattr(report, k, v)
        db.session.add(report)
        db.session.commit()
        return report, 201


class ReportQueryApi(Resource):

     def __init__(self):
        self.parser = reqparse.RequestParser()
        self.parser.add_argument('title', type=unicode, location='json')
        self.parser.add_argument('report_date', location='json')
        self.parser.add_argument('reporter', type=unicode, location='json')
        self.parser.add_argument('company', type=unicode, location='json')
        self.parser.add_argument('reporter_title', type=unicode, location='json')
        self.parser.add_argument('location', type=unicode, location='json')
        self.parser.add_argument('creator_id', type=int, location='json')
        self.parser.add_argument('updater_id', type=int, location='json')
        self.parser.add_argument('create_time', location='json')
        self.parser.add_argument('update_time', location='json')
        super(ReportQueryApi, self).__init__()

     def post(self):
        args = self.parser.parse_args()
        q = Report.query
        for attr, value in args.items():
            if value:
                q = q.filter(getattr(Report, attr).like("%%%s%%" % value))

        if q:
            return [marshal(report, report_fields) for report in q]
        else:
            abort(404, message='No such report at all')

api.add_resource(ReportApi, '/api/v1/reports/<report_id>', endpoint='report')
api.add_resource(ReportListApi, '/api/v1/reports', endpoint='reportList')
api.add_resource(ReportQueryApi, '/api/v1/reports/query', endpoint='reportQuery')
