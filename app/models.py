__author__ = 'ClarkWong'

from app import db

class User(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(20), nullable=False)
    password = db.Column(db.String(32), nullable=False)
    privilege = db.Column(db.Integer, nullable=False)

    def __init__(self, name, password, privilege):
        self.name = name
        self.password = password
        self.privilege = privilege

    def verify_password(self, password):
        return password == self.password


data_set_literature = db.Table('data_set_literature',
                               db.Column('data_set_id', db.Integer, db.ForeignKey('data_set.id'), primary_key=True),
                               db.Column('literature_id', db.Integer, db.ForeignKey('literature_meta.id'),
                                         primary_key=True))

code_literature = db.Table('code_literature',
                           db.Column('code_id', db.Integer, db.ForeignKey('code.id'), primary_key=True),
                           db.Column('literature_id', db.Integer, db.ForeignKey('literature_meta.id'),
                                     primary_key=True))

report_literature = db.Table('report_literature',
                             db.Column('report_id', db.Integer, db.ForeignKey('report.id'), primary_key=True),
                             db.Column('literature_id', db.Integer, db.ForeignKey('literature_meta.id'),
                                       primary_key=True))

report_data_set = db.Table('report_data_set',
                           db.Column('report_id', db.Integer, db.ForeignKey('report.id'), primary_key=True),
                           db.Column('data_set_id', db.Integer, db.ForeignKey('data_set.id'),
                                     primary_key=True))

report_code = db.Table('report_code',
                       db.Column('report_id', db.Integer, db.ForeignKey('report.id'), primary_key=True),
                       db.Column('code_id', db.Integer, db.ForeignKey('code.id'),
                                 primary_key=True))


