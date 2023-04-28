module "dynamodb_table" {
  source = "terraform-aws-modules/dynamodb-table/aws"

  name     = "RinkuNayagparaRides"
  hash_key = "RideId"

  attributes = [
    {
      name = "RideId"
      type = "S"
    }
  ]

  tags = {
    Terraform = "true"
    Name      = "rinku-dynamodb-table"
  }
}