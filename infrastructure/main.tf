provider "aws" {
    region = var.aws_region
}

resource "aws_s3_bucket" "data_bucket" {
    bucket = "${var.bucket_name}-${random_id.bucket_suffix.hex}"
}

resource "aws_kinesis_stream" "data_stream" {
    name             = var.stream_name
    shard_count      = var.shard_count
    retention_period = var.retention_period
}

resource "random_id" "bucket_suffix" {
    byte_length = 4
}