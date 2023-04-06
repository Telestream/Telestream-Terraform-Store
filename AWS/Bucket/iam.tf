
data "aws_iam_policy_document" "policy" {
  count                   = var.enabled ? 1 : 0
  source_policy_documents = local.iam_policies
}


resource "aws_iam_policy" "policy" {
  count       = local.create_iam_role || local.create_iam_user ? 1 : 0
  name        = var.iam_access.iam_policy_name
  name_prefix = var.iam_access.iam_policy_name_prefix
  description = var.iam_access.iam_policy_description
  path        = var.iam_access.iam_policy_path
  policy      = data.aws_iam_policy_document.policy[count.index].json
  tags        = var.iam_access.iam_policy_tags
}


// if create iam and assume role create an iam role
//create assume role policy, what resouces can assume the role by looping though var.role_statments list
data "aws_iam_policy_document" "assume_role" {
  count = local.create_iam_role ? length(var.assume_role_statements) : 0
  statement {
    sid     = var.assume_role_statements[count.index].sid
    effect  = "Allow"
    actions = var.assume_role_statements[count.index].actions
    principals {
      type        = var.assume_role_statements[count.index].principal_type
      identifiers = var.assume_role_statements[count.index].principal_identifiers
    }
    dynamic "condition" {
      for_each = var.assume_role_statements[count.index].conditions
      content {
        test     = condition.value.test
        variable = condition.value.variable
        values   = condition.value.values
      }
    }
  }
}

//non-blank sids will overide statements with same sid earlier in list, this combines json statements created by assume_role
data "aws_iam_policy_document" "assume_role_combined" {
  count                     = local.create_iam_role ? 1 : 0
  override_policy_documents = data.aws_iam_policy_document.assume_role.*.json
}
//create iam role
resource "aws_iam_role" "role" {
  count                 = local.create_iam_role ? 1 : 0
  name                  = var.iam_access.iam_role_name
  name_prefix           = var.iam_access.iam_role_name_prefix
  description           = var.iam_access.iam_role_description
  tags                  = var.iam_access.iam_role_tags
  path                  = var.iam_access.iam_role_path
  force_detach_policies = var.iam_access.iam_role_force_detach_policies
  max_session_duration  = var.iam_access.iam_role_max_session_duration
  permissions_boundary  = var.iam_access.iam_role_permissions_boundary
  assume_role_policy    = join("", data.aws_iam_policy_document.assume_role_combined.*.json)
}

resource "aws_iam_user" "user" {
  count                = local.create_iam_user ? 1 : 0
  name                 = var.iam_access.iam_user_name
  path                 = var.iam_access.iam_user_path
  permissions_boundary = var.iam_access.iam_user_permissions_boundary
  force_destroy        = var.iam_access.iam_user_force_destroy
  tags                 = var.iam_access.iam_user_tags
}

resource "aws_iam_role_policy_attachment" "attach_policy_to_role" {
  count      = local.create_iam_role ? 1 : 0
  role       = join("", aws_iam_role.role.*.name)
  policy_arn = join("", aws_iam_policy.policy.*.arn)
}
resource "aws_iam_user_policy_attachment" "attach_policy_to_user" {
  count      = local.create_iam_user ? 1 : 0
  user       = join("", aws_iam_user.user.*.name)
  policy_arn = join("", aws_iam_policy.policy.*.arn)
}

resource "aws_iam_access_key" "iam_access_key" {
  count   = local.create_iam_user ? 1 : 0
  user    = join("", aws_iam_user.user.*.name)
  pgp_key = var.iam_access.iam_user_pgp_key
  status  = var.iam_access.iam_user_key_status
}