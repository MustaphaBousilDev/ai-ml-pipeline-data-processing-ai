variable "aws_region" {
    description = "The AWS region to deploy resources in"
    default     = "us-west-2"
}

variable "bucket_name" {
    description = "The name of the S3 bucket"
    default     = "my-unique-data-bucket-20230606"
}

variable "stream_name" {
    description = "The name of the Kinesis Data Stream"
    default     = "my-data-stream"
}

variable "shard_count" {
    description = "The number of shards for the Kinesis Data Stream"
    default     = 1
}

variable "retention_period" {
    description = "The retention period (in hours) for the Kinesis Data Stream"
    default     = 24
}
