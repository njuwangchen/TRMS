__author__ = 'justsavor'

__author__ = 'justsavor'

from app import db, app
from flask.ext.restful import reqparse, abort, Api, Resource, fields, marshal_with, marshal
from models import *
api = Api(app)

report_recording_fields = {
    'id': fields.Integer,
    'report_id': fields.Integer,
    'recording_name': fields.String,
    'uri': fields.String
}

class Report_recordingApi(Resource):

    def __init__(self):
        self.parser = reqparse.RequestParser()
        self.parser.add_argument('report_id', type=int, required=True, location='json')
        self.parser.add_argument('recording_name', type=unicode, location='json')
        self.parser.add_argument('uri', type=unicode, location='json')
        super(Report_recordingApi, self).__init__()


    def delete(self, report_recording_id):
        report_recording = Report_recording.query.filter_by(id=report_recording_id).first()
        if report_recording:
            db.session.delete(report_recording)
            db.session.commit()
            return { 'message' : 'Delete Report_recording {} succeed'.format(report_recording_id)}, 201
        else:
            abort(404, message='Report_recording {} not found'.format(report_recording_id))


class Report_recordingListApi(Resource):

    def __init__(self):
        self.parser = reqparse.RequestParser()
        self.parser.add_argument('report_id', type=int, required=True, location='json')
        self.parser.add_argument('recording_name', type=unicode, location='json')
        self.parser.add_argument('uri', type=unicode, location='json')
        super(Report_recordingListApi, self).__init__()


    @marshal_with(report_recording_fields)
    def post(self):
        args = self.parser.parse_args()
        report_id = args['report_id']
        report_recording = Report_recording(report_id)
        for k,v in args.iteritems():
            if v:
                setattr(report_recording,k,v)
        db.session.add(report_recording)
        db.session.commit()
        return report_recording, 201

class Report_recordingQueryApi(Resource):
     def __init__(self):
        self.parser = reqparse.RequestParser()
        self.parser.add_argument('report_id', type=int, required=True, location='json')
        self.parser.add_argument('recording_name', type=unicode, location='json')
        self.parser.add_argument('uri', type=unicode, location='json')
        super(Report_recordingQueryApi, self).__init__()

     def post(self):
        args = self.parser.parse_args()
        q = Report_recording.query
        for attr, value in args.items():
            if value:
                q = q.filter(getattr(Report_recording, attr).like("%%%s%%" % value))
        if q:
            return [marshal(report_recording, report_recording_fields) for report_recording in q]
        else:
            abort(404, message='No such report_recording at all')

api.add_resource(Report_recordingApi, '/api/v1/report_recordings/<report_recording_id>', endpoint='report_recording')
api.add_resource(Report_recordingListApi, '/api/v1/report_recordings', endpoint='report_recordingList')
api.add_resource(Report_recordingQueryApi, '/api/v1/report_recordings/query', endpoint='report_recordingQuery')