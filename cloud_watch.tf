# CloudWatch metrics and alarms
resource "aws_cloudwatch_metric_alarm" "ec2_cpu_utilization" {
  alarm_name          = "EC2 High CPU Utilization"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "60"
  statistic           = "Average"
  threshold           = "80"
  alarm_description   = "Alarm when CPU exceeds 80%"
  alarm_actions       = ["arn:aws:sns:us-east-1:123456789012:example-topic"]
  dimensions = {
    InstanceId = aws_instance.example.id
  }
}

resource "aws_cloudwatch_metric_alarm" "dynamodb_high_reads" {
  alarm_name          = "DynamoDB High Read Capacity"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "ConsumedReadCapacityUnits"
  namespace           = "AWS/DynamoDB"
  period              = "60"
  statistic           = "Sum"
  threshold           = "1000"
  alarm_description   = "Alarm when read capacity exceeds 1000 units"
  alarm_actions       = ["arn:aws:sns:us-east-1:123456789012:example-topic"]
  dimensions = {
    TableName = aws_dynamodb_table.example_table.name
  }
}

resource "aws_cloudwatch_metric_alarm" "dynamodb_high_writes" {
  alarm_name          = "DynamoDB High Write Capacity"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "ConsumedWriteCapacityUnits"
  namespace           = "AWS/DynamoDB"
  period              = "60"
  statistic           = "Sum"
  threshold           = "1000"
  alarm_description   = "Alarm when write capacity exceeds 1000 units"
  alarm_actions       = ["arn:aws:sns:us-east-1:123456789012:example-topic"]
  dimensions = {
    TableName = aws_dynamodb_table.example_table.name
  }
}