class Cite(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    literature_id = db.Column(db.Integer, db.ForeignKey('literature_meta.id'), nullable=False)
    literature = db.relationship('Literature_meta', primaryjoin='Cite.literature_id==Literature_meta.id',
                                 backref=db.backref('cite_set', lazy='dynamic'))
    cited_id = db.Column(db.Integer, db.ForeignKey('literature_meta.id'), nullable=False)
    cited = db.relationship('Literature_meta', primaryjoin='Cite.cited_id==Literature_meta.id',
                            backref=db.backref('cited_set', lazy='dynamic'))
    cite_type_id = db.Column(db.Integer, db.ForeignKey('type.id'), nullable=False)
    type = db.relationship('Type', backref=db.backref('cites', lazy='dynamic'))

    def __init__(self, literature_id, cited_id, cite_type_id):
        self.literature_id = literature_id
        self.cited_id = cited_id
        self.cite_type_id = cite_type_id


class Report(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(256), nullable=False)
    report_date = db.Column(db.String(256))
    reporter = db.Column(db.String(256))
    company = db.Column(db.String(256))
    reporter_title = db.Column(db.String(256))
    location = db.Column(db.String(256))

    creator_id = db.Column(db.Integer, db.ForeignKey('user.id'), nullable=False)
    creator = db.relationship('User', backref=db.backref('reports_create', lazy='dynamic'),
                              foreign_keys=[creator_id])

    updater_id = db.Column(db.Integer, db.ForeignKey('user.id'))
    updater = db.relationship('User', backref=db.backref('reports_update', lazy='dynamic'),
                              foreign_keys=[updater_id])

    create_time = db.Column(db.DateTime, nullable=False)
    update_time = db.Column(db.DateTime)

    total_rank = db.Column(db.Integer)
    rank_num = db.Column(db.Integer)

    data_sets = db.relationship('Data_set', secondary=report_data_set,
                                backref=db.backref('reports', lazy='dynamic'), lazy='dynamic')
    codes = db.relationship('Code', secondary=report_code, backref=db.backref('reports', lazy='dynamic'),
                            lazy='dynamic')
    literatures = db.relationship('Literature_meta', secondary=report_literature, backref=db.backref('reports', lazy='dynamic'), lazy='dynamic')


    def __init__(self, title, creator_id, create_time, report_date=None, reporter='', company='', reporter_title='', location='', updater_id=None,
                 update_time=None, total_rank=0, rank_num=0):
        self.title = title
        self.creator_id = creator_id
        self.create_time = create_time
        self.report_date = report_date
        self.reporter = reporter
        self.company = company
        self.reporter_title = reporter_title
        self.location = location
        self.updater_id = updater_id
        self.update_time = update_time
        self.total_rank = total_rank
        self.rank_num = rank_num

class Report_attachment(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    report_id = db.Column(db.Integer, db.ForeignKey('report.id'))
    report = db.relationship('Report', backref=db.backref('attachments', lazy='dynamic'))

    uri = db.Column(db.String(256))
    attachment_name = db.Column(db.String(256))

    def __init__(self, report_id, uri='', attachment_name=''):
        self.report_id=report_id
        self.uri=uri
        self.attachment_name=attachment_name

class Report_recording(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    report_id = db.Column(db.Integer, db.ForeignKey('report.id'))
    report = db.relationship('Report', backref=db.backref('recordings', lazy='dynamic'))

    uri = db.Column(db.String(256))
    recording_name = db.Column(db.String(256))

    def __init__(self, report_id, uri='', recording_name=''):
        self.report_id=report_id
        self.uri=uri
        self.recording_name=recording_name

class Literature_meta(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(256), nullable=False)
    titleCN = db.Column(db.String(256))
    abstract = db.Column(db.Text)
    abstractCN = db.Column(db.Text)
    author = db.Column(db.String(256))
    authorCN = db.Column(db.String(256))
    published_year = db.Column(db.Integer)
    publisher = db.Column(db.String(256))
    publisherCN = db.Column(db.String(256))
    key_words = db.Column(db.String(256))
    key_words_CN = db.Column(db.String(256))
    location = db.Column(db.String(256))
    institute = db.Column(db.String(256))
    instructor = db.Column(db.String(256))
    language = db.Column(db.String(256))
    pages = db.Column(db.Integer)
    volume = db.Column(db.Integer)
    issue = db.Column(db.Integer)
    section = db.Column(db.Integer)
    edition = db.Column(db.String(256))
    press = db.Column(db.String(256))
    editor = db.Column(db.String(256))
    ISBN = db.Column(db.String(256))
    ISSN = db.Column(db.String(256))
    DOI = db.Column(db.String(256))

    uri = db.Column(db.String(256))

    creator_id = db.Column(db.Integer, db.ForeignKey('user.id'), nullable=False)
    creator = db.relationship('User', backref=db.backref('literatures_create', lazy='dynamic'),
                              foreign_keys=[creator_id])

    updater_id = db.Column(db.Integer, db.ForeignKey('user.id'))
    updater = db.relationship('User', backref=db.backref('literatures_update', lazy='dynamic'),
                              foreign_keys=[updater_id])

    literature_type_id = db.Column(db.Integer, db.ForeignKey('type.id'), nullable=False)
    type = db.relationship('Type', backref=db.backref('literatures', lazy='dynamic'))

    create_time = db.Column(db.DateTime, nullable=False)
    update_time = db.Column(db.DateTime)

    data_sets = db.relationship('Data_set', secondary=data_set_literature,
                                backref=db.backref('literatures', lazy='dynamic'), lazy='dynamic')
    codes = db.relationship('Code', secondary=code_literature, backref=db.backref('literatures', lazy='dynamic'),
                            lazy='dynamic')

    total_rank = db.Column(db.Integer)
    rank_num = db.Column(db.Integer)
    file_name = db.Column(db.String(256))

    upload_history = db.Column(db.Text)

    publisher_abbreviation = db.Column(db.String(128))


    def __init__(self, title, creator_id, create_time, literature_type_id, titleCN='', abstract='', abstractCN='',
                 author='', authorCN='', published_year=0, publisher='', publisherCN='', volume=0, issue=0, location='',
                 institute='', instructor='', key_words='', key_words_CN='', language='', pages=0, section=0,
                 edition='', press='', editor='', ISBN='', ISSN='', DOI='', uri='', updater_id=None, update_time=None, total_rank=0, rank_num=0, file_name='', upload_history='', publisher_abbreviation=''):
        self.title = title
        self.creator_id = creator_id
        self.create_time = create_time
        self.literature_type_id = literature_type_id
        self.titleCN = titleCN
        self.abstract = abstract
        self.abstractCN = abstractCN
        self.author = author
        self.authorCN = authorCN
        self.published_year = published_year
        self.publisher = publisher
        self.publisherCN = publisherCN
        self.volume = volume
        self.issue = issue
        self.location = location
        self.institute = institute
        self.instructor = instructor
        self.key_words = key_words
        self.key_words_CN = key_words_CN
        self.language = language
        self.pages = pages
        self.section = section
        self.edition = edition
        self.press = press
        self.editor = editor
        self.ISBN = ISBN
        self.ISSN = ISSN
        self.DOI = DOI
        self.uri = uri
        self.updater_id = updater_id
        self.update_time = update_time
        self.total_rank = total_rank
        self.rank_num = rank_num
        self.file_name = file_name
        self.upload_history = upload_history
        self.publisher_abbreviation = publisher_abbreviation


class Type(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(64), nullable=False)
    type_id = db.Column(db.Integer, nullable=False)

    def __init__(self, name, type_id):
        self.name = name
        self.type_id = type_id


class Video(db.Model):
    id = db.Column(db.Integer, primary_key=True)

    literature_id = db.Column(db.Integer, db.ForeignKey('literature_meta.id'))
    literature = db.relationship('Literature_meta', backref=db.backref('Video', lazy='dynamic'))

    size = db.Column(db.Float)
    uri = db.Column(db.String(256))

    video_name = db.Column(db.String(256))

    def __init__(self, literature_id, size=0, uri='', video_name=''):
        self.literature_id = literature_id
        self.size = size
        self.uri = uri
        self.video_name = video_name


class Ppt(db.Model):
    id = db.Column(db.Integer, primary_key=True)

    literature_id = db.Column(db.Integer, db.ForeignKey('literature_meta.id'))
    literature = db.relationship('Literature_meta', backref=db.backref('Ppt', lazy='dynamic'))

    size = db.Column(db.Float)
    uri = db.Column(db.String(256))

    ppt_name = db.Column(db.String(256))

    def __init__(self, literature_id, size=0, uri='', ppt_name=''):
        self.literature_id = literature_id
        self.size = size
        self.uri = uri
        self.ppt_name = ppt_name


class Data_set(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(256), nullable=False)

    creator_id = db.Column(db.Integer, db.ForeignKey('user.id'), nullable=False)
    creator = db.relationship('User', backref=db.backref('data_sets_create', lazy='dynamic'), foreign_keys=[creator_id])

    updater_id = db.Column(db.Integer, db.ForeignKey('user.id'))
    updater = db.relationship('User', backref=db.backref('data_sets_update', lazy='dynamic'), foreign_keys=[updater_id])

    create_time = db.Column(db.DateTime, nullable=False)
    update_time = db.Column(db.DateTime)

    description = db.Column(db.Text)
    size = db.Column(db.Float)
    uri = db.Column(db.String(256))

    data_set_type_id = db.Column(db.Integer, db.ForeignKey('type.id'), nullable=False)
    type = db.relationship('Type', backref=db.backref('data_sets', lazy='dynamic'))

    total_rank = db.Column(db.Integer)
    rank_num = db.Column(db.Integer)
    file_name = db.Column(db.String(256))

    link = db.Column(db.String(256))
    publisher = db.Column(db.String(256))

    upload_history = db.Column(db.Text)

    from_literature_id = db.Column(db.Integer, db.ForeignKey('literature_meta.id'))
    from_literature = db.relationship('Literature_meta', backref=db.backref('data_sets_post', lazy='dynamic'))

    def __init__(self, title, creator_id, create_time, data_set_type_id, updater_id=None, update_time=None,
                 description='', size=0, uri='', total_rank=0, rank_num=0, file_name='', link='', publisher='', upload_history='', from_literature_id=None):
        self.title = title
        self.creator_id = creator_id
        self.create_time = create_time
        self.data_set_type_id = data_set_type_id
        self.updater_id = updater_id
        self.update_time = update_time
        self.description = description
        self.size = size
        self.uri = uri
        self.total_rank = total_rank
        self.rank_num = rank_num
        self.file_name = file_name
        self.link = link
        self.publisher = publisher
        self.upload_history = upload_history
        self.from_literature_id = from_literature_id


class Code(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(256), nullable=False)

    creator_id = db.Column(db.Integer, db.ForeignKey('user.id'), nullable=False)
    creator = db.relationship('User', backref=db.backref('codes_create', lazy='dynamic'), foreign_keys=[creator_id])

    updater_id = db.Column(db.Integer, db.ForeignKey('user.id'))
    updater = db.relationship('User', backref=db.backref('codes_update', lazy='dynamic'), foreign_keys=[updater_id])

    create_time = db.Column(db.DateTime, nullable=False)
    update_time = db.Column(db.DateTime)

    description = db.Column(db.Text)
    size = db.Column(db.Float)
    uri = db.Column(db.String(256), nullable=False)

    language = db.Column(db.String(64))

    total_rank = db.Column(db.Integer)
    rank_num = db.Column(db.Integer)
    file_name = db.Column(db.String(256))

    link = db.Column(db.String(256))
    publisher = db.Column(db.String(256))

    upload_history = db.Column(db.Text)

    from_literature_id = db.Column(db.Integer, db.ForeignKey('literature_meta.id'))
    from_literature = db.relationship('Literature_meta', backref=db.backref('codes_post', lazy='dynamic'))

    def __init__(self, title, creator_id, create_time, updater_id=None, update_time=None, description='', size=0,
                 uri='', language='', total_rank=0, rank_num=0, file_name='', link='', publisher='', upload_history='', from_literature_id=None):
        self.title = title
        self.creator_id = creator_id
        self.create_time = create_time
        self.updater_id = updater_id
        self.update_time = update_time
        self.description = description
        self.size = size
        self.uri = uri
        self.language = language
        self.total_rank = total_rank
        self.rank_num = rank_num
        self.file_name = file_name
        self.link = link
        self.publisher = publisher
        self.upload_history = upload_history
        self.from_literature_id = from_literature_id


class Comment(db.Model):
    id = db.Column(db.Integer, primary_key=True)

    commenter_id = db.Column(db.Integer, db.ForeignKey('user.id'), nullable=False)
    commenter = db.relationship('User', backref=db.backref('comments', lazy='dynamic'))

    resource_id = db.Column(db.Integer, nullable=False)
    type = db.Column(db.Integer, nullable=False)

    content = db.Column(db.Text)
    star = db.Column(db.Integer, nullable=False)
    comment_time = db.Column(db.DateTime, nullable=False)

    is_simple = db.Column(db.Integer, nullable=False)

    def __init__(self, commenter_id, comment_time, star, resource_id, type, is_simple, content=''):
        self.commenter_id = commenter_id
        self.comment_time = comment_time
        self.star = star
        self.resource_id = resource_id
        self.type = type
        self.is_simple = is_simple
        self.content = content


class Attribute(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(64), nullable=False)

    def __init__(self, name):
        self.name = name


class Tag(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(64), nullable=False)

    def __init__(self, name):
        self.name = name


class Tag_resource(db.Model):
    id = db.Column(db.Integer, primary_key=True)

    resource_id = db.Column(db.Integer, nullable=False)
    type = db.Column(db.Integer, nullable=False)

    tag_id = db.Column(db.Integer, db.ForeignKey('tag.id'), nullable=False)
    tag = db.relationship('Tag', backref=db.backref('resources', lazy='dynamic'))

    def __init__(self, resource_id, type, tag_id):
        self.resource_id = resource_id
        self.type = type
        self.tag_id = tag_id


class Favorite(db.Model):
    id = db.Column(db.Integer, primary_key=True)

    user_id = db.Column(db.Integer, db.ForeignKey('user.id'), nullable=False)
    user = db.relationship('User', backref=db.backref('favorite_dirs', lazy='dynamic'))

    name = db.Column(db.String(64), nullable=False)

    def __init__(self, user_id, name):
        self.user_id = user_id
        self.name = name


class Favorite_resource(db.Model):
    id = db.Column(db.Integer, primary_key=True)

    resource_id = db.Column(db.Integer, nullable=False)
    type = db.Column(db.Integer, nullable=False)

    favorite_id = db.Column(db.Integer, db.ForeignKey('favorite.id'), nullable=False)
    favorite_dir = db.relationship('Favorite', backref=db.backref('resources', lazy='dynamic'))

    favorite_time = db.Column(db.DateTime, nullable=False)

    def __init__(self, resource_id, type, favorite_id, favorite_time):
        self.resource_id = resource_id
        self.type = type
        self.favorite_id = favorite_id
        self.favorite_time = favorite_time

class Personalized(db.Model):
    id = db.Column(db.Integer, primary_key=True)

    literature_id = db.Column(db.Integer, db.ForeignKey('literature_meta.id'), nullable=False)
    literature = db.relationship('Literature_meta', backref=db.backref('personals', lazy='dynamic'))

    user_id = db.Column(db.Integer, db.ForeignKey('user.id'), nullable=False)
    user = db.relationship('User', backref=db.backref('personals', lazy='dynamic'))

    uri = db.Column(db.String(256), nullable=False)
    fileName = db.Column(db.String(256))

    def __init__(self, literature_id, user_id, uri, fileName=''):
        self.literature_id = literature_id
        self.user_id  = user_id
        self.uri = uri
        self.fileName = fileName

class KB_Conference(db.Model):
    id = db.Column(db.Integer, primary_key=True)

    abbreviation = db.Column(db.String(128), nullable=False)
    full = db.Column(db.String(256), nullable=False)

    def __init__(self, abbreviation, full):
        self.abbreviation = abbreviation
        self.full = full

class KB_Conference_Year(db.Model):
    id = db.Column(db.Integer, primary_key=True)

    abbreviation = db.Column(db.String(128), nullable=False)
    year = db.Column(db.Integer, nullable=False)

    location = db.Column(db.String(256), nullable=False)
    editor = db.Column(db.String(256), nullable=False)

    def __init__(self, abbreviation, year, location, editor):
        self.abbreviation = abbreviation
        self.year = year
        self.location = location
        self.editor = editor

class KB_Journal(db.Model):
    id = db.Column(db.Integer, primary_key=True)

    abbreviation = db.Column(db.String(128), nullable=False)
    full = db.Column(db.String(256), nullable=False)

    def __init__(self, abbreviation, full):
        self.abbreviation = abbreviation
        self.full = full

class KB_Journal_Year_Issue(db.Model):
    id = db.Column(db.Integer, primary_key=True)

    abbreviation = db.Column(db.String(128), nullable=False)
    year = db.Column(db.Integer, nullable=False)
    issue = db.Column(db.Integer, nullable=False)

    editor = db.Column(db.String(256), nullable=False)

    def __init__(self, abbreviation, year, issue, editor):
        self.abbreviation = abbreviation
        self.year = year
        self.issue = issue
        self.editor = editor

