__author__ = 'ClarkWong'

from app import db, api
from flask.ext.restful import reqparse, abort, Resource, fields, marshal_with, marshal
from models import Comment
import dateutil.parser


comment_fields={
    'id' : fields.Integer,
    'commenter_id' : fields.Integer,
    'resource_id' : fields.Integer,
    'type' : fields.Integer,
    'content' : fields.String,
    'star' : fields.Integer,
    'comment_time' : fields.String,
    'is_simple' : fields.Integer,
    'commenter_name' : fields.String
}

class CommentListApi(Resource):
    def __init__(self):
        self.parser = reqparse.RequestParser()
        self.parser.add_argument('commenter_id', type=int,required=True, location='json')
        self.parser.add_argument('resource_id', type=int, required=True,location='json')
        self.parser.add_argument('type', type=int, required=True,location='json')
        self.parser.add_argument('content', type=unicode, location='json')
        self.parser.add_argument('star', type=int, required=True, location='json')
        self.parser.add_argument('comment_time',required=True,location='json')
        self.parser.add_argument('is_simple', required=True, location='json')
        super(CommentListApi, self).__init__()

    # retrieve all comments
    # code finished
    # test finished
    def get(self):
        commentList = Comment.query.all()
        if commentList:
            return [marshal(comment, comment_fields) for comment in commentList]
        else:
            abort(404, message='No Comment at all')

    # add a new comment
    # code finished
    # test finished
    @marshal_with(comment_fields)
    def post(self):
        args = self.parser.parse_args()
        commenter_id = args['commenter_id']
        resource_id = args['resource_id']
        type = args['type']
        content = args['content']
        star = args['star']
        args['comment_time']= dateutil.parser.parse(args['comment_time'])
        comment_time = args['comment_time']
        is_simple = args['is_simple']
        comment = Comment(commenter_id, comment_time, star, resource_id, type, is_simple, content)
        db.session.add(comment)
        db.session.commit()
        return comment, 201

class CommentQueryApi(Resource):
    def __init__(self):
        self.parser = reqparse.RequestParser()
        self.parser.add_argument('commenter_id', type=int, location='json')
        self.parser.add_argument('resource_id', type=int, location='json')
        self.parser.add_argument('type', type=int, location='json')
        self.parser.add_argument('content', type=unicode, location='json')
        self.parser.add_argument('star', type=int, location='json')
        self.parser.add_argument('comment_time', location='json')
        self.parser.add_argument('is_simple', location='json')
        super(CommentQueryApi, self).__init__()

    def post(self):
        args = self.parser.parse_args()
        q = Comment.query
        for attr, value in args.items():
            if value:
                q = q.filter(getattr(Comment, attr).like("%%%s%%" % value))
        if q:
            q = q.order_by(Comment.comment_time.desc())
            result = []
            for comment in q:
                comment.commenter_name = comment.commenter.name
                result.append(marshal(comment, comment_fields))
            return result, 201
        else:
            abort(404, message='No such comments')

api.add_resource(CommentListApi, '/api/v1/comments', endpoint='commentList')
api.add_resource(CommentQueryApi, '/api/v1/comments/query', endpoint='commentQuery')
