import json
import logging
import os
import urllib

import boto3
import botocore

from rekognition import check_format_and_size, start_face_detection

logger = logging.getLogger()
logger.setLevel(logging.INFO)

reko = boto3.client('rekognition')
s3 = boto3.client('s3')
sfn = boto3.client('stepfunctions')

state_machine_arn = os.environ['STATE_MACHINE_ARN']

def lambda_handler(event, context):
    successful_records = []
    failed_records = []

    for record in event['Records']:

        # verify event has reference to S3 object
        try:
            # get metadata of file uploaded to Amazon S3
            bucket = record['s3']['bucket']['name']
            key = urllib.parse.unquote_plus(record['s3']['object']['key'])
            path_to_file = '{}/{}'.format(bucket, key)
            size = int(record['s3']['object']['size'])
            filename = key.split('/')[-1]
            local_filename = '/tmp/{}'.format(filename)
            local_filename_output = '/tmp/{}'.format(filename)
        except KeyError:
            error_message = 'Lambda invoked without S3 event data. Event needs to reference a S3 bucket and object key.'
            logger.log(logging.ERROR, error_message)
            # add_failed(bucket, error_message, failed_records, key)
            continue

        # verify file and its size
        try:
            assert check_format_and_size(filename, size)
        except:
            error_message = 'Unsupported file type. Amazon Rekognition Video support MOV and MP4 lower than 10 GB in size'
            logger.log(logging.ERROR, error_message)
            continue

        # use Amazon Rekognition to detect faces in video uploaded to Amazon S3
        try:
            job_id = start_face_detection(bucket, key, 1, reko)
            # response = wait_for_completion(job_id, reko_client=reko)
        except reko.exceptions.AccessDeniedException:
            error_message = 'Lambda role does not have permission to call DetectFaces in Amazon Rekognition.'
            logger.log(logging.ERROR, error_message)
            # add_failed(bucket, error_message, failed_records, key)
            continue
        except reko.exceptions.InvalidS3ObjectException:
            error_message = 'Unable to get object metadata from S3. Check object key, region and/or access permissions for input S3 bucket.'
            logger.log(logging.ERROR, error_message)
            # add_failed(bucket, error_message, failed_records, key)
            continue

    input_data = json.dumps({"body":{"job_id": job_id, "s3_object_bucket": bucket, "s3_object_key": key}})

    response = sfn.start_execution(
        stateMachineArn=state_machine_arn,
        input=input_data)

    return {
        "statusCode": 200,
        "body": json.dumps(
            {
                "job_id": job_id,
                "failed_records": failed_records,
                "successful_records": successful_records
            }
        )
    }


def add_failed(bucket, error_message, failed_records, key):
    failed_records.append({
        "bucket": bucket,
        "key": key,
        "error_message": error_message
    })