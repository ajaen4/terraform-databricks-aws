"EmailSubscriptionSNSTopic${index}": {
    "Type" : "AWS::SNS::Subscription",
    "Properties" : {
      "Endpoint" : "${email_address}",
      "Protocol" : "email",
      "TopicArn" : "${topic_arn}"
    }
}
