source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.1.1'
gem 'puma', '~> 3.7'
gem 'pg'
gem 'active_model_serializers', '~> 0.10.0'
gem 'responders'
gem 'bcrypt', '~> 3.1.7'
gem 'jwt'
gem 'pundit'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails', '~> 3.5'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'pry-rails'
  gem 'annotate'
end

group :test do
  gem 'shoulda-matchers',
    git: 'https://github.com/thoughtbot/shoulda-matchers.git',
    branch: 'rails-5'
  gem "factory_girl_rails", "~> 4.0"
  gem "faker"
  gem "json-schema"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
# gem 'rack-cors'
