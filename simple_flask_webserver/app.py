import datetime
from flask import Flask, send_file, request, jsonify, render_template
from werkzeug.utils import secure_filename
import os
from utils import detect

app = Flask(__name__, static_url_path='')
app.config['UPLOAD_FOLDER'] = 'static/data'


# Try by from your browser:  localhost:8080
@app.route("/", methods=['GET'])
def home():
    return render_template('index.html')


@app.route('/upload', methods=['POST'])
def upload_file():
    file = request.files['file']
    filename = secure_filename(file.filename)
    p = os.path.join(app.config['UPLOAD_FOLDER'], filename)
    file.save(p)
    detections = detect(p)
    return render_template('result.html', filename=f'data/{filename}', detections=detections)


# Try by:  curl -X POST -F 'file=@<local-path-to-image-file>' localhost:8080/api/upload
@app.route('/api/upload', methods=['POST'])
def api_upload():
    file = request.files['file']
    filename = secure_filename(file.filename)
    p = os.path.join(app.config['UPLOAD_FOLDER'], filename)
    file.save(p)
    detections = detect(p)
    return jsonify(
        {
            "timestamp": datetime.datetime.now().isoformat(),
            "request": {
                "base_url": request.base_url,
                "accept": request.mimetype,
                "status": 200,
                "client_ip": request.remote_addr
            },
            "allowed_types": ['png', 'jpg', 'jpeg', 'gif'],
            "secure": None,
            "detections": detections
        }
    )

{"version": "1.3","ciphersSuites": ["TLS_AES_128_GCM_SHA256","TLS_CHACHA20_POLY1305_SHA256"],"message": "Client Hello"}

# Try by: curl -X POST -H "Content-Type: application/json" -d '{"name": "linuxize", "email": "linuxize@example.com"}' http://localhost:8080/update-profile
@app.route('/update-profile', methods=['POST'])
def update_profile():
    data = request.json
    print(f'Doing something with the data...\n{data}')
    return 'Profile updated!\n'


@app.route('/status')
def status():
    return 'OK'


if __name__ == '__main__':
    app.run(debug=True, port=8080, host='0.0.0.0')
