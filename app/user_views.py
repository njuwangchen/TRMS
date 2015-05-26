__author__ = 'ClarkWong'

from app import db, api
from flask.ext.restful import reqparse, abort, Resource, fields, marshal_with, marshal
from models import User, Literature_meta, Data_set, Code, Report, Comment,Type
import yaml,re

user_fields = {
    'id': fields.Integer,
    'name': fields.String,
    'password': fields.String,
    'privilege': fields.Integer,
}

login_fields = {
    "isSucceed": fields.Boolean,
    "userNotExist": fields.Boolean,
    "passwdNotRight": fields.Boolean,
    "id": fields.Integer,
    "name": fields.String,
    "privilege": fields.String
}

user_resource_fields = {
    'id': fields.Integer,
    'title': fields.String,
    'updater_name': fields.String,
    'update_time': fields.String
}


class UserApi(Resource):
    def __init__(self):
        self.parser = reqparse.RequestParser()
        self.parser.add_argument('name', type=unicode, location='json')
        self.parser.add_argument('password', type=unicode, location='json')
        self.parser.add_argument('privilege', type=int, location='json')

        super(UserApi, self).__init__()

    @marshal_with(user_fields)
    def get(self, user_id):
        user = User.query.filter_by(id=user_id).first()
        if user:
            return user, 201
        else:
            abort(404, message='User {} not found'.format(user_id))

    def delete(self, user_id):
        user = User.query.filter_by(id=user_id).first()
        if user:
            db.session.delete(user)
            db.session.commit()
            return {'message': 'Delete User {} succeed'.format(user_id)}, 201
        else:
            abort(404, message='User {} not found'.format(user_id))

    @marshal_with(user_fields)
    def put(self, user_id):
        user = User.query.filter_by(id=user_id).first()
        if user:
            args = self.parser.parse_args()
            for k, v in args.iteritems():
                if v != None:
                    setattr(user, k, v)
            db.session.commit()
            return user, 201
        else:
            abort(404, message='User {} not found'.format(user_id))


class UserListApi(Resource):
    def __init__(self):
        self.parser = reqparse.RequestParser()
        self.parser.add_argument('name', type=unicode, required=True, location='json')
        self.parser.add_argument('password', type=unicode, required=True, location='json')
        self.parser.add_argument('privilege', type=int, required=True, location='json')
        super(UserListApi, self).__init__()

    def get(self):
        userList = User.query.all()
        if userList:
            return [marshal(user, user_fields) for user in userList]
        else:
            abort(404, message='No User at all')

    @marshal_with(user_fields)
    def post(self):
        args = self.parser.parse_args()
        name = args['name']
        password = args['password']
        privilege = args['privilege']
        user = User(name, password, privilege)
        db.session.add(user)
        db.session.commit()
        return user, 201


class UserLoginApi(Resource):
    def __init__(self):
        self.parser = reqparse.RequestParser()
        self.parser.add_argument('username', type=unicode, required=True, location='json')
        self.parser.add_argument('password', type=unicode, required=True, location='json')
        super(UserLoginApi, self).__init__()

    @marshal_with(login_fields)
    def post(self):
        result = dict()
        args = self.parser.parse_args()
        user = User.query.filter_by(name=args['username']).first()
        if not user:
            result['isSucceed'] = False
            result['userNotExist'] = True
        elif not user.verify_password(args['password']):
            result['isSucceed'] = False
            result['passwdNotRight'] = True
        else:
            result['isSucceed'] = True
            result['id'] = user.id
            result['name'] = user.name
            result['privilege'] = user.privilege
        return result, 201


class UserResourceApi(Resource):
    def __init__(self):
        self.parser = reqparse.RequestParser()
        self.parser.add_argument('user_id', type=int, required=True, location='json')
        # 0 for query creating, 1 for query updating, 2 for query commenting
        self.parser.add_argument('query_type', type=int, required=True, location='json')
        # 0 for literature, 1 for data_set, 2 for code, 3 for report
        self.parser.add_argument('resource_type', type=int, required=True, location='json')

    def post(self):
        args = self.parser.parse_args()
        user = User.query.get(args['user_id'])
        if user:
            if args['query_type'] == 0:
                if args['resource_type'] == 0:
                    result = user.literatures_create.order_by(Literature_meta.id.desc()).all()
                if args['resource_type'] == 1:
                    result = user.data_sets_create.order_by(Data_set.id.desc()).all()
                if args['resource_type'] == 2:
                    result = user.codes_create.order_by(Code.id.desc()).all()
                if args['resource_type'] == 3:
                    result = user.reports_create.order_by(Report.id.desc()).all()
            if args['query_type'] == 1:
                if args['resource_type'] == 0:
                    result = user.literatures_update.order_by(Literature_meta.update_time.desc()).all()
                if args['resource_type'] == 1:
                    result = user.data_sets_update.order_by(Data_set.update_time.desc()).all()
                if args['resource_type'] == 2:
                    result = user.codes_update.order_by(Code.update_time.desc()).all()
                if args['resource_type'] == 3:
                    result = user.reports_update.order_by(Report.update_time.desc()).all()
            if args['query_type'] == 2:
                if args['resource_type'] == 0:
                    comments = user.comments.filter_by(type=1).order_by(Comment.id.desc()).all()
                    result = set()
                    for comment in comments:
                        literature = Literature_meta.query.get(comment.resource_id)
                        if literature:
                            result.add(literature)
                if args['resource_type'] == 1:
                    comments = user.comments.filter_by(type=2).order_by(Comment.id.desc()).all()
                    result = set()
                    for comment in comments:
                        data_set = Data_set.query.get(comment.resource_id)
                        if data_set:
                            result.add(data_set)
                if args['resource_type'] == 2:
                    comments = user.comments.filter_by(type=3).order_by(Comment.id.desc()).all()
                    result = set()
                    for comment in comments:
                        code = Code.query.get(comment.resource_id)
                        if code:
                            result.add(code)
                if args['resource_type'] == 3:
                    comments = user.comments.filter_by(type=4).order_by(Comment.id.desc()).all()
                    result = set()
                    for comment in comments:
                        report = Report.query.get(comment.resource_id)
                        if report:
                            result.add(report)
            for item in result:
                if item and item.updater:
                    item.updater_name = item.updater.name
            return [marshal(data, user_resource_fields) for data in result], 201


