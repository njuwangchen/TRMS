__author__ = 'ClarkWong'

from app import db, api
from flask.ext.restful import reqparse, abort, Resource, fields, marshal_with, marshal
from models import Comment


comment_fields={
    'id' : fields.Integer,
    'commenter_id' : fields.Integer,
    'resource_id' : fields.Integer,
    'type' : fields.Integer,
    'content' : fields.String,
    'star' : fields.Integer,
    'comment_time' : fields.DateTime
}

class CommentApi(Resource):

    def __init__(self):
        self.parser = reqparse.RequestParser()
        self.parser.add_argument('commenter_id', type=int,required=True, location='json')
        self.parser.add_argument('resource_id', type=int, required=True,location='json')
        self.parser.add_argument('type', type=int, required=True,location='json')
        self.parser.add_argument('content', type=str, location='json')
        self.parser.add_argument('star', type=int, location='json')
        self.parser.add_argument('comment_time', required=True,location='json')
        super(CommentApi, self).__init__()

    @marshal_with(comment_fields)
    def get(self, comment_id):
        comment = Comment.query.filter_by(id=comment_id).first()
        if comment:
            return comment, 201
        else:
            abort(404, message='Comment {} not found'.format(comment_id))

    def delete(self, comment_id):
        comment = Comment.query.filter_by(id=comment_id).first()
        if comment:
            db.session.delete(comment)
            db.session.commit()
            return { 'message' : 'Delete Comment {} succeed'.format(comment_id)}, 201
        else:
            abort(404, message='Comment {} not found'.format(comment_id))

    @marshal_with(comment_fields)
    def put(self, comment_id):
        comment = Comment.query.filter_by(id=comment_id).first()
        if comment:
            args = self.parser.parse_args()
            for k,v in args.iteritems():
                if v!= None:
                    setattr(comment, k, v)
            db.session.commit()
            return comment, 201
        else:
            abort(404, message='Comment {} not found'.format(comment_id))

class CommentListApi(Resource):

    def __init__(self):
        self.parser = reqparse.RequestParser()
        self.parser.add_argument('commenter_id', type=int,required=True, location='json')
        self.parser.add_argument('resource_id', type=int, required=True,location='json')
        self.parser.add_argument('type', type=int, required=True,location='json')
        self.parser.add_argument('content', type=str, location='json')
        self.parser.add_argument('star', type=int, location='json')
        self.parser.add_argument('comment_time',required=True,location='json')
        super(CommentListApi, self).__init__()

    def get(self):
        commentList = Comment.query.all()
        if commentList:
            return [marshal(comment, comment_fields) for comment in commentList]
        else:
            abort(404, message='No Comment at all')
#    def __init__(self, commenter, comment_time, star, resource_id, type, content=''):

    @marshal_with(comment_fields)
    def post(self):
        args = self.parser.parse_args()
        commenter_id = args['commenter_id']
        resource_id = args['resource_id']
        type = args['type']
        content = args['content']
        star = args['star']
        comment_time = args['comment_time']
        comment = Comment(commenter_id, comment_time, star, resource_id, type, content)
        db.session.add(comment)
        db.session.commit()
        return comment, 201
    
class CommentQuery(Resource):
    def __init__(self):
        self.parser = reqparse.RequestParser()
        self.parser.add_argument('commenter_id', type=int,required=True, location='json')
        self.parser.add_argument('resource_id', type=int, required=True,location='json')
        self.parser.add_argument('type', type=int, required=True,location='json')
        super(CommentQuery, self).__init__()


    def post(self):
        args = self.parser.parse_args()
        commenter_id = args['commenter_id']
        resource_id = args['resource_id']
        type = args['type']
        commentList = Comment.query.filter_by(commenter_id=commenter_id,resource_id=resource_id,type=type)
        if commentList:
            return [marshal(comment, comment_fields) for comment in commentList]
        else:
            abort(404, message='No comment at all')


api.add_resource(CommentQuery, '/api/v1/comments/query', endpoint='commentquery')
api.add_resource(CommentListApi, '/api/v1/comments', endpoint='commentList')
api.add_resource(CommentApi, '/api/v1/comments/<comment_id>', endpoint='comment')