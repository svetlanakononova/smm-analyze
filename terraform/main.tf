terraform {
  required_version = ">= 1.0"
  backend "local" {}  # Can change from "local" to "gcs" (for google) or "s3" (for aws), if you would like to preserve your tf-state online
  required_providers {
    google = {
      source  = "hashicorp/google"
    }
  }
}

provider "google" {
  project = var.project
  region = var.region
  // credentials = file(var.credentials)  # Use this if you do not want to set env-var GOOGLE_APPLICATION_CREDENTIALS
}

# Data Lake Bucket
# Ref: https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket
resource "google_storage_bucket" "data-lake-bucket" {
  name          = "data_lake_bucket_${var.project}" 
  location      = "${var.region}"

  # Optional, but recommended settings:
  storage_class = "STANDART"
  uniform_bucket_level_access = true

  versioning {
    enabled     = true
  }

  lifecycle_rule {
    action {
      type = "Delete"
    }
    condition {
      age = 30  // days
    }
  }

  force_destroy = true
}

# DWH
# Ref: https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/bigquery_dataset


resource "google_bigquery_dataset" "rawdataset" {
  dataset_id = var.rawdataset
  project    = var.project
  location   = var.region
}


resource "google_bigquery_dataset" "stagedataset" {
  dataset_id = var.stagedataset
  project    = var.project
  location   = var.region
}


resource "google_bigquery_dataset" "dwh" {
  dataset_id = var.dwh
  project    = var.project
  location   = var.region
}
