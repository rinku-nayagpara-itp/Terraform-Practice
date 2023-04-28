data "aws_iam_policy" "codecommit-read-policy" {
  name = "AWSCodeCommitReadOnly"
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["amplify.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "codecommit-read-role" {
  name = var.assumed-role
  assume_role_policy = join("", data.aws_iam_policy_document.assume_role.*.json)
  managed_policy_arns = [data.aws_iam_policy.codecommit-read-policy.arn]
}