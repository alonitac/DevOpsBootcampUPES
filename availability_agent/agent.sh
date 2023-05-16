#!/bin/bash

TEST_PERIODICITY=5
DB_USERNAME="<your-username>"
DB_PASSWORD="<your-password>"

curl -X POST 'http://localhost:8086/query' -u $DB_USERNAME:$DB_PASSWORD --data-urlencode "q=CREATE DATABASE hosts_metrics"

while true
do
  while read -r TESTED_HOST
  do
      RESULT=$(ping  -c 1 -W 2 "$TESTED_HOST"  | grep -oP '(?<=time=)\d+(\.\d+)?')
      TEST_TIMESTAMP=$(date +%s%N)

      if [[ ! -n "$RESULT" ]]
      then
        RESULT=0
      fi

      echo "Test Result for $TESTED_HOST is $RESULT at $TEST_TIMESTAMP"
      curl -X POST 'http://localhost:8086/write?db=hosts_metrics' -u $DB_USERNAME:$DB_PASSWORD  --data-binary "availability_test,host=$TESTED_HOST value=$RESULT $TEST_TIMESTAMP"

  done < hosts

  echo ""
  sleep $TEST_PERIODICITY
done