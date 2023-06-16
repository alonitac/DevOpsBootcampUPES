## DynamoDB

### Create a table

1. Open the DynamoDB console at [https://console.aws.amazon.com/dynamodb/](https://console.aws.amazon.com/dynamodb/)
2. In the navigation pane on the left side of the console, choose **Dashboard**.
3. On the right side of the console, choose **Create Table**.
4. Enter the table details as follows:
    1. For the table name, enter a unique table name.
    2. For the partition key, enter `Artist`.
    3. Enter `SongTitle` as the sort key.
    4. Choose **Customize settings**.
    5. On **Read/write capacity settings** choose **Provisioned** mode with autoscale capacity with a minimum capacity of **1** and maximum of **10**.
5. Choose **Create** to create the table.

### Write and read data

1. On DynamoDB web console page, choose **PartiQL editor** on the left side menu.
2. The following example creates several new items in the `<table-name>` table. The [PartiQL](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/ql-reference.html) is
   a SQL-compatible query language for DynamoDB.

```shell
INSERT INTO "<table-name>" VALUE {'Artist':'No One You Know','SongTitle':'Call Me Today', 'AlbumTitle':'Somewhat Famous', 'Awards':'1'}

INSERT INTO "<table-name>" VALUE {'Artist':'No One You Know','SongTitle':'Howdy', 'AlbumTitle':'Somewhat Famous', 'Awards':'2'}

INSERT INTO "<table-name>" VALUE {'Artist':'Acme Band','SongTitle':'Happy Day', 'AlbumTitle':'Songs About Life', 'Awards':'10'}
                            
INSERT INTO "<table-name>" VALUE {'Artist':'Acme Band','SongTitle':'PartiQL Rocks', 'AlbumTitle':'Another Album Title', 'Awards':'8'}
```

Query the data by

```shell
SELECT * FROM "<table-name>" WHERE Artist='Acme Band' AND SongTitle='Happy Day'
```

### Spot check 

From your local machine, write some more items using the `aws dynamodb put-item` command.
Use the `aws dynamodb get-item` to get some item.

### Solution 

Write

```bash 
aws dynamodb put-item --table-name Music --item '{"Artist": {"S": "No One You Know"}, "SongTitle": {"S": "Call Me Today"}, "AlbumTitle": {"S": "Somewhat Famous"}, "Awards": {"N": "1"}}'
```

Get

```bash
aws dynamodb get-item --table-name Music --key '{ "Artist": {"S": "Acme Band"}, "SongTitle": {"S": "Happy Day"}}'
```

### Create and query a global secondary index

1. In the navigation pane on the left side of the console, choose **Tables**.
2. Choose your table from the table list.
3. Choose the **Indexes** tab for your table.
4. Choose **Create** index.
5. For the **Partition key**, enter `AlbumTitle`.
6. For **Index** name, enter `AlbumTitle-index`.
7. Leave the other settings on their default values and choose **Create** index.

8. You query the global secondary index through PartiQL by using the Select statement and providing the index name
```shell
SELECT * FROM "<table-name>"."AlbumTitle-index" WHERE AlbumTitle='Somewhat Famous'
```

# Self-check questions

[Enter the interactive self-check page](https://alonitac.github.io/DevOpsBootcampUPES/multichoice-questions/aws_dynamodb.html)

# Exercises

## :pencil2: Database migration 

Database migration is the process of transferring data and schema from one database to another, typically when transitioning to a new system or version. 

Zero downtime database migration refers to the seamless migration of a database without any interruption or impact on the availability of the system. 
It involves careful planning, replication, and synchronization techniques to ensure continuous service while transitioning to the new database environment.

1. Start [`mongo`](https://hub.docker.com/_/mongo) docker container.
2. Start the script under `db_migration/init.py`. The script should write new data to your running mongo every second. Keep this script running while you work on your next step.
3. Based in the script in `db_migration/init.py`, create another script called `mirror_db.py` such that every data that is written to mongo will be written to dynamoDB table (create this table with `dataId` as a partition key).
4. (Optional) Use `try...except` to catch and handle the case where the write operation for either mongo or dynamo is failed. 
5. Stop the running script from step 2, keep the timestamp of the last document that was written to mongo. 
6. Start the `mirror_db.py` script. From now on, every piece of data is being written to both mongo and dynamo. You only need to create to the data written before you started the mirror script. 
7. Write a script that copies all the documents with timestamp smaller than or equal to the timestamp you kept from step 5. This script should be run only once.   

After a while... stop the `mirror_db.py` script and check that the data stored in both DBs is identical (you may write some python script for that).


## :pencil2: Point-in-time recovery for DynamoDB

Restore your table to how it was looking like a few minutes ago.   

https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/PointInTimeRecovery.Tutorial.html#restoretabletopointintime_console



