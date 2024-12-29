variable "project_name" {
    default = "expense"
}
variable "environment" {
    default = "dev"
}
variable "common_tags" {
    default = {
        Project = "expense"
        Environment = "dev"
        Terraform = "true"
        Component = "ingress-alb"
    }
}
variable "zone_name" {
    default = "lingaiah.online"
 }
 variable "zone_id" {
    default ="Z02765181CEB7C51AA89M"

  }