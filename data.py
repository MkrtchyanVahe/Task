import boto3

dynamodb = boto3.resource('dynamodb', region_name='us-east-1')
table = dynamodb.Table('example_table')

item = {
    'id': '1',
    'timestamp': 1,
}

table.put_item(Item=item)
