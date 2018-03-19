# Add the current directory to the path Thor uses # to look up files
def source_paths
  Array(super) +
    [File.expand_path(File.dirname(__FILE__))]
end

# Add all dependencies to Gemfile
remove_file "Gemfile"
run "touch Gemfile"

add_source 'https://rubygems.org'

gem 'rails', '~> 5.1.5'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.7'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'haml-rails'
gem 'bootstrap-sass'
gem 'bootswatch-rails'
gem 'font-awesome-rails'
gem 'jquery-rails'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'devise'
gem 'figaro'

gem_group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
  gem 'rspec-rails'
  gem 'factory_bot_rails'
  gem 'shoulda-matchers'
  gem 'simplecov', require: false
end

gem_group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'erb2haml'
  gem 'annotate'
end

gem_group :production do
  gem 'rails_12factor'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

# Add setup files
remove_file 'bin/setup'
copy_file 'bin/setup.sh', 'bin/setup'
run 'chmod 777 bin/setup'

# Add custom layout, shared and devise views
remove_file 'app/views/layouts/application.html.erb'
copy_file 'app/views/layouts/application.html.haml'
directory 'app/views/shared'
directory 'app/views/devise'

# Add custom helper methods
inject_into_file 'app/helpers/application_helper.rb', after: 'module ApplicationHelper' do <<-'RUBY'

  def field_with_validation(model, field)
    if model.errors[field].empty?
      'form-control'
    else
      'form-control is-invalid'
    end
  end

  def field_error_message(model, field)
    return if model.errors[field].empty?

    content_tag :p, class: 'error-message' do
      model.errors[field].first.humanize
    end
  end

  def general_error_message(model)
    if model.errors.any?
      content_tag :div, class: 'alert alert-danger' do
        "Ocurrieron #{model.errors.count} errores al tratar de guardar la información"
      end
    end
  end
RUBY
end

# Add custom application.js file
insert_into_file 'app/assets/javascripts/application.js', after: '//= require turbolinks' do
  "\n//= require jquery
     //= require bootstrap-sprockets"
end

# Add custom application.scss file based on bootswatch v3
bootswatch_template_name = ask "Which bootswatch v3 template do you want to use?"

base_stylesheet = 'app/assets/stylesheets/application'
remove_file base_stylesheet + '.css'
copy_file base_stylesheet + '.scss'

insert_into_file base_stylesheet + '.scss',
                 "\n@import 'bootswatch/#{bootswatch_template_name}/variables';",
                 after: "@import 'bootstrap-sprockets';"

insert_into_file base_stylesheet + '.scss',
                 "\n@import 'bootswatch/#{bootswatch_template_name}/bootswatch';",
                 after: "@import 'bootstrap';"

insert_into_file 'config/routes.rb', "\nroot to: 'home#index'",
                                     after: 'Rails.application.routes.draw do'

if yes? 'Would you like to add es-MX translations and set it to the default language?'
  insert_into_file 'config/application.rb', "\nconfig.i18n.default_locale = 'es-MX'", after: 'config.load_defaults 5.1'

  copy_file 'config/locales/rails.es.yml'
  copy_file 'config/locales/es.yml'
  copy_file 'config/locales/devise.es.yml'
end
