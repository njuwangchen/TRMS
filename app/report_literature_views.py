__author__ = 'ClarkWong'

from app import db, api
from flask.ext.restful import reqparse, abort, Resource, fields, marshal_with, marshal
from models import *
from report_views import report_fields
from literature_meta_views import literature_meta_fields


report_literature_fields = {
    "report_id": fields.Integer,
    "literature_id": fields.Integer
}


class report_literatureListApi(Resource):
    def __init__(self):
        self.parser = reqparse.RequestParser()
        self.parser.add_argument('report_id', type=int, required=True, location='json')
        self.parser.add_argument('literature_id', type=int, required=True, location='json')
        super(report_literatureListApi, self).__init__()

    def post(self):
        args = self.parser.parse_args()
        report_id = args['report_id']
        literature_id = args['literature_id']
        literature = Literature_meta.query.filter_by(id=literature_id).first()
        report = Report.query.filter_by(id=report_id).first()
        report.literatures.append(literature)
        db.session.commit()
        return {'message': 'Add report_literature succeed'}, 201


class report_literatureQuery(Resource):
    def __init__(self):
        self.parser = reqparse.RequestParser()
        self.parser.add_argument('report_id', type=int, location='json')
        self.parser.add_argument('literature_id', type=int, location='json')
        super(report_literatureQuery, self).__init__()


    def post(self):
        args = self.parser.parse_args()
        if args['literature_id']:
            literature = Literature_meta.query.filter_by(id=args['literature_id']).first()
            if literature:
                reports = [marshal(x, report_fields) for x in literature.reports.all()]
                return reports
            else:
                abort(404, message='No reports at all')
        elif args['report_id']:
            report = Report.query.filter_by(id=args['report_id']).first()
            if report:
                literatures = [marshal(x, literature_meta_fields) for x in report.literatures.all()]
                return literatures
            else:
                abort(404, message='No literatures at all')


class report_literatureDel(Resource):
    def __init__(self):
        self.parser = reqparse.RequestParser()
        self.parser.add_argument('report_id', type=int, required=True, location='json')
        self.parser.add_argument('literature_id', type=int, required=True, location='json')
        super(report_literatureDel, self).__init__()


    def post(self):
        args = self.parser.parse_args()
        literature = Literature_meta.query.filter_by(id=args['literature_id']).first()
        report = Report.query.filter_by(id=args['report_id']).first()
        report.literatures.remove(literature)
        db.session.commit()
        return {'message': 'Delete report_literature succeed'}, 201


api.add_resource(report_literatureQuery, '/api/v1/report_literatures/query', endpoint='report_literaturequery')
api.add_resource(report_literatureListApi, '/api/v1/report_literatures', endpoint='report_literatureList')
api.add_resource(report_literatureDel, '/api/v1/report_literatures/del', endpoint='report_literaturedel')
