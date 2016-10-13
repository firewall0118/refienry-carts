# Carts extension for Refinery CMS.

## How to get this running with BKP

Add this line to your Gemfile
    
    gem 'refinerycms-carts', :git => 'git@github.com:AIDCVT/refinerycms-carts.git'

Run these commands

    bundle install
    rails generate refinery:carts
    rake db:migrate
    # rake db:seed # Only run this for a new setup - will erase some of your data.
 
## How to build this extension as a gem

    cd vendor/extensions/carts
    gem build refinerycms-carts.gemspec
    gem install refinerycms-carts.gem

    # Sign up for a http://rubygems.org/ account and publish the gem
    gem push refinerycms-carts.gem
