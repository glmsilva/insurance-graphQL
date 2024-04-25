source "https://rubygems.org"

ruby "3.3.0"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.1.3", ">= 7.1.3.2"
gem "sqlite3", "~> 1.4"
gem "graphql"
gem "bunny"
gem "puma", ">= 5.0"
gem "bootsnap", require: false
gem "dry-validation"
gem "dotenv"

group :development, :test do
  gem "debug", platforms: %i[ mri windows ]
  gem "rspec-rails"
  gem "pry"
  gem "pry-nav"
  gem "webmock"
end

group :development do
  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
end

