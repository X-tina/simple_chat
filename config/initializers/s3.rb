S3_CREDENTIALS = { access_key_id: ENV["ACCESS_KEY_ID"],
                 secret_access_key: ENV["SECRET_ACCESS_KEY"],
                 bucket: ENV["BUCKET"] }

Aws.config.update({
  region: 'us-west-2',
  credentials: Aws::Credentials.new(ENV['ACCESS_KEY_ID'], ENV['SECRET_ACCESS_KEY'])  
})

S3_BUCKET = Aws::S3::Resource.new.bucket(ENV['BUCKET'])

S3 = Aws::S3::Resource.new
