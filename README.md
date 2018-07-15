# ReadyMadeRails

Complete, Ruby on Rails web application, complete with user authentication, an admin panel, a PosgreSQL database, Boostrap integration and photo-upload capability.

## Sections
* [Create application](#create_application)
* [User Authentication](#add-devise)
* [Administration Panel](#add-activeadmin)
* [Bootstrap Integration](#add-bootstrap)
* [Enable Photo Upload](#add-paperclip)
* [Controllers, Views, AND Routing](#controllers,-views,-and-routing)
* [Final Word](#final-word)

## Dependencies
```ruby
Ruby 2.4.0
Rails 5.1.4
Homebrew 1.3.4
```

## Create application
```sh
user$ rails new yourapp --database=postgresql
user$ cd yourapp
user$ psql postgres
user$ CREATE DATABASE yourappdb;
user$ \q
```

Change `config/database.yml`:
```
default: &default
  adapter: postgresql
  encoding: unicode
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>

development:
  <<: *default
  database: yourappdb

test:
  <<: *default
  database: yourappdb

production:
  <<: *default
  database: yourappdb
  username: yourappdb 
  password: <%= ENV['YOURAPP_DATABASE_PASSWORD'] %>
```

Commit changes:
```sh
user$ git add .
user$ git commit -m "database created"
```

## Add Devise

Add  to `Gemfile`:
```ruby
gem 'devise', '~> 4.3'
```

Bundle and install:
```sh
user$ bundle 
user$ rails generate devise:install
```

Add to `config/environments/development.rb`:
```ruby
config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }
``` 

Add to `app/views/layouts/application.html.erb`, in body, above yield tag:
```ruby
<p class="notice"><%= notice %></p>
<p class="alert"><%= alert %></p>
```
    
Add to `config/routes.rb`:
```ruby
devise_for :creators
```

```sh
user$ rails g devise User
user$ rails g devise Creator
user$ rails g devise:views users
user$ rails g devise:views creators
user$ rake db:migrate
```

Commit changes:
```sh
user$ git add .
user$ git commit -m "added user authentication"
```

## Add Activeadmin

Add to `Gemfile`:
```ruby
gem 'activeadmin', '~> 1.1'
```

Bundle, install, and rake the database:
> Activeadmin adds 2 new columns to `schema.rb`
```sh
user$ bundle
user$ gem install activeadmin
user$ rails g active_admin:install
user$ rake db:migrate
user$ rake db:seed
```

Commit changes:
```sh
user$ git add .
user$ git commit -m "added admin capability"
```

## Add Bootstrap

Add to `Gemfile`:
```ruby
gem 'jquery-rails', '~> 4.3', '>= 4.3.1'
gem 'bootstrap-sass', '~> 3.3', '>= 3.3.7'
```

Change the extension of `application.css` to `application.scss` 
Then, Add to `app/assets/stylesheets/application.scss`, below comment block:
```ruby
@import "bootstrap-sprockets";
@import "bootstrap";
```

Add to `app/assets/javascripts/application.js` above existing requires:
```js
//= require jquery
//= require bootstrap-sprockets
```

Commit changes:
```sh
user$ git add .
user$ git commit -m "bootstrap enabled"
```

## Add Paperclip

Add to `config/environments/development.rb`:
```ruby
Paperclip.options[:command_path] = "/usr/local/bin/"
```

Run:
```sh
user$ brew install imagemagick
```

Add to `Gemfile`:
```ruby
gem "paperclip", "~> 5.0.0"
```

Add to `app/models/creator.rb`:
```ruby
has_attached_file :creator_img, styles: { medium: "450x450>", thumb: "100x100>" }, 
                      default_url: "/images/:style/missing.png"
validates_attachment_content_type :creator_img, content_type: /\Aimage\/.*\z/
``` 

Add to `app/models/user.rb`:
```ruby
has_attached_file :user_img, styles: { medium: "450x450>", thumb: "100x100>" }, 
                      default_url: "/images/:style/missing.png"
validates_attachment_content_type :user_img, content_type: /\Aimage\/.*\z/ 
```

Rake the database
> Paperclip makes table updates in the `schema.rb`:
```sh
user$ rails generate paperclip creator creator_img
user$ rails generate paperclip user user_img
user$ rake db:migrate
```

Commit changes:
```sh
git add .
git commit -m "added photo upload functionality"
```

## Controllers, Views, and Routing

Generate controllers:
```sh
user$ rails g controller creators
user$ rails g controller users
```

Create `index.html.erb` in `app/views/creators`, and `index.html.erb` to `app/views/users`.
Then, in `config/routes.rb` add:
```ruby
resources :creators
resources :users
root 'creators#index'
```

Commit changes:
```sh
git add .
git commit -m "connect controllers and views"
```

## Final Word
You now have a fully functioning Ruby on Rails web application, complete with user authentication, an admin panel. a connected PosgreSQL database, Boostrap integration and photo-upload capability.
