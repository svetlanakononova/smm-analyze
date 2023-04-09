
variable "project" {
  description = "Project ID"
  type = string
}

variable "region" {
  description = "Region for GCP resources. Choose as per your location: https://cloud.google.com/about/locations"
  type = string
}

variable "bucket" {
  description = "Google Storage Bucket for source files"
  type = string
}

variable "rawdataset" {
  description = "BigQuery Dataset for raw data"
  type = string
}

variable "stagedataset" {
  description = "BigQuery Dataset for staging data"
  type = string
}

variable "dwh" {
  description = "BigQuery Dataset for Data Warehouse"
  type = string
}
