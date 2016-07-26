S3_CREDENTIALS = { access_key_id: ENV["ACCESS_KEY_ID"],
                   secret_access_key: ENV["SECRET_ACCESS_KEY"],
                   bucket: ENV["BUCKET"],
                   s3_region: ENV['AWS_REGION'],
                   storage: :s3,
                   s3_host_name: "s3-us-west-2.amazonaws.com" }

Aws.config.update({
  credentials: Aws::Credentials.new(ENV['ACCESS_KEY_ID'], ENV['SECRET_ACCESS_KEY'])  
})

S3_BUCKET = Aws::S3::Resource.new.bucket(ENV['BUCKET'])

S3 = Aws::S3::Resource.new
