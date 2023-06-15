import boto3

def boto3_client():
    return boto3.client('rekognition')


def check_format_and_size(filename, size):
    if filename.split('.')[-1] in ['mp4', 'mov']:
        if size < 10*1024*1024*1024:
            return True
    return False


def start_face_detection(bucket, video, size, reko_client=None):
    assert check_format_and_size(video, size)
    if reko_client == None:
        reko_client = boto3.client('rekognition')
    response = reko_client.start_face_detection(Video={'S3Object': {'Bucket': bucket, 'Name': video}})
    return response['JobId']