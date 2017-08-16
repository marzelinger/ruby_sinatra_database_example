# app.rb
require 'bundler'
Bundler.require
require "sinatra"
require "sinatra/activerecord"
require "./models.rb"
set :database, "sqlite3:myblogdb.sqlite3"
class ApplicationController < Sinatra::Base
get '/' do
	@posts = Post.all
	erb :index
end
# handles the unique url requests for each post.
get "/post/:id" do
# params[:id] returns the id number of the particular post we clicked on, the Post.find(idNumber) returns the post entry with that id number
 @post = Post.find(params[:id])
 erb :post_page
end
# create post
post '/post' do
	@post = Post.create(title: params[:title], body: params[:body])
	redirect '/'
# 	redirect will create the post and then send you back to the homepage which will have been updated to reflect this change
end
# update post
# uses put not post or get, this is how the post_page.erb knows to go here when the value is put
post '/postchange/:id' do
    # finds the post with the correct id number
	@post = Post.find(params[:id])
    # updates the post to reflect the user input
	@post.update(title: params[:title], body: params[:body])
    # saves this updates post
	@post.save
    # redirects to the page we were on when we chose to edit with these changes reflected	
	redirect '/post/'+params[:id]
end 

# delete post
post '/postdelete/:id' do
	@post = Post.find(params[:id])
	@post.destroy
	redirect '/'
end
end