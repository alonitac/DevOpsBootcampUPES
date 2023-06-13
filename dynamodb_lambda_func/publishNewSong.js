'use strict';
var AWS = require("aws-sdk");
var sns = new AWS.SNS();

exports.handler = (event, context, callback) => {

    event.Records.forEach((record) => {
        console.log('Stream record: ', JSON.stringify(record, null, 2));

        if (record.eventName == 'INSERT') {
            var who = JSON.stringify(record.dynamodb.NewImage.Artist.S);
            var what = JSON.stringify(record.dynamodb.NewImage.SongTitle.S);
            var params = {
                Subject: 'A new song from ' + who,
                Message: 'The song is: ' + what,
                TopicArn: '<TOPIC-ARN>'
            };
            sns.publish(params, function(err, data) {
                if (err) {
                    console.error("Unable to send message. Error JSON:", JSON.stringify(err, null, 2));
                } else {
                    console.log("Results from sending message: ", JSON.stringify(data, null, 2));
                }
            });
        }
    });
    callback(null, `Successfully processed ${event.Records.length} records.`);
};