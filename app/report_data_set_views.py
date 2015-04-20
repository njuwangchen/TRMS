__author__ = 'ClarkWong'

from app import db, api
from flask.ext.restful import reqparse, abort, Resource, fields, marshal_with, marshal
from models import *
from report_views import report_fields
from data_set_views import data_set_fields


report_data_set_fields = {
    "report_id": fields.Integer,
    "data_set_id": fields.Integer
}


class report_data_setListApi(Resource):
    def __init__(self):
        self.parser = reqparse.RequestParser()
        self.parser.add_argument('report_id', type=int, required=True, location='json')
        self.parser.add_argument('data_set_id', type=int, required=True, location='json')
        super(report_data_setListApi, self).__init__()

    def post(self):
        args = self.parser.parse_args()
        report_id = args['report_id']
        data_set_id = args['data_set_id']
        data_set = Data_set.query.filter_by(id=data_set_id).first()
        report = Report.query.filter_by(id=report_id).first()
        data_set.reports.append(report)
        db.session.commit()
        return {'message': 'Add report_data_set succeed'}, 201


class report_data_setQuery(Resource):
    def __init__(self):
        self.parser = reqparse.RequestParser()
        self.parser.add_argument('report_id', type=int, location='json')
        self.parser.add_argument('data_set_id', type=int, location='json')
        super(report_data_setQuery, self).__init__()


    def post(self):
        args = self.parser.parse_args()
        if args['data_set_id']:
            data_set = Data_set.query.filter_by(id=args['data_set_id']).first()
            if data_set:
                reports = [marshal(x, report_fields) for x in data_set.reports.all()]
                return reports
            else:
                abort(404, message='No reports at all')
        elif args['report_id']:
            report = Report.query.filter_by(id=args['report_id']).first()
            if report:
                data_sets = [marshal(x, data_set_fields) for x in report.data_sets.all()]
                return data_sets
            else:
                abort(404, message='No data_sets at all')


class report_data_setDel(Resource):
    def __init__(self):
        self.parser = reqparse.RequestParser()
        self.parser.add_argument('report_id', type=int, required=True, location='json')
        self.parser.add_argument('data_set_id', type=int, required=True, location='json')
        super(report_data_setDel, self).__init__()


    def post(self):
        args = self.parser.parse_args()
        data_set = Data_set.query.filter_by(id=args['data_set_id']).first()
        report = Report.query.filter_by(id=args['report_id']).first()
        report.data_sets.remove(data_set)
        db.session.commit()
        return {'message': 'Delete report_data_set succeed'}, 201


api.add_resource(report_data_setQuery, '/api/v1/report_data_sets/query', endpoint='report_data_setquery')
api.add_resource(report_data_setListApi, '/api/v1/report_data_sets', endpoint='report_data_setList')
api.add_resource(report_data_setDel, '/api/v1/report_data_sets/del', endpoint='report_data_setdel')
