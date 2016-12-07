source 'https://rubygems.org'

ruby '2.3.1'

gem 'rails', '4.2.0'

# Core
gem 'autoprefixer-rails'
gem 'cancancan', '~> 1.8'
gem 'coffee-rails', '~> 4.0.0'
gem 'devise'
gem 'jbuilder', '~> 2.0'
gem 'jquery-rails'
gem 'pg'
gem 'rack-cache', :require => 'rack/cache' #Caching images
gem 'turbolinks'
gem 'uglifier', '>= 1.3.0'

# Assets
gem 'acts_as_list'
gem 'auto_html'
gem 'bootstrap-sass', '~> 3.2.0'
gem 'bootstrap3-datetimepicker-rails', '~> 3.0.0.2'
gem 'bootstrap_form'
gem 'codemirror-rails' # Used by summernote for displaying html
gem 'dragonfly', "~>1.0.12" #Image Uploading
gem 'dragonfly-s3_data_store' # Store images on s3
gem 'dynamic_sitemaps'
gem 'font-awesome-rails' # Used by summernote
gem 'fuzzily' #Fuzzy string search
gem 'http_accept_language' #Auto set locale
gem 'icalendar' # Export i ics calendar files
gem 'jquery-minicolors-rails'
gem 'kaminari' # Pagination
gem 'kaminari-bootstrap', '~> 3.0.1'
gem 'momentjs-rails', '>= 2.5.0' #Required for datetimepicker
gem 'nested_form'
gem 'rails-settings-cached', '0.4.1'
gem 'rails_bootstrap_navbar'
gem 'remotipart', '~> 1.2'
gem 'rollbar'
gem 'sass-rails', '~> 4.0.3'
gem 'select2-rails'
gem 'traco' #Localization
gem 'twitter'
gem 'whenever', :require => false #Automatically generate sitemaps
gem 'zeroclipboard-rails'
gem 'meta-tags'

group :development do
  gem 'awesome_print' # Better printing in console
  gem 'better_errors'
  gem 'binding_of_caller' #Used by better errors to provide REPL
  gem 'bullet' # Display N+1 problems
  gem 'web-console'
  gem 'quiet_assets'
end

group :development, :test do
  gem 'capybara'
  gem 'dotenv-rails'
  gem 'factory_girl_rails'
  gem 'ffaker'
  gem 'poltergeist'
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'rspec-rails'
end

group :test do
  gem 'database_cleaner'
  gem 'shoulda-matchers', require: false
  gem 'faker'
  gem 'meta_request' # Used by chrome plugin railspanel to show request info
  gem 'spring'
  gem 'quiet_assets'
end

group :production do
  gem 'puma'
  gem 'rails_12factor'
  gem 'rails_stdout_logging'
end
