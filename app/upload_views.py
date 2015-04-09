__author__ = 'ClarkWong'

from app import db, app
from flask import request, send_from_directory, url_for
from models import Literature_meta, Video, Ppt, Code, Data_set, Report_attachment, Report_recording
import os
import json
import werkzeug

UPLOAD_FOLDER = os.getcwd() + '/upload/'
UPLOAD_FOLDER_VIDEO = os.getcwd() + '/uploadVideo/'
UPLOAD_FOLDER_PPT = os.getcwd() + '/uploadPpt/'
UPLOAD_FOLDER_CODE = os.getcwd() + '/uploadCode/'
UPLOAD_FOLDER_DATA_SET = os.getcwd() + '/uploadDataset/'
UPLOAD_FOLDER_REPORTATTACHMENT = os.getcwd() + '/uploadReportattachment/'
UPLOAD_FOLDER_REPORTRECORDING = os.getcwd() + '/uploadReportrecording/'


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

    if chunk == (chunks - 1):
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

    if chunk == (chunks - 1):
        size = request.content_length + chunks * 1024 * 1024
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

    if chunk == (chunks - 1):
        size = request.content_length + chunks * 1024 * 1024
        ppt_data = Ppt(literature_id, size=size, uri=saved_ppt_url)
        db.session.add(ppt_data)
        db.session.commit()
    return json.dumps(saved_ppt_url)


@app.route('/uploadedPpt/<pptName>', methods=['GET', 'POST'])
def get_uploadedPpt(pptName):
    return send_from_directory(UPLOAD_FOLDER_PPT, pptName)


@app.route('/uploadCode', methods=['POST'])
def uploadCode():
    code = request.files['file']
    code_id = request.form['code_id']
    if 'chunk' in request.form:
        chunk = int(request.form['chunk'])
        chunks = int(request.form['chunks'])
    else:
        chunk = 0
        chunks = 1
    codename = request.form['name']
    codename = werkzeug.secure_filename(codename)
    codePath = os.path.join(UPLOAD_FOLDER_CODE, codename)
    with open(codePath, 'ab+') as f:
        code.save(f)
    saved_code_url = url_for('get_uploadedCode', codename=codename)

    if chunk == (chunks - 1):
        code = Code.query.filter_by(id=code_id).first()
        code.uri = saved_code_url
        db.session.commit()
    return json.dumps(saved_code_url)


@app.route('/uploadedCode/<codename>', methods=['GET', 'POST'])
def get_uploadedCode(codename):
    return send_from_directory(UPLOAD_FOLDER_CODE, codename)


@app.route('/uploadDataset', methods=['POST'])
def uploadDataset():
    data_set = request.files['file']
    data_set_id = request.form['data_set_id']
    if 'chunk' in request.form:
        chunk = int(request.form['chunk'])
        chunks = int(request.form['chunks'])
    else:
        chunk = 0
        chunks = 1
    data_set_name = request.form['name']
    data_set_name = werkzeug.secure_filename(data_set_name)
    data_set_Path = os.path.join(UPLOAD_FOLDER_DATA_SET, data_set_name)
    with open(data_set_Path, 'ab+') as f:
        data_set.save(f)
    saved_data_set_url = url_for('get_uploadedDataset', data_set_name=data_set_name)

    if chunk == (chunks - 1):
        data_set = Data_set.query.filter_by(id=data_set_id).first()
        data_set.uri = saved_data_set_url
        db.session.commit()
    return json.dumps(saved_data_set_url)


@app.route('/uploadedDataset/<data_set_name>', methods=['GET', 'POST'])
def get_uploadedDataset(data_set_name):
    return send_from_directory(UPLOAD_FOLDER_DATA_SET, data_set_name)


@app.route('/uploadReportattachment', methods=['POST'])
def uploadReportattachment():
    reportattachment = request.files['file']
    report_id = request.form['report_id']
    if 'chunk' in request.form:
        chunk = int(request.form['chunk'])
        chunks = int(request.form['chunks'])
    else:
        chunk = 0
        chunks = 1
    reportattachmentName = request.form['name']
    reportattachmentName = werkzeug.secure_filename(reportattachmentName)
    reportattachmentPath = os.path.join(UPLOAD_FOLDER_REPORTATTACHMENT, reportattachmentName)
    with open(reportattachmentPath, 'ab+') as f:
        reportattachment.save(f)
    saved_reportattachment_url = url_for('get_uploadedReportattachment', reportattachmentName=reportattachmentName)

    if chunk == (chunks - 1):
        reportattachment_data = Report_attachment(report_id, attachment_name=reportattachmentName, uri=saved_reportattachment_url)
        db.session.add(reportattachment_data)
        db.session.commit()
    return json.dumps(saved_reportattachment_url)


@app.route('/uploadedReportattachment/<reportattachmentName>', methods=['GET', 'POST'])
def get_uploadedReportattachment(reportattachmentName):
    return send_from_directory(UPLOAD_FOLDER_REPORTATTACHMENT, reportattachmentName)

@app.route('/uploadReportrecording', methods=['POST'])
def uploadReportrecording():
    reportrecording = request.files['file']
    report_id = request.form['report_id']
    if 'chunk' in request.form:
        chunk = int(request.form['chunk'])
        chunks = int(request.form['chunks'])
    else:
        chunk = 0
        chunks = 1
    reportrecordingName = request.form['name']
    reportrecordingName = werkzeug.secure_filename(reportrecordingName)
    reportrecordingPath = os.path.join(UPLOAD_FOLDER_REPORTRECORDING, reportrecordingName)
    with open(reportrecordingPath, 'ab+') as f:
        reportrecording.save(f)
    saved_reportrecording_url = url_for('get_uploadedReportrecording', reportrecordingName=reportrecordingName)

    if chunk == (chunks - 1):
        reportrecording_data = Report_recording(report_id, recording_name=reportrecordingName, uri=saved_reportrecording_url)
        db.session.add(reportrecording_data)
        db.session.commit()
    return json.dumps(saved_reportrecording_url)


@app.route('/uploadedReportrecording/<reportrecordingName>', methods=['GET', 'POST'])
def get_uploadedReportrecording(reportrecordingName):
    return send_from_directory(UPLOAD_FOLDER_REPORTRECORDING, reportrecordingName)