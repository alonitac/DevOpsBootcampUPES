from collections import Counter
import time
from flask import Flask, render_template, request
import os
from werkzeug.utils import secure_filename
import requests
from loguru import logger
from pymongo import MongoClient, DESCENDING

app = Flask(__name__, static_url_path='')

YOLO_URL = 'http://localhost:8081'
MONGO_URL = 'mongodb://localhost:27017'


@app.route('/', methods=['POST'])
def upload_file():
    file = request.files['file']
    filename = secure_filename(file.filename)
    file.save(os.path.join(app.config['UPLOAD_FOLDER'], filename))
    p = os.path.join(app.config['UPLOAD_FOLDER'], filename)

    logger.info(f'request detect service with {p}')

    res = requests.post(f'{YOLO_URL}/predict', files={
        'file': (p, open(p, 'rb'), 'image/png')
    })

    detections = res.json()
    logger.info(f'response from detect service with {detections}')

    # calc summary
    element_counts = Counter([l['class'] for l in detections])
    s = ''
    for element, count in element_counts.items():
        s += f"{element}: {count}\n"

    # write result to mongo
    logger.info('writing results to db')
    document = {
        'client_ip': request.remote_addr,
        'detections': detections,
        'filename': filename,
        'summary': s,
        'time': time.time()
    }

    inserted_document = client['objectDetection']['predictions'].insert_one(document)
    logger.info(f'inserted document id {inserted_document.inserted_id}')

    return render_template('result.html', filename=f'data/{filename}', summary=s, detections=detections)


@app.route("/", methods=['GET'])
def home():
    return render_template('index.html')


@app.route("/recent", methods=['GET'])
def recent():
    doc = client['objectDetection']['predictions'].find_one(
        {'client_ip': request.remote_addr},
        sort=[('time', DESCENDING)])

    if doc:
        return render_template('result.html', filename=f'data/{doc["filename"]}', summary=doc['summary'], detections=doc['detections'])

    return render_template('result.html', filename='', summary='No recent detection found', detections={})


if __name__ == "__main__":
    app.config['UPLOAD_FOLDER'] = 'static/data'

    logger.info(f'Initializing MongoDB connection')
    client = MongoClient(MONGO_URL)

    app.run(host='0.0.0.0', port=8082, debug=True)
