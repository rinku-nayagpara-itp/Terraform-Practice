module "codecommit" {
  source = "./codecommit"
}

module "amplify" {
  source         = "./amplify"
  codecommit-arn = module.codecommit.clone_url_http

}

module "cognito" {
  source = "./cognito"
}