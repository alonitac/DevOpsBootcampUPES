from pathlib import Path
from flask import Flask, render_template, flash, request, redirect
import os
from werkzeug.utils import secure_filename
from detect import run
import uuid
import yaml
from loguru import logger

with open("data/coco128.yaml", "r") as stream:
    names = yaml.safe_load(stream)['names']

logger.info(f'yolo5 is up, supported classes are:\n\n{names}')

ALLOWED_EXTENSIONS = {'png', 'jpg', 'jpeg', 'gif'}
logger.info(f'supported files are: {ALLOWED_EXTENSIONS}')


def allowed_file(filename):
    return '.' in filename and \
           filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS


app = Flask(__name__, static_url_path='')
UPLOAD_FOLDER = 'data/images'
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER


@app.route('/predict', methods=['POST'])
def upload_file_api():
    if 'file' not in request.files:
        return 'No file attached', 400

    file = request.files['file']
    logger.info(f'attached file: {request.files["file"]}')

    if file and allowed_file(file.filename):
        filename = secure_filename(file.filename)
        file.save(os.path.join(app.config['UPLOAD_FOLDER'], filename))

        p = Path(os.path.join(app.config['UPLOAD_FOLDER'], filename))
        prediction_id = str(uuid.uuid4())   # e.g. bd65600d-8669-4903-8a14-af88203add38

        logger.info(f'predicting {prediction_id}/{p}')

        run(
            weights='yolov5s.pt',
            data='data/coco128.yaml',
            source=p,
            project='static/data',
            name=prediction_id,
            save_txt=True
        )

        logger.info(f'prediction done {prediction_id}/{p}')
        pred_result_img = Path(f'static/data/{prediction_id}/{filename}')
        pred_result_path = Path(f'static/data/{prediction_id}/labels/{filename.split(".")[0]}.txt')

        # TODO upload client original img (p) and predicted img (pred_result_img) to S3 using boto3
        #  reference: https://boto3.amazonaws.com/v1/documentation/api/latest/guide/s3-uploading-files.html

        labels = []
        if pred_result_path.exists():
            with open(pred_result_path) as f:
                labels = f.read().splitlines()
                labels = [line.split(' ') for line in labels]
                labels = [{
                    'class': names[int(l[0])],
                    'cx': float(l[1]),
                    'cy': float(l[2]),
                    'width': float(l[3]),
                    'height': float(l[4]),
                } for l in labels]

        logger.info(f'prediction result for {prediction_id}/{p}:\n\n{labels}')
        return labels

    return f'Bad file format, allowed files are {ALLOWED_EXTENSIONS}', 400


if __name__ == "__main__":
    app.run(host='0.0.0.0', port=8081, debug=True)
