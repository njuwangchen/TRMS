__author__ = 'justsavor'

from app import db, app
from flask.ext.restful import reqparse, abort, Api, Resource, fields, marshal_with, marshal
from models import *
api = Api(app)

report_attachment_fields = {
    'id': fields.Integer,
    'report_id': fields.Integer,
    'attachment_name': fields.String,
    'uri': fields.String
}

class Report_attachmentApi(Resource):

    def __init__(self):
        self.parser = reqparse.RequestParser()
        self.parser.add_argument('report_id', type=int, required=True, location='json')
        self.parser.add_argument('attachment_name', type=unicode, location='json')
        self.parser.add_argument('uri', type=unicode, location='json')
        super(Report_attachmentApi, self).__init__()


    def delete(self, report_attachment_id):
        report_attachment = Report_attachment.query.filter_by(id=report_attachment_id).first()
        if report_attachment:
            db.session.delete(report_attachment)
            db.session.commit()
            return { 'message' : 'Delete Report_attachment {} succeed'.format(report_attachment_id)}, 201
        else:
            abort(404, message='Report_attachment {} not found'.format(report_attachment_id))


class Report_attachmentListApi(Resource):

    def __init__(self):
        self.parser = reqparse.RequestParser()
        self.parser.add_argument('report_id', type=int, required=True, location='json')
        self.parser.add_argument('attachment_name', type=unicode, location='json')
        self.parser.add_argument('uri', type=unicode, location='json')
        super(Report_attachmentListApi, self).__init__()


    @marshal_with(report_attachment_fields)
    def post(self):
        args = self.parser.parse_args()
        report_id = args['report_id']
        report_attachment = Report_attachment(report_id)
        for k,v in args.iteritems():
            if v:
                setattr(report_attachment,k,v)
        db.session.add(report_attachment)
        db.session.commit()
        return report_attachment, 201

class Report_attachmentQueryApi(Resource):
     def __init__(self):
        self.parser = reqparse.RequestParser()
        self.parser.add_argument('report_id', type=int, required=True, location='json')
        self.parser.add_argument('attachment_name', type=unicode, location='json')
        self.parser.add_argument('uri', type=unicode, location='json')
        super(Report_attachmentQueryApi, self).__init__()

     def post(self):
        args = self.parser.parse_args()
        q = Report_attachment.query
        for attr, value in args.items():
            if value:
                q = q.filter(getattr(Report_attachment, attr).like("%%%s%%" % value))
        if q:
            return [marshal(report_attachment, report_attachment_fields) for report_attachment in q]
        else:
            abort(404, message='No such report_attachment at all')

api.add_resource(Report_attachmentApi, '/api/v1/report_attachments/<report_attachment_id>', endpoint='report_attachment')
api.add_resource(Report_attachmentListApi, '/api/v1/report_attachments', endpoint='report_attachmentList')
api.add_resource(Report_attachmentQueryApi, '/api/v1/report_attachments/query', endpoint='report_attachmentQuery')