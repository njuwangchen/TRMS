__author__ = 'ClarkWong'

from app import db, app
from flask import request, send_from_directory, url_for
from models import Literature_meta
import os
import json
import werkzeug
import time

UPLOAD_FOLDER = os.getcwd() + '/upload/'

@app.route('/upload', methods=['POST'])
def upload():
    saved_file_url = ''
    file = request.files['file']
    literature_id = request.form['literature_id']
    print(id)
    if file:
        filename = werkzeug.secure_filename(file.filename)
        filename = filename.rsplit('.', 1)
        #add timestamp to filename
        timestamp = long(time.time()*1000)
        fileToSaveName = filename[0] + str(timestamp) + '.'+ filename[1]
        file.save(os.path.join(UPLOAD_FOLDER, fileToSaveName))
        saved_file_url = url_for('get_uploaded', filename = fileToSaveName)
        #add this url to database
        literature = Literature_meta.query.filter_by(id=literature_id).first()
        literature.uri = saved_file_url
        db.session.commit()
    return json.dumps(saved_file_url)

@app.route('/uploaded/<filename>', methods=['GET', 'POST'])
def get_uploaded(filename):
    return send_from_directory(UPLOAD_FOLDER, filename)
