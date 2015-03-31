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
    'comment_time' : fields.String
}

class CommentListApi(Resource):

    def __init__(self):
        self.parser = reqparse.RequestParser()
        self.parser.add_argument('commenter_id', type=int,required=True, location='json')
        self.parser.add_argument('resource_id', type=int, required=True,location='json')
        self.parser.add_argument('type', type=int, required=True,location='json')
        self.parser.add_argument('content', type=str, location='json')
        self.parser.add_argument('star', type=int, required=True, location='json')
        self.parser.add_argument('comment_time',required=True,location='json')
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
        comment = Comment(commenter_id, comment_time, star, resource_id, type, content)
        db.session.add(comment)
        db.session.commit()
        return comment, 201

api.add_resource(CommentListApi, '/api/v1/comments', endpoint='commentList')
