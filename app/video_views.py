__author__ = 'ClarkWong, Justsavor'

from app import db, app
from flask.ext.restful import reqparse, abort, Api, Resource, fields, marshal_with, marshal
from models import *
api = Api(app)

video_fields = {
    'id': fields.Integer,
    'literature_id': fields.Integer,
    'size': fields.Float,
    'uri': fields.String
}

class VideoApi(Resource):

    def __init__(self):
        self.parser = reqparse.RequestParser()
        self.parser.add_argument('literature_id', type=int, required=True, location='json')
        self.parser.add_argument('size', type=float, location='json')
        self.parser.add_argument('url', type=str, location='json')
        super(VideoApi, self).__init__()


    def delete(self, video_id):
        video = Video.query.filter_by(id=video_id).first()
        if video:
            db.session.delete(video)
            db.session.commit()
            return { 'message' : 'Delete Video {} succeed'.format(video_id)}, 201
        else:
            abort(404, message='Video {} not found'.format(video_id))


class VideoListApi(Resource):

    def __init__(self):
        self.parser = reqparse.RequestParser()
        self.parser.add_argument('literature_id', type=int, required=True, location='json')
        self.parser.add_argument('size', type=float, location='json')
        self.parser.add_argument('uri', type=str, location='json')
        super(VideoListApi, self).__init__()


    @marshal_with(video_fields)
    def post(self):
        args = self.parser.parse_args()
        literature_id = args['literature_id']
        video = Video(literature_id)
        for k,v in args.iteritems():
            if v:
                setattr(video,k,v)
        db.session.add(video)
        db.session.commit()
        return video, 201

class VideoQueryApi(Resource):
     def __init__(self):
        self.parser = reqparse.RequestParser()
        self.parser.add_argument('literature_id', type=int, required=True, location='json')
        self.parser.add_argument('size', type=float,  location='json')
        self.parser.add_argument('uri', type=str, location='json')
        super(VideoQueryApi, self).__init__()

     def post(self):
        args = self.parser.parse_args()
        q = Video.query
        for attr, value in args.items():
            if value:
                q = q.filter(getattr(Video, attr).like("%%%s%%" % value))
        if q:
            return [marshal(video, video_fields) for video in q]
        else:
            abort(404, message='No such video at all')

api.add_resource(VideoApi, '/api/v1/videos/<video_id>', endpoint='video')
api.add_resource(VideoListApi, '/api/v1/videos', endpoint='videoList')
api.add_resource(VideoQueryApi, '/api/v1/videos/query', endpoint='videoQuery')