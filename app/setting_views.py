# encoding: utf-8

__author__ = 'BAO'

from app import db, app
from flask.ext.restful import reqparse, abort, Api, Resource, fields,marshal_with,marshal
from flask import jsonify
import yaml
from models import Type,Attribute
from attribute_views import attribute_fields
api = Api(app)


class SettingApi(Resource):

    def __init__(self):
        self.parser = reqparse.RequestParser()
        self.parser.add_argument('newSetting', type=dict, location='json')
        self.parser.add_argument('newLiteratureTypes',type=list,location='json')
        super(SettingApi,self).__init__()

    def get(self):
        stream = file("settings.yaml", 'r')
        configData = yaml.load(stream)
        stream.close()

        setting_fields = {}

        for k,v in configData.iteritems():
            if type(v) == type(list()):
                setting_fields[k]=fields.List(fields.String)
            elif type(v) == type(0.1):
                setting_fields[k]=fields.Float
            elif type(v) == type(dict()):
                inner_fields = {}
                for in_k,in_v in v.iteritems():
                    if type(in_v) == type(u" "):
                        inner_fields[in_k] = fields.String
                setting_fields[k] = fields.Nested(inner_fields)

        return marshal(configData,setting_fields),201

    def post(self):
        args = self.parser.parse_args()
        configData = args['newSetting']
        newTypes = args['newLiteratureTypes']
        for newType in newTypes:
            type = Type(newType[u'name'],newType[u'type_id'])
            db.session.add(type)
            db.session.commit()

        stream = file("settings.yaml", 'w')

        # configData['exportFormat'] = {};
        # configData['exportFormat'][u'会议'] = "title. author. publisher."
        # configData['exportFormat'][u'期刊'] = "title. author"
        # configData['exportFormat'][u'你好'] = "title"
        yaml.dump(configData,stream)
        stream.close()
        if configData:
            return "success"
        else:
            return "failed"

class CommentSettingListApi(Resource):
    def __init__(self):
        self.parser = reqparse.RequestParser()
        self.parser.add_argument('newSetting', type=dict, location='json')
        super(CommentSettingListApi,self).__init__()

    def get(self):
        q = Attribute.query.filter_by(type=2)
        return [marshal(attribute,attribute_fields) for attribute in q]

    def post(self):
        args = self.parser.parse_args()
        configData = args['newSetting']
        stream = file("settings.yaml", 'w')

        yaml.dump(configData,stream)
        stream.close()
        if configData:
            return "success"
        else:
            return "failed"


class RefTypeSettingListApi(Resource):
    def __init__(self):
        self.parser = reqparse.RequestParser()
        self.parser.add_argument('newSetting', type=dict, location='json')
        super(RefTypeSettingListApi,self).__init__()

    def get(self):
        q = Attribute.query.filter_by(type=3)
        return [marshal(attribute,attribute_fields) for attribute in q]

    def post(self):
        args = self.parser.parse_args()
        configData = args['newSetting']
        stream = file("settings.yaml", 'w')

        yaml.dump(configData,stream)
        stream.close()
        if configData:
            return "success"
        else:
            return "failed"

api.add_resource(SettingApi, '/api/v1/settings', endpoint='settings')
api.add_resource(CommentSettingListApi, '/api/v1/commentSettings', endpoint='commentSettings')
api.add_resource(RefTypeSettingListApi, '/api/v1/refTypeSettings', endpoint='refsettings')
