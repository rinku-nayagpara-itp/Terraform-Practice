variable "region" {
  default = "us-east-1"
}

variable "codecommit-user-name" {
  default = "rinku-wildrydes-user"
}

variable "lambda-role-name" {
  default = "wildRydesRole-rinku"
}

variable "lambda-name" {
  default = "RinkuFunc"
}

variable "api-gateway-name" {
  default = "RinkuNayagparaWildrydes"
}

variable "api-gateway-authorizer" {
  default = "CognitoUserPoolAuthorizer"
}