<<<DOCUMENTATION>>>

Ruby 2.4.0
Rails 5.1.4
Homebrew 1.3.4

<<<CREATE APP>>>

rails new bindler --database=postgresql
cd bindler


psql postgres
CREATE DATABASE bindler;
\q


change config/database.yml -> 
	in development:, test:, and production:,
		change name of database: to bindler

~git commit~





<<<ADD DEVISE>>>

add to gemfile -> gem 'devise', '~> 4.3'
bundle 

CLI: rails generate devise:install

add to config/environments/development.rb -> config.action_mailer.default_url_options = { host: 'localhost', port: 3000 } 

add to app/views/layouts/application.html.erb., in body, above yield tag ->
	<p class="notice"><%= notice %></p>
    <p class="alert"><%= alert %></p>
    
add to config/routes.rb ->
	devise_for :creators

CLI: rails g devise User
CLI: rails g devise Creator
CLI: rails g devise:views users
CLI: rails g devise:views creators
CLI: rake db:migrate

~git commit~





<<<ADD ACTIVEADMIN>>>

gem 'activeadmin', '~> 1.1'
CLI: bundle
CLI: gem install activeadmin
CLI: rails g active_admin:install
CLI: rake db:migrate
CLI: rake db:seed

~git commit~





<<<ADD BOOTSTRAP>>>

gem 'jquery-rails', '~> 4.3', '>= 4.3.1'
gem 'bootstrap-sass', '~> 3.3', '>= 3.3.7'

add to app/assets/stylesheets/application.scss, at the bottom (change extension on application.css) ->
	@import "bootstrap-sprockets";
	@import "bootstrap";

add to app/assets/javascripts/application.js above existing requires ->
	//= require jquery
	//= require bootstrap-sprockets

~git commit~





<<<ADD PAPERCLIP>>>

add to config/environments/development.rb -> Paperclip.options[:command_path] = "/usr/local/bin/"

brew install imagemagick

add to gemfile -> gem "paperclip", "~> 5.0.0"

add to app/models/creator ->
	has_attached_file :creator_img, styles: { medium: "450x450>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
	validates_attachment_content_type :creator_img, content_type: /\Aimage\/.*\z/ 
add to app/models/user->
	has_attached_file :user_img, styles: { medium: "450x450>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
	validates_attachment_content_type :user_img, content_type: /\Aimage\/.*\z/ 

CLI: rails generate paperclip creator creator_img
CLI: rails generate paperclip user user_img
CLI: rake db:migrate

~git commit~





<<<CONTROLLERS, VIEWS, AND ROUTING>>>

CLI: rails g controller creators
CLI: rails g controller users

add to app/views/creators -> index.html.erb 
add to app/views/users -> index.html.erb 

add to config/routes.rb ->
	resources :creators
  	resources :users
  	root 'creators#index'

~git commit~