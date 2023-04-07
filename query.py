import boto3

from boto3.dynamodb.conditions import Key
dynamodb = boto3.resource('dynamodb', region_name='us-east-1')
table_name = 'example_table'
index_name = 'example_index'

table = dynamodb.Table(table_name)

response = table.query(
    IndexName=index_name,
    KeyConditionExpression=Key('timestamp').eq(1)
)

items = response['Items']
for item in items:
    print(item)
