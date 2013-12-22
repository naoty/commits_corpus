source "https://rubygems.org"

gem "rails", "4.0.2"
gem "mysql2", "0.3.14"
gem "slim-rails"
gem "sass-rails", "~> 4.0.0"
gem "uglifier", ">= 1.3.0"
gem "coffee-rails", "~> 4.0.0"
gem "jquery-rails"
gem "turbolinks"
gem "jbuilder", "~> 1.2"
gem "bootstrap-sass-rails", "~> 3.0.3.0"
gem "elasticsearch", "~> 0.4.3"
gem "octokit", "~> 2.0"

group :doc do
  gem "sdoc", require: false
end

group :development, :test do
  gem "pry-rails"
  gem "rspec-rails"
  gem "guard-rspec"
end

group :development do
  gem "quiet_assets"
end

group :test do
  gem "factory_girl_rails"
  gem "growl" if RUBY_PLATFORM =~ /darwin/
end
