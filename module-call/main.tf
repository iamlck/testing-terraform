module "cluster" {
  source = "../../base/cluster-base"
  COMMON_NAME = "<clustername>"
}

module "web_ecr" {
  source = "../../base/ecr-base"
  COMMON_NAME="<repo_prefix>"
  ENVIRONMENT_NAME="<repo_sufix>"
  RETENTION = <number_of_days_to_repo_expire>
}
