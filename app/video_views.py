__author__ = 'ClarkWong, Justsavor'

from app import db, app
from flask.ext.restful import reqparse, abort, Api, Resource, fields, marshal_with, marshal
from models import *
api = Api(app)

video_fields = {
    'id': fields.Integer,
    'title': fields.String,
    'literature_id': fields.Integer,
    'creator_id': fields.Integer,
    'updater_id': fields.Integer,
    'create_time': fields.DateTime,
    'update_time': fields.DateTime,
    'description': fields.String,
    'size': fields.Float,
    'uri': fields.String
}

class VideoApi(Resource):

    def __init__(self):
        self.parser = reqparse.RequestParser()
        self.parser.add_argument('title', type=str, required=True, location='json')
        self.parser.add_argument('literature_id', type=int, required=True, location='json')
        self.parser.add_argument('creator_id', type=int, required=True, location='json')
        self.parser.add_argument('updater_id', type=int, required=True, location='json')
        self.parser.add_argument('create_time', required=True, location='json')
        self.parser.add_argument('update_time', required=True, location='json')
        self.parser.add_argument('description', type=str, required=True, location='json')
        self.parser.add_argument('size', type=float, required=True, location='json')
        self.parser.add_argument('url', type=str, required=True, location='json')
        super(VideoApi, self).__init__()

    @marshal_with(video_fields)
    def get(self, video_id):
        video = Video.query.filter_by(id=video_id).first()
        if video:
            return video, 201
        else:
            abort(404, message='Video {} not found'.format(video_id))

    def delete(self, video_id):
        video = Video.query.filter_by(id=video_id).first()
        if video:
            db.session.delete(video)
            db.session.commit()
            return { 'message' : 'Delete Video {} succeed'.format(video_id)}, 201
        else:
            abort(404, message='Video {} not found'.format(video_id))

    @marshal_with(video_fields)
    def put(self, video_id):
        video = Video.query.filter_by(id=video_id).first()
        if video:
            args = self.parser.parse_args()
            for k,v in args.iteritems():
                if v!= None:
                    setattr(video, k, v)
            return video, 201
        else:
            abort(404, message='Video {} not found'.format(video_id))

class VideoListApi(Resource):

    def __init__(self):
        self.parser = reqparse.RequestParser()
        self.parser.add_argument('title', type=str, required=True, location='json')
        self.parser.add_argument('literature_id', type=int, required=True, location='json')
        self.parser.add_argument('creator_id', type=int, required=True, location='json')
        self.parser.add_argument('updater_id', type=int, required=True, location='json')
        self.parser.add_argument('create_time', required=True, location='json')
        self.parser.add_argument('update_time', required=True, location='json')
        self.parser.add_argument('description', type=str, required=True, location='json')
        self.parser.add_argument('size', type=float, required=True, location='json')
        self.parser.add_argument('url', type=str, required=True, location='json')
        super(VideoListApi, self).__init__()

    def get(self):
        videoList = Video.query.all()
        if videoList:
            return [marshal(video, video_fields) for video in videoList]
        else:
            abort(404, message='No Video at all')

    @marshal_with(video_fields)
    def post(self):
        args = self.parser.parse_args()
        title = args['title']
        literature_id = args['literature_id']
        creator_id = args['creator_id']
        updater_id = args['updater_id']
        create_time = args['create_time']
        update_time = args['update_time']
        description = args['description']
        size = args['size']
        url = args['url']
        video = Video(title, literature_id, creator_id, updater_id, create_time, update_time, description, size, url)
        db.session.add(video)
        db.session.commit()
        return video, 201

class VideoQueryApi(Resource):
     def __init__(self):
        self.parser = reqparse.RequestParser()
        self.parser.add_argument('title', type=str, required=True, location='json')
        self.parser.add_argument('literature_id', type=int, required=True, location='json')
        self.parser.add_argument('creator_id', type=int, required=True, location='json')
        self.parser.add_argument('updater_id', type=int, required=True, location='json')
        self.parser.add_argument('create_time', required=True, location='json')
        self.parser.add_argument('update_time', required=True, location='json')
        self.parser.add_argument('description', type=str, required=True, location='json')
        self.parser.add_argument('size', type=float, required=True, location='json')
        self.parser.add_argument('url', type=str, required=True, location='json')
        super(VideoQueryApi, self).__init__()

     def post(self):
        args = self.parser.parse_args()
        title = args['title']
        literature_id = args['literature_id']
        creator_id = args['creator_id']
        updater_id = args['updater_id']
        create_time = args['create_time']
        update_time = args['update_time']
        description = args['description']
        size = args['size']
        url = args['url']
        videoList = Video.query.filter_by(title=title, literature_id=literature_id, creator_id=creator_id, updater_id=updater_id, create_time=create_time, update_time=update_time, description=description, size=size, url=url)
        if videoList:
            return [marshal(video, video_fields) for video in videoList]
        else:
            abort(404, message='No such video at all')

api.add_resource(VideoApi, '/api/v1/videos/<video_id>', endpoint='video')
api.add_resource(VideoListApi, '/api/v1/videos', endpoint='videoList')
api.add_resource(VideoQueryApi, '/api/v1/videos/query', endpoint='videoQuery')