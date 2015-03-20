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

