resource "aws_dynamodb_table" "example_table" {
  name           = "example_table"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "id"
  range_key      = "timestamp"
  
  attribute {
    name = "id"
    type = "S"
  }

  attribute {
    name = "timestamp"
    type = "N"
  }

  global_secondary_index {
    name               = "example_index"
    hash_key           = "timestamp"
    range_key          = "id"
    projection_type    = "ALL"
    read_capacity      = 5
    write_capacity     = 5
  }
}

resource "null_resource" "example" {
  provisioner "local-exec" {
    command = "python3 data.py"
  }
  
  depends_on = [
    aws_dynamodb_table.example_table
  ]
}
