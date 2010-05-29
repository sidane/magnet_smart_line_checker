require 'rubygems'
require 'sinatra'
require 'erb'

enable :sessions

get "/" do
  @error = request.cookies["error"]
  erb :index
end

post "/process" do
  if params["phone_numbers"].empty?
    session[:flash] = "Please enter at least one phone number"
    redirect "/"
  end
end

helpers do
  def flash_message
    unless session[:flash].nil?
      value = session[:flash].dup
      session[:flash] = nil
      '<p class="flash">' + value + '</p>'
    end
  end
end