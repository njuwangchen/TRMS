# -*- coding: utf-8 -*-

from app import db, app
from flask.ext.restful import reqparse, abort, Api, Resource, fields, marshal_with, marshal
from models import *
import csv
import dateutil.parser
from fuzzywuzzy import fuzz,process

api = Api(app)

literature_meta_fields = {
    'id': fields.Integer,
    'title': fields.String,
    'titleCN': fields.String,
    'abstract': fields.String,
    'abstractCN': fields.String,
    'author': fields.String,
    'authorCN': fields.String,
    'published_year': fields.Integer,
    'publisher': fields.String,
    'publisherCN':fields.String,
    'key_words': fields.String,
    'key_words_CN': fields.String,
    'location': fields.String,
    'institute': fields.String,
    'instructor': fields.String,
    'language': fields.String,
    'pages': fields.Integer,
    'volume': fields.Integer,
    'issue': fields.Integer,
    'section': fields.Integer,
    'edition': fields.String,
    'press': fields.String,
    'editor': fields.String,
    'ISBN': fields.String,
    'ISSN': fields.String,
    'DOI': fields.String,
    'uri': fields.String,
    'creator_id': fields.Integer,
    'updater_id': fields.Integer,
    'literature_type_id': fields.Integer,
    'create_time': fields.String,
    'update_time': fields.String,
    'total_rank' : fields.Integer,
    'rank_num' : fields.Integer,
    'rank_str' : fields.String,
    'file_name' : fields.String,
    'upload_history': fields.String,
    'publisher_abbreviation': fields.String
}

class LiteratureApi(Resource):

    def __init__(self):
        self.parser = reqparse.RequestParser()
        self.parser.add_argument('title', type=unicode,location='json')
        self.parser.add_argument('creator_id', type=int,location='json')
        self.parser.add_argument('create_time', location='json')
        self.parser.add_argument('literature_type_id', type=int, location='json')
        self.parser.add_argument('titleCN', type=unicode,location='json')
        self.parser.add_argument('abstract', location='json')
        self.parser.add_argument('abstractCN', location='json')
        self.parser.add_argument('author', type=unicode, location='json')
        self.parser.add_argument('authorCN', type=unicode, location='json')
        self.parser.add_argument('published_year', type=int, location='json')
        self.parser.add_argument('publisher', type=unicode, location='json')
        self.parser.add_argument('publisherCN', type=unicode, location='json')
        self.parser.add_argument('volume', type=int, location='json')
        self.parser.add_argument('issue', type=int, location='json')
        self.parser.add_argument('location', type=unicode, location='json')
        self.parser.add_argument('institute', type=unicode, location='json')
        self.parser.add_argument('instructor', type=unicode, location='json')
        self.parser.add_argument('key_words', type=unicode, location='json')
        self.parser.add_argument('key_words_CN', type=unicode, location='json')
        self.parser.add_argument('language', type=unicode, location='json')
        self.parser.add_argument('pages', type=int, location='json')
        self.parser.add_argument('section', type=int, location='json')
        self.parser.add_argument('edition', type=unicode, location='json')
        self.parser.add_argument('press', type=unicode, location='json')
        self.parser.add_argument('editor', type=unicode, location='json')
        self.parser.add_argument('ISBN', type=unicode, location='json')
        self.parser.add_argument('ISSN', type=unicode, location='json')
        self.parser.add_argument('DOI', type=unicode, location='json')
        self.parser.add_argument('uri', type=unicode, location='json')
        self.parser.add_argument('updater_id', type=int, location='json')
        self.parser.add_argument('update_time', location='json')
        self.parser.add_argument('total_rank', type=int, location='json')
        self.parser.add_argument('rank_num', type=int, location='json')
        self.parser.add_argument('file_name', type=unicode, location='json')
        self.parser.add_argument('upload_history', type=unicode, location='json')
        self.parser.add_argument('publisher_abbreviation', type=unicode, location='json')
        super(LiteratureApi, self).__init__()

    @marshal_with(literature_meta_fields)
    def get(self, literature_id):
        literature_meta = Literature_meta.query.filter_by(id=literature_id).first()
        if literature_meta.rank_num:
            literature_meta.rank = float(literature_meta.total_rank)/literature_meta.rank_num
            literature_meta.rank_str = '{:.2f} / {}'.format(literature_meta.rank, literature_meta.rank_num)
        else:
            literature_meta.rank_str = u'暂无评分'
        if literature_meta:
            return literature_meta, 201
        else:
            abort(404, message='Literature_meta {} not found'.format(literature_id))

    @marshal_with(literature_meta_fields)
    def put(self, literature_id):
        literature_meta = Literature_meta.query.filter_by(id=literature_id).first()
        if literature_meta:
            args = self.parser.parse_args()
            args['create_time']= dateutil.parser.parse(args['create_time'])
            args['update_time']= dateutil.parser.parse(args['update_time'])
            for k,v in args.iteritems():
                if v!= None:
                    setattr(literature_meta, k, v)
            db.session.commit()
            return literature_meta, 201
        else:
            abort(404, message='Literature_meta {} not found'.format(literature_id))

