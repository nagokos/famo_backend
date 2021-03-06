source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.0'

gem 'bootsnap', '>= 1.4.4', require: false
gem 'mysql2', '~> 0.5'
gem 'puma', '~> 5.5'
gem 'rails', '~> 6.1.3', '>= 6.1.3.2'
gem 'sprockets', '~> 3.7.2' # 4系だとassetsがない場合にエラーが発生する

# 日本語化
gem 'enum_help'
gem 'rails-i18n'
# 認証
gem 'sorcery'
# 定数管理
gem 'config'
# 初期データ
gem 'seed-fu'
# json
gem 'active_model_serializers'
# ページネーション
gem 'pagy'
# 管理者ページ
gem 'administrate'
# s3
gem 'aws-sdk'
# ses
gem 'aws-sdk-rails'
# 画像
gem 'carrierwave'
# cors
gem 'rack-cors'

group :development, :test do
  gem 'awesome_print'
  gem 'bullet'
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'pry-byebug'
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
  gem 'database_cleaner'
  gem 'rspec_junit_formatter'
  gem 'shoulda-matchers'
  gem 'simplecov'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
