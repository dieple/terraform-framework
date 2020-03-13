# only env specifics go here - Change AWS account IDs to meet your environment
variable "envsiiiii" {
  type = map

  default = {

    dataops-dev = {
      account_id         = "111122223333"
      account            = "Dataops Dev Environment"
      workspace_iam_role = "arn:aws:iam::111122223333:role/administrator"
      region             = "eu-west-1"
      region_code        = "ew1"
      bucket_region      = "eu-west-1"
      bucket             = "dataops-dev-tf-infra-state"
      dynamodb           = "dataops-dev-tf-infra-state-lock"
    }

    dataops-staging = {
      account_id         = "222233334444"
      account            = "DataOps Staging Environment"
      workspace_iam_role = "arn:aws:iam::222233334444:role/administrator"
      region_code        = "ew1"
      region             = "eu-west-1"
      bucket_region      = "eu-west-1"
      bucket             = "dataops-staging-tf-infra-state"
      dynamodb           = "dataops-staging-tf-infra-state-lock"
    }

    dataops-prod = {
      account_id         = "333344445555"
      account            = "DataOps Production Environment"
      workspace_iam_role = "arn:aws:iam::333344445555:role/administrator"
      region_code        = "ew1"
      region             = "eu-west-1"
      bucket_region      = "eu-west-1"
      bucket             = "dataops-prod-tf-infra-state"
      dynamodb           = "dataops-prod-tf-infra-state-lock"
    }

    cloudops-dev = {
      account_id         = "444455556666"
      account            = "CloudOps Dev Environment"
      workspace_iam_role = "arn:aws:iam::444455556666:role/administrator"
      region_code        = "ew1"
      region             = "eu-west-1"
      bucket_region      = "eu-west-1"
      bucket             = "cloudops-dev-tf-infra-state"
      dynamodb           = "cloudops-dev-tf-infra-state-lock"
    }

    tvx-plfm-tst2 = {
      account_id         = "860956293230"
      account            = "Travelex Platform Testing 2"
      workspace_iam_role = "arn:aws:iam::860956293230:role/administrator"
      share_r53_iam_role = "arn:aws:iam::665085774436:role/administrator"
      region_code        = "ew1"
      region             = "eu-west-1"
      bucket_region      = "eu-west-1"
      bucket             = "platform-tf-platform-testing2-infra-state"
      dynamodb           = "platform-tf-platform-testing2-infra-state-lock"
    }
    tvx-plfm-shared = {
      account_id         = "665085774436"
      account            = "Travelex Platform shared for ECR REPOSITORIES module"
      workspace_iam_role = "arn:aws:iam::665085774436:role/administrator"
      share_r53_iam_role = "arn:aws:iam::665085774436:role/administrator"
      region_code        = "ew1"
      region             = "eu-west-1"
      bucket_region      = "eu-west-1"
      bucket             = "platform-tf-platform-shared-infra-state"
      dynamodb           = "platform-tf-platform-shared-infra-state-lock"
    }

  }
}