class LiteratureListApi(Resource):

    def __init__(self):
        self.parser = reqparse.RequestParser()
        self.parser.add_argument('title', type=unicode, required=True, location='json')
        self.parser.add_argument('creator_id', type=int, required=True, location='json')
        self.parser.add_argument('create_time', required=True, location='json')
        self.parser.add_argument('literature_type_id', type=int, required=True, location='json')
        self.parser.add_argument('titleCN', type=unicode,location='json')
        self.parser.add_argument('abstract', location='json')
        self.parser.add_argument('abstractCN', location='json')
        self.parser.add_argument('author', type=unicode, location='json')
        self.parser.add_argument('authorCN', type=unicode, location='json')
        self.parser.add_argument('published_year', type=int, location='json')
        self.parser.add_argument('publisher', type=unicode, location='json')
        self.parser.add_argument('publisherCN', type=unicode, location='json')
        self.parser.add_argument('volume', type=int, location='json')
        self.parser.add_argument('issue', type=int, location='json')
        self.parser.add_argument('location', type=unicode, location='json')
        self.parser.add_argument('institute', type=unicode, location='json')
        self.parser.add_argument('instructor', type=unicode, location='json')
        self.parser.add_argument('key_words', type=unicode, location='json')
        self.parser.add_argument('key_words_CN', type=unicode, location='json')
        self.parser.add_argument('language', type=unicode, location='json')
        self.parser.add_argument('pages', type=int, location='json')
        self.parser.add_argument('section', type=int, location='json')
        self.parser.add_argument('edition', type=unicode, location='json')
        self.parser.add_argument('press', type=unicode, location='json')
        self.parser.add_argument('editor', type=unicode, location='json')
        self.parser.add_argument('ISBN', type=unicode, location='json')
        self.parser.add_argument('ISSN', type=unicode, location='json')
        self.parser.add_argument('DOI', type=unicode, location='json')
        self.parser.add_argument('uri', type=unicode, location='json')
        self.parser.add_argument('updater_id', type=int, location='json')
        self.parser.add_argument('update_time', location='json')
        self.parser.add_argument('total_rank', type=int, location='json')
        self.parser.add_argument('rank_num', type=int, location='json')
        self.parser.add_argument('upload_history', type=unicode, location='json')
        self.parser.add_argument('publisher_abbreviation', type=unicode, location='json')
        super(LiteratureListApi, self).__init__()

    @marshal_with(literature_meta_fields)
    def get(self):
        literature_list = Literature_meta.query.all()
        for literature_meta in literature_list:
            if literature_meta.rank_num:
                literature_meta.rank = float(literature_meta.total_rank)/literature_meta.rank_num
                literature_meta.rank_str = '{:.2f} / {}'.format(literature_meta.rank, literature_meta.rank_num)
            else:
                literature_meta.rank_str = u'暂无评分'
        return literature_list, 201

    @marshal_with(literature_meta_fields)
    def post(self):
        args = self.parser.parse_args()
        title = args['title']
        literature_type_id = args['literature_type_id']
        creator_id = args['creator_id']
        args['create_time']= dateutil.parser.parse(args['create_time'])
        create_time = args['create_time']
        literature_meta = Literature_meta(title=title,creator_id=creator_id,create_time=create_time,literature_type_id=literature_type_id)
        for k,v in args.iteritems():
            if v!= None:
                setattr(literature_meta, k, v)
        db.session.add(literature_meta)
        db.session.commit()
        return literature_meta, 201


