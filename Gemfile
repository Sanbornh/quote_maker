source 'https://rubygems.org'

gem 'aws-sdk' # Used to connect to amazon s3 for image storage
gem 'coffee-rails', '~> 4.0.0' # Use CoffeeScript for .js.coffee assets and views
gem 'figaro'
gem 'jquery-ui-rails'
gem 'jquery-rails'
gem 'jbuilder', '~> 1.2' # Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'pg' # Postgres
gem 'rails', '4.0.4' # Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rmagick', '2.13.2' # All the image editting is done through rmagick
gem 'rubyzip', '>= 1.0.0' # For zipping shit up
gem 'sass-rails', '~> 4.0.2' # Use SCSS for stylesheets
gem 'sorcery' # Used for authentication
gem 'uglifier', '>= 1.3.0' # Use Uglifier as compressor for JavaScript assets

group :production do 
	gem 'rails_12factor' # For deploying to Heroku
end

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

group :development, :test do
	gem 'rspec-rails'
	gem 'factory_girl_rails'
	gem 'hirb'
	gem 'pry'
end