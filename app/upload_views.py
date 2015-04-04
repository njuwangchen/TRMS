__author__ = 'ClarkWong'

from app import db, app
from flask import request, send_from_directory, url_for
import os
import json
import werkzeug
import time

UPLOAD_FOLDER = os.getcwd() + '/upload/'

@app.route('/upload', methods=['POST'])
def upload():
    saved_files = []
    file = request.files['file']
    id = request.form['literature_id']
    print(id)
    if file:
        filename = werkzeug.secure_filename(file.filename)
        filename = filename.rsplit('.', 1)
        #add timestamp to filename
        timestamp = long(time.time()*1000)
        fileToSaveName = filename[0] + str(timestamp) + '.'+ filename[1]
        file.save(os.path.join(UPLOAD_FOLDER, fileToSaveName))
        saved_files.append(url_for('get_uploaded', filename = fileToSaveName))
    return json.dumps(saved_files)

@app.route('/uploaded/<filename>', methods=['GET', 'POST'])
def get_uploaded(filename):
    return send_from_directory(UPLOAD_FOLDER, filename)
