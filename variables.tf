# vim:ts=2:sw=2:et:

variable "tags" {
  type        = map
  description = ""
  default     = {}
}

variable "identifier" {
  type        = string
  description = "(required) DB identifier"
}

variable "engine" {
  type        = string
  description = "(required) RDS engine"
}

variable "engine_version" {
  type        = string
  description = "(required) Engine version"
}

variable "create_parameter_group" {
	type        = bool
	description = "(optional - default: false) Create a custom parameter group"
	default     = false
}

variable "parameter_group_family" {
  type        = string
  description = "(optional - default: empty) DB parameter group family to be copied as a new one"
  default     = ""
}

variable "parameter_group_name" {
  type        = string
  description = "(optional - default: empty) DB parameter group"
  default     = ""
}

variable "parameters" {
	type = list(map(string))
	description = "(optional - default: []) List of maps to define parameters for the parameter group"
	default     = []
}

variable "az" {
  type        = string
  description = "(required) Availability zone"
  default     = ""
}

variable "multi_az" {
  type        = bool
  description = "(optional - default: false)"
  default     = false
}

variable "port" {
  type    = number
  default = 0
}

variable "storage_type" {
  type        = string
  description = "(optional - default: gp2) DB storage type. If iops is > 0, this will automatically be set to io1"
  default     = "gp2"
}

variable "allocated_storage" {
  type        = number
  description = "(required)"
}

variable "max_allocated_storage" {
  type        = number
  description = "(optional - default: 0)"
  default     = 0
}

variable "ca_cert_identifier" {
  type        = string
  description = "(optional - default: rds-ca-2019)"
  default     = "rds-ca-2019"
}

variable "storage_encrypted" {
  type        = bool
  description = "(optional)"
  default     = true
}

variable "iops" {
  type        = number
  description = "(optional - default: 0) If this is greater than 0, storage_type will be set to io1"
  default     = 0
}

variable "instance_class" {
  type        = string
  description = "(required) DB instance class"
}

variable "db_subnet_group_name" {
  type        = string
  description = "(optional - default: empty) DB subnet group name. If empty, the module will create it"
  default     = ""
}

variable "subnet_ids" {
  type        = list
  description = "(optional - default: empty) List of subnet ids. Required if subnet_group_name is empty and needs to be created by the module"
  default     = []
}

variable "monitoring_interval" {
  type        = number
  description = "(optional - default: 0) DB instance monitoring interval"
  default     = 0
}

variable "monitoring_role_arn" {
  type        = string
  description = "(optional - default: empty) Monitoring role ARN. If ommited, the module will create one"
  default     = ""
}

variable "performance_insights_enabled" {
  type        = bool
  description = "(optional - default: true)" 
  default     = true
}

variable "minor_version_upgrade" {
  type        = bool
  description = "(optional - default: true) Automatically upgrade minor version"
  default     = true
}

variable "db_name" {
  type        = string
  description = "(optional - default: empty) Default database name"
  default     = ""
}

variable "admin_user" {
  type        = string
  description = ""
  default     = ""
}

variable "admin_pass" {
  type        = string
  description = ""
  default     = ""
}

variable "iam_auth_enabled" {
  type        = bool
  description = "(optional - default: true)"
  default     = true
}

variable "skip_final_snapshot" {
  type        = bool
  description = "(optional - default: false) Skip final snapshot creation when the cluster is terminated"
  default     = false
}

variable "final_snapshot_id" {
  type        = string
  description = "(optional - default: empty) Final snapshot identifier when the cluster is terminated"
  default     = ""
}

variable "backup_retention_period" {
  type        = number
  description = ""
  default     = 5
}

variable "backup_window" {
  type        = string
  description = ""
  default     = "00:00-01:00"
}

variable "maintenance_window" {
  type        = string
  description = ""
  default     = "mon:22:00-mon:23:00"
}

variable "deletion_protection" {
  type        = bool
  description = ""
  default     = false
}

variable "snapshot_identifier" {
  type        = string
  description = "(optional - snapshot ARN identifier if this instance is to be created from an existing snapshot)"
  default     = ""
}

variable "cloudwatch_logs_exports" {
  type        = list
  description = ""
  default     = []
}

variable "vpc_id" {
  type        = string
  description = "(optional - default: empty) VPC ID. Required if create_security_group is true"
  default     = ""
}

variable "create_security_group" {
  type        = bool
  description = "(optional - default: true) Create a security group to be associated with the cluster"
  default     = true
}

variable "security_group_name" {
  type        = string
  description = "(optional - default: cluster_identifier)"
  default     = ""
}

variable "security_group_rules" {
  type        = list(object({
    from_port       = number
    to_port         = number
    protocol        = string
    self            = bool
    cidr_blocks     = list(string)
    security_groups = list(string)
    description     = string
  }))
  description = "(optional - default: []) List of security group rules for the SG created by this module"
  default     = []
}

variable "security_group_ids" {
  type        = list
  description = "(optional - default: []) List of security group IDs to associate with the cluster"
  default     = []
}

variable "monitoring_role_name" {
  type        = string
  description = "(optional - default: empty) Name for the monitoring role"
  default     = ""
}

variable "db_iam_policies" {
  type        = list
  description = "(optional - defaut [ AmazonRDSEnhancedMonitoringRole ]) IAM policies for cluster role"
  default     = [ "AmazonRDSEnhancedMonitoringRole" ]
}

variable "route53_zone_id" {
  type        = string
  description = "(optional - default: empty) Route53 zone id for cluster resource records"
  default     = ""
}

variable "route53_create_record" {
  type        = bool
  description = "(optional - default: false) Create Route53 resource records"
  default     = false
}

variable "route53_record_ttl" {
  type        = number
  description = "(optional - default: 3600) Route53 resource record time to live"
  default     = 3600
}

variable "route53_record" {
  type        = string
  description = "(optional - default: empty) Route53 resource record for the cluster endpoint"
  default     = ""
}