class RecentResourceApi(Resource):
    def __init__(self):
        self.parser = reqparse.RequestParser()
        self.parser.add_argument('query_type', type=int, required=True, location='json')
        self.parser.add_argument('resource_type', type=int, required=True, location='json')

    def post(self):
        args = self.parser.parse_args()
        if args['query_type'] == 0:
            if args['resource_type'] == 0:
                result = Literature_meta.query.order_by(Literature_meta.id.desc()).limit(3)
            if args['resource_type'] == 1:
                result = Data_set.query.order_by(Data_set.id.desc()).limit(3)
            if args['resource_type'] == 2:
                result = Code.query.order_by(Code.id.desc()).limit(3)
            if args['resource_type'] == 3:
                result = Report.query.order_by(Report.id.desc()).limit(3)
        if args['query_type'] == 1:
            if args['resource_type'] == 0:
                result = Literature_meta.query.order_by(Literature_meta.update_time.desc()).limit(3)
            if args['resource_type'] == 1:
                result = Data_set.query.order_by(Data_set.update_time.desc()).limit(3)
            if args['resource_type'] == 2:
                result = Code.query.order_by(Code.update_time.desc()).limit(3)
            if args['resource_type'] == 3:
                result = Report.query.order_by(Report.update_time.desc()).limit(3)
        for item in result:
                if item and item.updater:
                    item.updater_name = item.updater.name
        return [marshal(data, user_resource_fields) for data in result], 201

class UserExportApi(Resource):
    def __init__(self):
        self.parser = reqparse.RequestParser()
        super(UserExportApi,self).__init__()

    def get(self,user_id):
        comments = Comment.query.filter_by(commenter_id = user_id,type = 1)

        resultList="";
        stream = file("settings.yaml", 'r')
        configData = yaml.load(stream)
        stream.close()

        literatureIds = [comment.resource_id for comment in comments]
        literatureIds = set(literatureIds)

        for literatureId in literatureIds:
            resultList += "Literature:\n"
            literature = Literature_meta.query.get(literatureId)
            if literature:
                literature_types = Type.query.filter_by(type_id = 1)
                for literature_type in literature_types:
                    if literature_type.id == literature.literature_type_id:
                        type_name = literature_type.name

                exportFormat = configData['exportFormat']
                settingLine = exportFormat[unicode(type_name)]
                matchedFields = re.findall(r"\w+",settingLine)
                for field in matchedFields:
                    if getattr(literature,field):
                        settingLine = re.sub(field,unicode(getattr(literature,field)),settingLine)
            resultList+=settingLine+"\n"

            for comment in comments:
                resultList+="Comment:\n"+str(comment.comment_time)+"\t"+comment.content+"\n"

            resultList+="\n"


        # for comment in comments:
        #     resultList += "Literature:\n"
        #     literature = Literature_meta.query.get(comment.resource_id)
        #     if literature:
        #
        #         literature_types = Type.query.filter_by(type_id = 1)
        #         for literature_type in literature_types:
        #             if literature_type.id == literature.literature_type_id:
        #                 type_name = literature_type.name
        #
        #         exportFormat = configData['exportFormat']
        #         settingLine = exportFormat[unicode(type_name)]
        #         matchedFields = re.findall(r"\w+",settingLine)
        #         for field in matchedFields:
        #             if getattr(literature,field):
        #                 settingLine = re.sub(field,unicode(getattr(literature,field)),settingLine)
        #     resultList+=settingLine+"\n"
        #     resultList+="Comment:\n"+str(comment.comment_time)+"\t"+comment.content+"\n"

        return resultList,201

api.add_resource(UserListApi, '/api/v1/users', endpoint='userList')
api.add_resource(UserApi, '/api/v1/users/<user_id>', endpoint='user')
api.add_resource(UserLoginApi, '/api/v1/users/login', endpoint='userLogin')
api.add_resource(UserResourceApi, '/api/v1/users/resources', endpoint='userResource')
api.add_resource(RecentResourceApi, '/api/v1/users/recent', endpoint='recentResource')
api.add_resource(UserExportApi,"/api/v1/users/export/<user_id>",endpoint = "userExport")