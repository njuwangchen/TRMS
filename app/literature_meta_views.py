__author__ = 'ClarkWong, Justsavor'

from app import db, app
from flask.ext.restful import reqparse, abort, Api, Resource, fields, marshal_with, marshal
from models import *
api = Api(app)

literature_meta_fields = {
    'id': fields.Integer,
    'title': fields.String,
    'creator_id': fields.Integer,
    'literature_type_id': fields.Integer,
    'abstract': fields.String,
    'author': fields.String,
    'published_year': fields.Integer,
    'key_words': fields.String,
    'link': fields.String,
    'updater_id': fields.Integer,
    'create_time': fields.DateTime,
    'update_time': fields.DateTime,
    'pages': fields.Integer,
    'uri': fields.String
}

class Literature_metaApi(Resource):

    def __init__(self):
        self.parser = reqparse.RequestParser()
        self.parser.add_argument('title', type=str, required=True, location='json')
        self.parser.add_argument('creator_id', type=int, required=True, location='json')
        self.parser.add_argument('updater_id', type=int, required=True, location='json')
        self.parser.add_argument('literature_type_id', type=int, required=True, location='json')
        self.parser.add_argument('create_time', required=True, location='json')
        self.parser.add_argument('update_time', required=True, location='json')
        self.parser.add_argument('abstract', type=str, required=True, location='json')
        self.parser.add_argument('author', type=str, required=True, location='json')
        self.parser.add_argument('published_year', type=int, required=True, location='json')
        self.parser.add_argument('key_words', type=str, required=True, location='json')
        self.parser.add_argument('link', type=str, required=True, location='json')
        self.parser.add_argument('pages', type=float, required=True, location='json')
        self.parser.add_argument('url', type=str, required=True, location='json')
        super(Literature_metaApi, self).__init__()

    @marshal_with(literature_meta_fields)
    def get(self, literature_meta_id):
        literature_meta = Literature_meta.query.filter_by(id=literature_meta_id).first()
        if literature_meta:
            return literature_meta, 201
        else:
            abort(404, message='Literature_meta {} not found'.format(literature_meta_id))

    def delete(self, literature_meta_id):
        literature_meta = Literature_meta.query.filter_by(id=literature_meta_id).first()
        if literature_meta:
            db.session.delete(literature_meta)
            db.session.commit()
            return { 'message' : 'Delete Literature_meta {} succeed'.format(literature_meta_id)}, 201
        else:
            abort(404, message='Literature_meta {} not found'.format(literature_meta_id))

    @marshal_with(literature_meta_fields)
    def put(self, literature_meta_id):
        literature_meta = Literature_meta.query.filter_by(id=literature_meta_id).first()
        if literature_meta:
            args = self.parser.parse_args()
            for k,v in args.iteritems():
                if v!= None:
                    setattr(literature_meta, k, v)
            return literature_meta, 201
        else:
            abort(404, message='Literature_meta {} not found'.format(literature_meta_id))

class Literature_metaListApi(Resource):

    def __init__(self):
        self.parser = reqparse.RequestParser()
        self.parser.add_argument('title', type=str, required=True, location='json')
        self.parser.add_argument('creator_id', type=int, required=True, location='json')
        self.parser.add_argument('updater_id', type=int, required=True, location='json')
        self.parser.add_argument('literature_type_id', type=int, required=True, location='json')
        self.parser.add_argument('create_time', required=True, location='json')
        self.parser.add_argument('update_time', required=True, location='json')
        self.parser.add_argument('abstract', type=str, required=True, location='json')
        self.parser.add_argument('author', type=str, required=True, location='json')
        self.parser.add_argument('published_year', type=int, required=True, location='json')
        self.parser.add_argument('key_words', type=str, required=True, location='json')
        self.parser.add_argument('link', type=str, required=True, location='json')
        self.parser.add_argument('pages', type=float, required=True, location='json')
        self.parser.add_argument('url', type=str, required=True, location='json')
        super(Literature_metaListApi, self).__init__()

    def get(self):
        literature_metaList = Literature_meta.query.all()
        if literature_metaList:
            return [marshal(literature_meta, literature_meta_fields) for literature_meta in literature_metaList]
        else:
            abort(404, message='No Literature_meta at all')

    @marshal_with(literature_meta_fields)
    def post(self):
        args = self.parser.parse_args()
        title = args['title']
        author = args['author']
        published_year = args['published_year']
        key_words = args['key_words']
        link = args['link']
        literature_type_id = args['literature_type_id']
        creator_id = args['creator_id']
        updater_id = args['updater_id']
        create_time = args['create_time']
        update_time = args['update_time']
        abstract = args['abstract']
        pages = args['pages']
        url = args['url']
        literature_meta = Literature_meta(title, author, published_year, key_words, link, literature_type_id, creator_id, updater_id, create_time, update_time, abstract, pages, url)
        db.session.add(literature_meta)
        db.session.commit()
        return literature_meta, 201

class Literature_metaQueryApi(Resource):
     def __init__(self):
        self.parser = reqparse.RequestParser()
        self.parser.add_argument('title', type=str, required=True, location='json')
        self.parser.add_argument('creator_id', type=int, required=True, location='json')
        self.parser.add_argument('updater_id', type=int, required=True, location='json')
        self.parser.add_argument('literature_type_id', type=int, required=True, location='json')
        self.parser.add_argument('create_time', required=True, location='json')
        self.parser.add_argument('update_time', required=True, location='json')
        self.parser.add_argument('abstract', type=str, required=True, location='json')
        self.parser.add_argument('author', type=str, required=True, location='json')
        self.parser.add_argument('published_year', type=int, required=True, location='json')
        self.parser.add_argument('key_words', type=str, required=True, location='json')
        self.parser.add_argument('link', type=str, required=True, location='json')
        self.parser.add_argument('pages', type=float, required=True, location='json')
        self.parser.add_argument('url', type=str, required=True, location='json')
        super(Literature_metaQueryApi, self).__init__()

     def post(self):
        args = self.parser.parse_args()
        title = args['title']
        author = args['author']
        published_year = args['published_year']
        key_words = args['key_words']
        link = args['link']
        literature_type_id = args['literature_type_id']
        creator_id = args['creator_id']
        updater_id = args['updater_id']
        create_time = args['create_time']
        update_time = args['update_time']
        abstract = args['abstract']
        pages = args['pages']
        url = args['url']
        literature_metaList = Literature_meta.query.filter_by(title=title, author=author, published_year=published_year, key_words=key_words, link=link, literature_type_id=literature_type_id, creator_id=creator_id, updater_id=updater_id, create_time=create_time, update_time=update_time, abstract=abstract, pages=pages, url=url)
        if literature_metaList:
            return [marshal(literature_meta, literature_meta_fields) for literature_meta in literature_metaList]
        else:
            abort(404, message='No such literature_meta at all')

api.add_resource(Literature_metaApi, '/api/v1/literature_metas/<literature_meta_id>', endpoint='literature_meta')
api.add_resource(Literature_metaListApi, '/api/v1/literature_metas', endpoint='literature_metaList')
api.add_resource(Literature_metaQueryApi, '/api/v1/literature_metas/query', endpoint='literature_metaQuery')