class LiteratureQueryApi(Resource):
     def __init__(self):
        self.parser = reqparse.RequestParser()
        self.parser.add_argument('title', type=unicode, location='json')
        self.parser.add_argument('creator_id', type=int, location='json')
        self.parser.add_argument('create_time', location='json')
        self.parser.add_argument('literature_type_id', type=int, location='json')
        self.parser.add_argument('titleCN', type=unicode,location='json')
        self.parser.add_argument('abstract', location='json')
        self.parser.add_argument('abstractCN', location='json')
        self.parser.add_argument('author', type=unicode, location='json')
        self.parser.add_argument('authorCN', type=unicode, location='json')
        self.parser.add_argument('published_year', type=int, location='json')
        self.parser.add_argument('publisher', type=unicode, location='json')
        self.parser.add_argument('publisherCN', type=unicode, location='json')
        self.parser.add_argument('volume', type=int, location='json')
        self.parser.add_argument('issue', type=int, location='json')
        self.parser.add_argument('location', type=unicode, location='json')
        self.parser.add_argument('institute', type=unicode, location='json')
        self.parser.add_argument('instructor', type=unicode, location='json')
        self.parser.add_argument('key_words', type=unicode, location='json')
        self.parser.add_argument('key_words_CN', type=unicode, location='json')
        self.parser.add_argument('language', type=unicode, location='json')
        self.parser.add_argument('pages', type=int, location='json')
        self.parser.add_argument('section', type=int, location='json')
        self.parser.add_argument('edition', type=unicode, location='json')
        self.parser.add_argument('press', type=unicode, location='json')
        self.parser.add_argument('editor', type=unicode, location='json')
        self.parser.add_argument('ISBN', type=unicode, location='json')
        self.parser.add_argument('ISSN', type=unicode, location='json')
        self.parser.add_argument('DOI', type=unicode, location='json')
        self.parser.add_argument('uri', type=unicode, location='json')
        self.parser.add_argument('updater_id', type=int, location='json')
        self.parser.add_argument('update_time', location='json')
        self.parser.add_argument('total_rank', type=int, location='json')
        self.parser.add_argument('rank_num', type=int, location='json')
        self.parser.add_argument('publisher_abbreviation', type=unicode, location='json')
        super(LiteratureQueryApi, self).__init__()

     def post(self):
        args = self.parser.parse_args()
        q = Literature_meta.query
        for attr, value in args.items():
            if value:
                q = q.filter(getattr(Literature_meta, attr).like("%%%s%%" % value))

        if q:
            for literature_meta in q:
                if literature_meta.rank_num:
                    literature_meta.rank = float(literature_meta.total_rank)/literature_meta.rank_num
                    literature_meta.rank_str = '{:.2f} / {}'.format(literature_meta.rank, literature_meta.rank_num)
                else:
                    literature_meta.rank_str = u'暂无评分'
            return [marshal(literature_meta, literature_meta_fields) for literature_meta in q]
        else:
            abort(404, message='No such literature_meta at all')


class LiteratureBatchApi(Resource):
    def __init__(self):
        self.parser = reqparse.RequestParser()
        self.parser.add_argument('ids', type=list, location='json')
        super(LiteratureBatchApi)


    def post(self):
        args = self.parser.parse_args()
        ids = args['ids']
        q = Literature_meta.query
        result = []
        for single in ids:
            tmp = q.filter_by(id = single)
            if tmp:
                result.append(tmp.first())
        for literature_meta in result:
            if literature_meta.rank_num:
                literature_meta.rank = float(literature_meta.total_rank)/literature_meta.rank_num
                literature_meta.rank_str = '{:.2f} / {}'.format(literature_meta.rank, literature_meta.rank_num)
            else:
                literature_meta.rank_str = u'暂无评分'

        return [marshal(literature_meta, literature_meta_fields) for literature_meta in result]

