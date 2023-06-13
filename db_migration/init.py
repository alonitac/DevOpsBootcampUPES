import pymongo
import uuid
import time

client = pymongo.MongoClient("mongodb://localhost:27017/")
db = client["mydatabase"]
collection = db["mycollection"]

while True:
    data = {
        "dataId": str(uuid.uuid4()),
        "timestamp": time.time()
    }

    collection.insert_one(data)
    print("Data inserted:", data)

    time.sleep(1)
