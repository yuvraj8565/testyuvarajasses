# INDEX FILE new version one two
resource "aws_s3_bucket_object" "object" {
  bucket = var.s3_bucket
  key    = "index.html"
  source = "index.html"
  etag   = filemd5("index.html")

}