class LiteratureExport(Resource):
    def __init__(self):
        self.parser = reqparse.RequestParser()
        self.parser.add_argument('id', type=int, location='json')
        super(LiteratureExport)

    def post(self):
        args = self.parser.parse_args()
        literature = Literature_meta.query.filter_by(id=args['id']).first()
        result = ""

        if getattr(literature,"literature_type_id")==1:#期刊
            with open('exportJournal.csv','r') as csvfile:
                settingsReader = csv.reader(csvfile,delimiter = ',')
                for row in settingsReader:
                    for each in row:
                        if each == 'title':
                            result += "\""+str(getattr(literature,each)) +"\". "
                        elif each == 'publisher':
                            result += str(getattr(literature,each))+" "
                        elif each == 'issue':
                            result += str(getattr(literature,each))+" "
                        elif each =='year':
                            result += "("+str(getattr(literature,each))+"): "
                        elif each == 'pages':
                            result += str(getattr(literature,each))+"."
                        else:
                            result += str(getattr(literature,each)) +". "

        elif getattr(literature,"literature_type_id")==2:#会议
            with open('exportConf.csv','r') as csvfile:
                settingsReader = csv.reader(csvfile,delimiter = ',')
                for row in settingsReader:
                    for each in row:
                        if each =='title':
                            result += "\""+str(getattr(literature,each))+"\". "
                        elif each =='publisher':
                            result += str(getattr(literature,each))+". Ed. "
                        elif each =='location':
                            result += str(getattr(literature,each))+": "
                        elif each =='press':
                            result += str(getattr(literature,each))+", "
                        else:
                            result += str(getattr(literature,each)) +". "

        return result,201


class LiteratureExportBatch(Resource):
    def __init__(self):
        self.parser = reqparse.RequestParser()
        self.parser.add_argument('ids', type=list, location='json')
        super(LiteratureExportBatch)

    def post(self):
        args = self.parser.parse_args()
        resultList = ""
        for id in args['ids']:
            literature = Literature_meta.query.filter_by(id=id).first()
            result = ""
            if getattr(literature,"literature_type_id")==1:#期刊
                with open('exportJournal.csv','r') as csvfile:
                    settingsReader = csv.reader(csvfile,delimiter = ',')
                    for row in settingsReader:
                        for each in row:
                            if each == 'title':
                                result += "\""+str(getattr(literature,each)) +"\". "
                            elif each == 'publisher':
                                result += str(getattr(literature,each))+" "
                            elif each == 'issue':
                                result += str(getattr(literature,each))+" "
                            elif each =='year':
                                result += "("+str(getattr(literature,each))+"): "
                            elif each == 'pages':
                                result += str(getattr(literature,each))+"."
                            else:
                                result += str(getattr(literature,each)) +". "

            elif getattr(literature,"literature_type_id")==2:#会议
                with open('exportConf.csv','r') as csvfile:
                    settingsReader = csv.reader(csvfile,delimiter = ',')
                    for row in settingsReader:
                        for each in row:
                            if each =='title':
                                result += "\""+str(getattr(literature,each))+"\". "
                            elif each =='publisher':
                                result += str(getattr(literature,each))+". Ed. "
                            elif each =='location':
                                result += str(getattr(literature,each))+": "
                            elif each =='press':
                                result += str(getattr(literature,each))+", "
                            else:
                                result += str(getattr(literature,each)) +". "

            resultList+=result+"\n"
        return resultList,201


