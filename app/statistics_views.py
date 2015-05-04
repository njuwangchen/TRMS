__author__ = 'justsavor'

from app import db, api
from flask.ext.restful import reqparse, abort, Resource, fields, marshal_with, marshal
from models import *
from datetime import *

statistics_fields = {
    'userId': fields.Integer,
    'userName': fields.String,
    'countLiterature': fields.Integer,
    'countDataSet': fields.Integer,
    'countCode': fields.Integer,
    'countReport': fields.Integer,
    'countSimpleComment': fields.Integer,
    'countComplexComment': fields.Integer
}

class StatisticsListApi(Resource):

    def __init__(self):
        self.parser = reqparse.RequestParser()
        self.parser.add_argument('userId', type=int, location='json')
        self.parser.add_argument('userName', type=unicode, location='json')
        self.parser.add_argument('countLiterature', type=int, location='json')
        self.parser.add_argument('countDataSet', type=int, location='json')
        self.parser.add_argument('countCode', type=int, location='json')
        self.parser.add_argument('countReport', type=int, location='json')
        self.parser.add_argument('countSimpleComment', type=int, location='json')
        self.parser.add_argument('countComplexComment', type=int, location='json')
        super(StatisticsListApi, self).__init__()

    # @marshal_with(statistics_fields)
    def get(self, days):
        days = int(days)
        statisticsList = []
        today = datetime.today()
        userList = User.query.all()
        if userList:
            for user in userList:
                statistics = {}
                statistics['userId'] = user.id
                statistics['countLiterature'] = 0
                statistics['countDataSet'] = 0
                statistics['countCode'] = 0
                statistics['countReport'] = 0
                statistics['countSimpleComment'] = 0
                statistics['countComplexComment'] = 0
                statistics['userName'] = user.name
                countLiteratureCreated = 0
                countLiteratureUpdated = 0
                countDataSetCreated = 0
                countDataSetUpdated = 0
                countCodeCreated = 0
                countCodeUpdated = 0
                countReportCreated = 0
                countReportUpdated = 0

                literatureCreatedList = Literature_meta.query.filter_by(creator_id=user.id).all()
                if literatureCreatedList:
                    for literature in literatureCreatedList:
                        if today-timedelta(days=days) < literature.create_time:
                            countLiteratureCreated += 1

                literatureUpdatedList = Literature_meta.query.filter_by(updater_id=user.id)
                if literatureUpdatedList:
                    for literature in literatureUpdatedList:
                        if today-timedelta(days=days) < literature.update_time:
                            countLiteratureUpdated += 1

                dataSetCreatedList = Data_set.query.filter_by(creator_id=user.id)
                if dataSetCreatedList:
                    for dataSet in dataSetCreatedList:
                        if today-timedelta(days=days) < dataSet.create_time:
                            countDataSetCreated += 1

                dataSetUpdatedList = Data_set.query.filter_by(updater_id=user.id)
                if dataSetUpdatedList:
                    for dataSet in dataSetUpdatedList:
                        if today-timedelta(days=days) < dataSet.update_time:
                            countDataSetUpdated += 1

                codeCreatedList = Code.query.filter_by(creator_id=user.id)
                if codeCreatedList:
                    for code in codeCreatedList:
                        if today-timedelta(days=days) < code.create_time:
                            countCodeCreated += 1

                codeUpdatedList = Code.query.filter_by(updater_id=user.id)
                if codeUpdatedList:
                    for code in codeUpdatedList:
                        if today-timedelta(days=days) < code.update_time:
                            countCodeUpdated += 1

                reportCreatedList = Report.query.filter_by(creator_id=user.id)
                if reportCreatedList:
                    for report in reportCreatedList:
                        if today-timedelta(days=days) < report.create_time:
                            countReportCreated += 1

                reportUpdatedList = Report.query.filter_by(updater_id=user.id)
                if reportUpdatedList:
                    for report in reportUpdatedList:
                        if today-timedelta(days=days) < report.update_time:
                            countReportUpdated += 1

                commentList = Comment.query.filter_by(commenter_id=user.id)
                if commentList:
                    for comment in commentList:
                        if today-timedelta(days=days) < comment.comment_time:
                            if comment.is_simple:
                                statistics['countSimpleComment'] += 1
                            else:
                                statistics['countComplexComment'] += 1

                statistics['countLiterature'] = countLiteratureCreated + countLiteratureUpdated
                statistics['countDataSet'] = countDataSetCreated + countDataSetUpdated
                statistics['countCode'] = countCodeCreated + countDataSetUpdated
                statistics['countReport'] = countReportCreated + countReportUpdated

                statisticsList.append(statistics)
        return statisticsList, 201


api.add_resource(StatisticsListApi, '/api/v1/statistics/<days>', endpoint='statistics')