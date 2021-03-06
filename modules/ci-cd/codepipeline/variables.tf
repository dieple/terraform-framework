variable "github_oauth_token" {
  type        = string
  description = "GitHub OAuth Token with permissions to access private repositories"
}

variable "github_webhooks_token" {
  type        = string
  default     = ""
  description = "GitHub OAuth Token with permissions to create webhooks. If not provided, can be sourced from the `GITHUB_TOKEN` environment variable"
}

variable "github_webhook_events" {
  description = "A list of events which should trigger the webhook. See a list of [available events](https://developer.github.com/v3/activity/events/types/)"
  type        = list(string)
  default     = ["push"]
}

variable "badge_enabled" {
  type        = bool
  default     = false
  description = "Generates a publicly-accessible URL for the projects build badge. Available as badge_url attribute when enabled."
}

variable "build_image" {
  default     = "aws/codebuild/docker:17.09.0"
  description = "Docker image for build environment, _e.g._ `aws/codebuild/docker:docker:17.09.0`"
}

variable "build_compute_type" {
  default     = "BUILD_GENERAL1_SMALL"
  description = "`CodeBuild` instance size. Possible values are: `BUILD_GENERAL1_SMALL` `BUILD_GENERAL1_MEDIUM` `BUILD_GENERAL1_LARGE`"
}

variable "build_timeout" {
  type        = string
  default     = "60"
  description = "How long in minutes, from 5 to 480 (8 hours), for AWS CodeBuild to wait until timing out any related build that does not get marked as completed."
}

variable "buildspec" {
  default     = ""
  description = "Declaration to use for building the project. [For more info](http://docs.aws.amazon.com/codebuild/latest/userguide/build-spec-ref.html)"
}

# https://www.terraform.io/docs/configuration/variables.html
# It is recommended you avoid using boolean values and use explicit strings
variable "poll_source_changes" {
  type        = bool
  default     = false
  description = "Periodically check the location of your source content and run the pipeline if changes are detected"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Additional tags (e.g. `map('BusinessUnit', 'XYZ')`"
}

variable "privileged_mode" {
  type        = bool
  default     = false
  description = "If set to true, enables running the Docker daemon inside a Docker container on the CodeBuild instance. Used when building Docker images"
}

variable "aws_region" {
  type        = string
  default     = ""
  description = "AWS Region, e.g. us-east-1. Used as CodeBuild ENV variable when building Docker images. [For more info](http://docs.aws.amazon.com/codebuild/latest/userguide/sample-docker.html)"
}

variable "aws_account_id" {
  type        = string
  default     = ""
  description = "AWS Account ID. Used as CodeBuild ENV variable when building Docker images. [For more info](http://docs.aws.amazon.com/codebuild/latest/userguide/sample-docker.html)"
}

variable "ecr_image_repo_name" {
  type        = string
  default     = "UNSET"
  description = "ECR repository name to store the Docker image built by this module. Used as CodeBuild ENV variable when building Docker images. [For more info](http://docs.aws.amazon.com/codebuild/latest/userguide/sample-docker.html)"
}

variable "ecr_image_tag" {
  type        = string
  default     = "latest"
  description = "Docker image tag in the ECR repository, e.g. 'latest'. Used as CodeBuild ENV variable when building Docker images. [For more info](http://docs.aws.amazon.com/codebuild/latest/userguide/sample-docker.html)"
}

variable "environment_variables" {
  type = list(object({
    name   = string
    value  = string
  }))
  default = [{
    name  = "NO_ADDITIONAL_BUILD_VARS"
    value = "TRUE"
  }]

  description = "A list of maps, that contain both the key 'name' and the key 'value' to be used as additional environment variables for the build."
}

variable "webhook_enabled" {
  description = "Set to false to prevent the module from creating any webhook resources"
  type        = bool
  default     = true
}

variable "webhook_target_action" {
  description = "The name of the action in a pipeline you want to connect to the webhook. The action must be from the source (first) stage of the pipeline."
  default     = "Source"
  type        = string
}

variable "webhook_authentication" {
  description = "The type of authentication to use. One of IP, GITHUB_HMAC, or UNAUTHENTICATED."
  default     = "GITHUB_HMAC"
  type        = string
}

variable "webhook_filter_json_path" {
  description = "The JSON path to filter on."
  default     = "$.ref"
  type        = string
}

variable "webhook_filter_match_equals" {
  description = "The value to match on (e.g. refs/heads/{Branch})"
  default     = "refs/heads/{Branch}"
  type        = string
}

variable "s3_bucket_force_destroy" {
  description = "A boolean that indicates all objects should be deleted from the CodePipeline artifact store S3 bucket so that the bucket can be destroyed without error"
  default     = false
  type        = bool
}

variable "report_build_status" {
  type        =  bool
  default     = false
  description = "Set to true to report the status of a build's start and finish to your source provider. This option is only valid when the source_type is BITBUCKET or GITHUB."
}

variable "source_type" {
  type        = string
  description = "The type of repository that contains the source code to be built. Valid values for this parameter are: CODECOMMIT, CODEPIPELINE, GITHUB, GITHUB_ENTERPRISE, BITBUCKET or S3."
}

variable "webhook_insecure_ssl" {
  description = "Webhook Insecure SSL (E.g. trust self-signed certificates)"
  type        = bool
  default     = false
}

variable "active" {
  description = "Indicate of the webhook should receive events"
  default     = true
  type        = bool
}

variable "artifact_type" {
  type        = string
  default     = "NO_ARTIFACTS"
  description = "The build output artifact's type. Valid values for this parameter are: CODEPIPELINE, NO_ARTIFACTS or S3."
}

variable "subnets" {
  type = list(string)
}

variable "security_group_ids" {
  type = list(string)
}

variable "ecr_image_repo_names" {}

variable "github_repo_names" {}

variable "github_repo_branch" {}

variable "ecr_repo_uri" {}
variable "github_repo_owner" {}
variable "eks_cluster_name" {}
variable "eks_kubectl_role_arn" {}
variable "codebuild_service_policy_arn" {}
variable "codebuild_service_role_arn" {}
variable "codepipeline_role_arn" {}
variable "source_location" {}
variable "sm_webhooks_token_secret_name" {}
variable "sm_oauth_token_secret_name" {}
variable "vpc_id" {}
variable "name" {}
variable "stage" {}
variable "artifact_store_bucket_name" {}
variable "kms_key_arn" {}

variable "filters" {
  type = list(object({
    type   = string
    pattern  = string
  }))

  default = [
    {
      type    = "EVENT"
      pattern = "PULL_REQUEST_CREATED, PULL_REQUEST_UPDATED, PULL_REQUEST_REOPENED"
    },
    {
      type    = "BASE_REF"
      pattern = "^refs/heads/master$"
    },
    {
      type    = "HEAD_REF"
      pattern = "^refs/heads/.*"
    },
  ]
}

variable "github_events" {
  type        = list(string)
  description = "Github events that this pipeline will be executed"
  default     = ["push", "pull_request"]
}
