data "aws_iam_policy_document" "instance_profile_assume_role" {
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}

data "aws_iam_policy_document" "instance_policy" {
  statement {
    effect = "Allow"
    resources = var.EIP_RESOURCE
    actions = [
      "ec2:AssociateAddress"
    ]
  }
}
resource "aws_iam_policy" "ec2_iam_policy" {
  name        = local.ec2_policy
  policy      = data.aws_iam_policy_document.instance_policy.json
}
resource "aws_iam_instance_profile" "iam_instance_profile" {
  name = local.iam_instance_profile
  role = aws_iam_role.instance_profile_role.name
}

resource "aws_iam_role" "instance_profile_role" {
  name               = local.instance_profile_role
  assume_role_policy = data.aws_iam_policy_document.instance_profile_assume_role.json
}

resource "aws_iam_role_policy_attachment" "instance_profile_attach_role_policy_1" {
  role       = aws_iam_role.instance_profile_role.name
  policy_arn = var.EC2_INSTANCE_PROFILE_MANAGED_INSTANCE_CORE
}
resource "aws_iam_role_policy_attachment" "instance_profile_attach_role_policy_2" {
  role       = aws_iam_role.instance_profile_role.name
  policy_arn = var.EC2_INSTANCE_PROFILE_CONTAINER_SERVICE_FOR_EC2_ROLE
}
resource "aws_iam_role_policy_attachment" "instance_profile_attach_role_policy_3" {
  role       = aws_iam_role.instance_profile_role.name
  policy_arn = aws_iam_policy.ec2_iam_policy.arn
}