source "https://rubygems.org"

gem "librarian", "~> 0.1"
gem "librarian-chef", "~> 0.0.4"

group :lint do
  gem "foodcritic", "~> 3.0"
  gem "rubocop", "~> 0.23"
  gem "rainbow", "< 2.0"
end

group :kitchen_common do
  gem "test-kitchen", "~> 1.2"
end

group :kitchen_vagrant do
  gem "kitchen-vagrant", "~> 0.11"
end

group :kitchen_cloud do
  gem "kitchen-digitalocean", "~> 0.8"
end

group :development do
  gem "ruby_gntp"
  gem "growl"
  gem "rb-fsevent"
  gem "guard", "~> 2.4"
  gem "guard-kitchen"
  gem "guard-foodcritic"
  gem "guard-rspec"
  gem "guard-rubocop"
  gem "rake"
end
