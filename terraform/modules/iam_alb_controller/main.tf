data "aws_iam_policy_document" "assume_role" {
  statement {
    actions = [ "sts:AssumeRole" ]
    principals {
      type = "Service"
      identifiers = [ "eks.amazonaws.com" ]
    }
  }
}

resource "aws_iam_role" "alb_ingress" {
  name = "${var.project_name}-alb-ingress-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_policy" "alb_controller_policy" {
  name   = "${var.project_name}-alb-controller-policy"
  policy = file("${path.module}/iam-policy.json") 
}

resource "aws_iam_role_policy_attachment" "attach" {
  role       = aws_iam_role.alb_ingress.name
  policy_arn = aws_iam_policy.alb_controller_policy.arn
}