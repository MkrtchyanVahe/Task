resource "aws_s3_bucket" "example_bucket" {
  bucket = "g-gyumri-backet-30854"
}

#resource "aws_s3_bucket_policy" "example" {
#  bucket = aws_s3_bucket.example_bucket.id
#  policy = <<EOF
#{
#  "Version": "2012-10-17",
#  "Statement": [
#    {
#      "Sid": "AWSELBLogsAccess",
#      "Effect": "Allow",
#      "Principal": {
#        "Service": "delivery.logs.amazonaws.com"
#      },
#      "Action": "s3:GetBucketAcl",
#      "Resource": "arn:aws:iam::976261360972:user/vahe"
#    },
#    {
#      "Sid": "AWSELBLogsWrite",
#      "Effect": "Allow",
#      "Principal": {
#        "Service": "delivery.logs.amazonaws.com"
#      },
#      "Action": "s3:PutObject",
#      "Resource": "arn:aws:iam::976261360972:user/vahe/${var.account_id}/*",
#      "Condition": {
#        "StringEquals": {
#          "s3:x-amz-acl": "bucket-owner-full-control"
#        }
#      }
#    }
#  ]
#}
#EOF
#}

