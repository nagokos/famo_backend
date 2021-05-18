source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.0'

gem 'bootsnap', '>= 1.4.4', require: false
gem 'mysql2', '~> 0.5'
gem 'puma', '~> 5.3'
gem 'rails', '~> 6.1.3', '>= 6.1.3.2'
gem 'webpacker', '~> 5.0'

# 日本語化
gem 'rails-i18n'

# 認証
gem 'sorcery'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails'
  gem 'foreman'
  gem 'rails_best_practices', require: false
  gem 'rspec-rails'
  gem 'rubocop', require: false
end

group :development do
  gem 'listen', '~> 3.3'
  gem 'spring'
  gem 'web-console', '>= 4.1.0'
end

group :test do
  gem 'capybara'
  gem 'webdrivers'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
