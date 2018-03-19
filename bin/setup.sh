#!/bin/bash

# Exit on first failure.
set -e

echo "Install dependencies"
source ~/.rvm/scripts/rvm
rvm use 2.4.1
gem install bundler --conservative
bundle check || bundle install

echo "Rails setup"
rake haml:replace_erbs
rails g rspec:install
rails g devise:install
bundle exec figaro install

echo "Generate Home controller"
rails g controller Home index --no-assets --no-helper --no-view-specs

echo "Setup database and create User model"
rails db:create
rails g devise User
rails db:migrate

annotate

echo "Remove logs and cache"
rm -f log/*
rm -rf tmp/cache
