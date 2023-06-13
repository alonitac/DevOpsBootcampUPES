import boto3

reko = boto3.client('rekognition')
s3 = boto3.client('s3')

def get_timestamps_and_faces(job_id, reko_client=None):
    final_timestamps = {}
    next_token = "Y"
    first_round = True
    while next_token != "":
        print('.', end='')
        # Set some variables if it's the first iteration
        if first_round:
            next_token = ""
            first_round = False
        # Query Reko Video
        response = reko_client.get_face_detection(JobId=job_id, MaxResults=100, NextToken=next_token)
        # Iterate over every face
        for face in response['Faces']:
            f = face["Face"]["BoundingBox"]
            t = str(face["Timestamp"])
            time_faces = final_timestamps.get(t)
            if time_faces == None:
                final_timestamps[t] = []
            final_timestamps[t].append(f)
        # Check if there is another portion of the response
        try:
            next_token = response['NextToken']
        except:
            break
    # Return the final dictionary
    print('Complete')
    return final_timestamps, response


def lambda_handler(event, context):
    job_id = event['job_id']
    timestamps, response = get_timestamps_and_faces(job_id, reko)
    return {
        'statusCode': 200,
        "body":
            {
                "job_id": job_id,
                "response": response,
                "s3_object_bucket": event['s3_object_bucket'],
                "s3_object_key": event['s3_object_key'],
                "timestamps": timestamps
            }
    }