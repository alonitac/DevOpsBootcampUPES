FROM ultralytics/yolov5:latest-cpu
WORKDIR /usr/src/app
RUN pip install --upgrade pip
COPY requirements.txt .
RUN pip install -r requirements.txt

COPY . .
CMD ["python3", "app.py"]
