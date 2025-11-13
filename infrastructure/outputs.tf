output "bucket_name" {
  value = aws_s3_bucket.data_bucket.id
}

output "stream_name" {
  value = aws_kinesis_stream.data_stream.name
}