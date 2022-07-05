variable "applicationname" {
  description = "Name of the applicationname"
  type        = string
}
variable "env" {
  description = "Name of the environment"
  type        = string
}
variable "tags" {
  type        = map(any)
  description = "A list of tags to be applied"
}