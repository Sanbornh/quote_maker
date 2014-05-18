# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
QuoteMaker::Application.initialize!


S3_CREDENTIALS = YAML.load_file("#{Rails.root}/config/s3.yml")