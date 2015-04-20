__author__ = 'ClarkWong'

from app import db, api
from flask.ext.restful import reqparse, abort, Resource, fields, marshal_with, marshal
from models import *
from report_views import report_fields
from code_views import code_fields


report_code_fields = {
    "report_id": fields.Integer,
    "code_id": fields.Integer
}


class report_codeListApi(Resource):
    def __init__(self):
        self.parser = reqparse.RequestParser()
        self.parser.add_argument('report_id', type=int, required=True, location='json')
        self.parser.add_argument('code_id', type=int, required=True, location='json')
        super(report_codeListApi, self).__init__()

    def post(self):
        args = self.parser.parse_args()
        report_id = args['report_id']
        code_id = args['code_id']
        code = Code.query.filter_by(id=code_id).first()
        report = Report.query.filter_by(id=report_id).first()
        code.reports.append(report)
        db.session.commit()
        return {'message': 'Add report_code succeed'}, 201


class report_codeQuery(Resource):
    def __init__(self):
        self.parser = reqparse.RequestParser()
        self.parser.add_argument('report_id', type=int, location='json')
        self.parser.add_argument('code_id', type=int, location='json')
        super(report_codeQuery, self).__init__()


    def post(self):
        args = self.parser.parse_args()
        if args['code_id']:
            code = Code.query.filter_by(id=args['code_id']).first()
            if code:
                reports = [marshal(x, report_fields) for x in code.reports.all()]
                return reports
            else:
                abort(404, message='No reports at all')
        elif args['report_id']:
            report = Report.query.filter_by(id=args['report_id']).first()
            if report:
                codes = [marshal(x, code_fields) for x in report.codes.all()]
                return codes
            else:
                abort(404, message='No codes at all')


class report_codeDel(Resource):
    def __init__(self):
        self.parser = reqparse.RequestParser()
        self.parser.add_argument('report_id', type=int, required=True, location='json')
        self.parser.add_argument('code_id', type=int, required=True, location='json')
        super(report_codeDel, self).__init__()


    def post(self):
        args = self.parser.parse_args()
        code = Code.query.filter_by(id=args['code_id']).first()
        report = Report.query.filter_by(id=args['report_id']).first()
        report.codes.remove(code)
        db.session.commit()
        return {'message': 'Delete report_code succeed'}, 201


api.add_resource(report_codeQuery, '/api/v1/report_codes/query', endpoint='report_codequery')
api.add_resource(report_codeListApi, '/api/v1/report_codes', endpoint='report_codeList')
api.add_resource(report_codeDel, '/api/v1/report_codes/del', endpoint='report_codedel')
