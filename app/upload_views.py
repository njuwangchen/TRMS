__author__ = 'ClarkWong'

from app import db, app
from flask import request, send_from_directory, url_for
from models import Literature_meta, Video, Ppt
import os
import json
import werkzeug

UPLOAD_FOLDER = os.getcwd() + '/upload/'
UPLOAD_FOLDER_VIDEO = os.getcwd() + '/uploadVideo/'
UPLOAD_FOLDER_PPT = os.getcwd() + '/uploadPpt/'


@app.route('/upload', methods=['POST'])
def upload():
    file = request.files['file']
    literature_id = request.form['literature_id']
    if 'chunk' in request.form:
        chunk = int(request.form['chunk'])
        chunks = int(request.form['chunks'])
    else:
        chunk = 0
        chunks = 1
    filename = request.form['name']
    filename = werkzeug.secure_filename(filename)
    filePath = os.path.join(UPLOAD_FOLDER, filename)
    with open(filePath, 'ab+') as f:
        file.save(f)
    saved_file_url = url_for('get_uploadedFile', filename=filename)

    if chunk == (chunks-1):
        # add this url to database
        literature = Literature_meta.query.filter_by(id=literature_id).first()
        literature.uri = saved_file_url
        db.session.commit()
    return json.dumps(saved_file_url)


@app.route('/uploaded/<filename>', methods=['GET', 'POST'])
def get_uploadedFile(filename):
    return send_from_directory(UPLOAD_FOLDER, filename)


@app.route('/uploadVideo', methods=['POST'])
def uploadVideo():
    video = request.files['file']
    literature_id = request.form['literature_id']
    if 'chunk' in request.form:
        chunk = int(request.form['chunk'])
        chunks = int(request.form['chunks'])
    else:
        chunk = 0
        chunks = 1
    videoName = request.form['name']
    videoName = werkzeug.secure_filename(videoName)
    videoPath = os.path.join(UPLOAD_FOLDER_VIDEO, videoName)
    with open(videoPath, 'ab+') as f:
        video.save(f)
    saved_video_url = url_for('get_uploadedVideo', videoName=videoName)

    if chunk == (chunks-1):
        size = request.content_length + chunks*1024*1024
        video_data = Video(literature_id, size=size, uri=saved_video_url)
        db.session.add(video_data)
        db.session.commit()
    return json.dumps(saved_video_url)


@app.route('/uploadedVideo/<videoName>', methods=['GET', 'POST'])
def get_uploadedVideo(videoName):
    return send_from_directory(UPLOAD_FOLDER_VIDEO, videoName)


@app.route('/uploadPpt', methods=['POST'])
def uploadPpt():
    ppt = request.files['file']
    literature_id = request.form['literature_id']
    if 'chunk' in request.form:
        chunk = int(request.form['chunk'])
        chunks = int(request.form['chunks'])
    else:
        chunk = 0
        chunks = 1
    pptName = request.form['name']
    pptName = werkzeug.secure_filename(pptName)
    pptPath = os.path.join(UPLOAD_FOLDER_PPT, pptName)
    with open(pptPath, 'ab+') as f:
        ppt.save(f)
    saved_ppt_url = url_for('get_uploadedPpt', pptName=pptName)

    if chunk == (chunks-1):
        size = request.content_length + chunks*1024*1024
        ppt_data = Ppt(literature_id, size=size, uri=saved_ppt_url)
        db.session.add(ppt_data)
        db.session.commit()
    return json.dumps(saved_ppt_url)

@app.route('/uploadedPpt/<pptName>', methods=['GET', 'POST'])
def get_uploadedPpt(pptName):
    return send_from_directory(UPLOAD_FOLDER_PPT, pptName)

