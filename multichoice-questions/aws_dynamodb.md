# AWS - DynamoDB - multichoice questions


## Question 1

You are designing a highly scalable application that utilizes DynamoDB for its database needs.
The application is expected to handle a maximum of 1000 reads/second and 500 writes/second. 
Items average size is 4 KB.

How many RCU and WCU are required?

- [ ] 500 RCU and 2000 WCU
- [ ] 2000 RCU and 500 WCU
- [ ] 1000 RCU and 500 WCU
- [ ] 500 RCU and 1000 WCU

## Question 2

You're team is developing a news website that receives an average of 500 read requests per second during peak hours.
Each news article is approximately 10 KB in size.

How would you design the DB?

- [ ] Autoscale read capacity from min of 1 to max of 250.
- [ ] Autoscale read capacity from min of 1 to max of 750.
- [ ] Autoscale read capacity from min of 1 to max of 1000.
- [ ] Autoscale read capacity from min of 1 to max of 500.

## Question 3

Consider the following JSON sample of an item in an DynamoDB table:

```json
{
    "item_id": "123456789",
    "timestamp": "2022-05-10T10:30:00Z",
    "name": "Product A",
    "category": "Electronics",
    "price": 99.99,
    "quantity": 10
}
```

Which key from the item JSON sample would be most suitable as the partition key for the DynamoDB table?

- [ ] `item_id`
- [ ] `name`
- [ ] `category`
- [ ] `price`

