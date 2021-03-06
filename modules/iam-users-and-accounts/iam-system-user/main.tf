resource "aws_iam_user" "default" {
  count         = var.enabled ? 1 : 0
  name          = var.user_id
  path          = var.path
  force_destroy = var.force_destroy
  tags          = var.tags
}

resource "aws_iam_access_key" "default" {
  count   = var.enabled ? 1 : 0
  user   =  aws_iam_user.default[0].name
  pgp_key = base64encode(file(var.pgp_key))
}

resource "aws_iam_user_policy" "default" {
  count  = var.enabled ? 1 : 0
  name   = "${aws_iam_user.default[0].name}-policy"
  user   =  aws_iam_user.default[0].name
  policy = var.policy
}
