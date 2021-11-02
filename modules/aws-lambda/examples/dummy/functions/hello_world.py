
from __future__ import print_function

import json
import os

def lambda_handler(event, context):
    foo = os.environ["foo"]
    print(f"Hello World!!: {foo}")
    response = {
        'statusCode': 200,
        'body': json.dumps('Hi! from Lambda Function')
    }
    return response
