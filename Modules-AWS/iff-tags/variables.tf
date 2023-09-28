########################
##  AWS Tag Variables
########################

variable "Division" {
  default = ""
}

variable "Function" {
  default = ""
}

variable "Environment" {
  default = ""
}

variable "DR_Grouping" {
  default = ""
}

variable "Business_Owner" {
  default = ""
}

variable "L1_Technical_Owner" {
  default = ""
}

variable "L2_Technical_Owner" {
  default = ""
}

variable "AWS_Service" {
  default = ""
}

variable "Backup" {
  default = "7"
}

variable "Retention" {
  default = "30"
}

variable "Shut_Down" {
  default = "0"
}

variable "Start_Up" {
  default = ""
}

variable "Application" {
  default = ""
}

variable "Operating_System" {
  default = ""
}

variable "Database" {
  default = ""
}

variable "Date_in_Service" {
  default = ""
}

variable "Cost_Center" {
  default = ""
}

variable "Project_ID" {
  default = ""
}

variable "SNOW_RITM" {
  default = ""
}


//AWX template = G8awx
variable "awx_template_tag" {
  default = ""
}