class LiteratureFuzzySearchApi(Resource):
     def __init__(self):
        self.parser = reqparse.RequestParser()
        self.parser.add_argument('title', type=unicode, location='json')
        self.parser.add_argument('creator_id', type=int, location='json')
        self.parser.add_argument('create_time', location='json')
        self.parser.add_argument('literature_type_id', type=int, location='json')
        self.parser.add_argument('titleCN', type=unicode,location='json')
        self.parser.add_argument('abstract', location='json')
        self.parser.add_argument('abstractCN', location='json')
        self.parser.add_argument('author', type=unicode, location='json')
        self.parser.add_argument('authorCN', type=unicode, location='json')
        self.parser.add_argument('published_year', type=int, location='json')
        self.parser.add_argument('publisher', type=unicode, location='json')
        self.parser.add_argument('publisherCN', type=unicode, location='json')
        self.parser.add_argument('volume', type=int, location='json')
        self.parser.add_argument('issue', type=int, location='json')
        self.parser.add_argument('location', type=unicode, location='json')
        self.parser.add_argument('institute', type=unicode, location='json')
        self.parser.add_argument('instructor', type=unicode, location='json')
        self.parser.add_argument('key_words', type=unicode, location='json')
        self.parser.add_argument('key_words_CN', type=unicode, location='json')
        self.parser.add_argument('language', type=unicode, location='json')
        self.parser.add_argument('pages', type=int, location='json')
        self.parser.add_argument('section', type=int, location='json')
        self.parser.add_argument('edition', type=unicode, location='json')
        self.parser.add_argument('press', type=unicode, location='json')
        self.parser.add_argument('editor', type=unicode, location='json')
        self.parser.add_argument('ISBN', type=unicode, location='json')
        self.parser.add_argument('ISSN', type=unicode, location='json')
        self.parser.add_argument('DOI', type=unicode, location='json')
        self.parser.add_argument('uri', type=unicode, location='json')
        self.parser.add_argument('updater_id', type=int, location='json')
        self.parser.add_argument('update_time', location='json')
        self.parser.add_argument('total_rank', type=int, location='json')
        self.parser.add_argument('rank_num', type=int, location='json')
        self.parser.add_argument('tags',type=list,location='json')
        super(LiteratureFuzzySearchApi, self).__init__()

     def post(self):
        args = self.parser.parse_args()
        q = Literature_meta.query
        literatures = []
        for attr, value in args.items():
            if value and attr!='title' and attr!='author' and attr!='tags':
                q = q.filter(getattr(Literature_meta, attr).like("%%%s%%" % value))
            elif value and attr=='tags':
                records = set();
                for tag in value:
                    trs = Tag_resource.query.filter_by(tag_id=tag['id'],type=1).all()
                    records = set([tr.resource_id for tr in trs]) | records
                for id in records:
                    item = q.filter_by(id=id).first()
                    if item:
                        literatures.append(item)

        if not args['tags']:
            resultList = []
            literatures = q.all()
            for literature in literatures:
                if args['title']:
                    if fuzz.partial_ratio(args['title'],literature.title)>=60:
                        resultList.append(literature)
                elif args['author']:
                    if fuzz.partial_ratio(args['author'],literature.author)>=60:
                        resultList.append(literature)
        else:
            resultList = literatures
            for literature in literatures:
                if args['title']:
                    if fuzz.partial_ratio(args['title'],literature.title)<60:
                        resultList.remove(literature)
                elif args['author']:
                    if fuzz.partial_ratio(args['author'],literature.author)<60:
                        resultList.remove(literature)
        q = resultList

        if q:
            for literature_meta in q:
                if literature_meta.rank_num:
                    literature_meta.rank = float(literature_meta.total_rank)/literature_meta.rank_num
                    literature_meta.rank_str = '{:.2f} / {}'.format(literature_meta.rank, literature_meta.rank_num)
                else:
                    literature_meta.rank_str = u'暂无评分'
            return [marshal(literature_meta, literature_meta_fields) for literature_meta in q]
        else:
            return []

api.add_resource(LiteratureFuzzySearchApi, '/api/v1/literatures/fuzzysearch', endpoint='literatureFuzzySearch')
api.add_resource(LiteratureBatchApi, '/api/v1/literatures/batch', endpoint='literatureBatch')
api.add_resource(LiteratureApi, '/api/v1/literatures/<literature_id>', endpoint='literature')
api.add_resource(LiteratureListApi, '/api/v1/literatures', endpoint='literatureList')
api.add_resource(LiteratureQueryApi, '/api/v1/literatures/query', endpoint='literature_metaQuery')
api.add_resource(LiteratureExport, '/api/v1/literatures/export', endpoint='literatureExport')
api.add_resource(LiteratureExportBatch, '/api/v1/literatures/exportBatch', endpoint='literatureExportBatch')
