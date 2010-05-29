require 'rubygems'
require 'sinatra'
require 'erb'
require File.dirname(__FILE__) + "/lib/line_check"

enable :sessions

get "/" do
  @error = request.cookies["error"]
  erb :index
end

post "/process" do
  validate_phone_number_params
  @results = process_phone_numbers
  erb :result
end

helpers do
  def flash_message
    unless session[:flash].nil?
      value = session[:flash]
      session[:flash] = nil
      '<p class="flash">' + value + '</p>'
    end
  end
  
  def render_results
    unless @results.nil?
      @results.inject([]) do |array, result|
        array << "<h3>#{result[:phone_number]}</h3>"
        array << "<p>"
        array << "<strong>Magnet:</strong> #{result[:magnet_result]}</p>"
        array << "<strong>Smart:</strong> #{result[:smart_result]}</p>"
        array << "<hr />"
      end.join("\n")
    end
  end
end

  private

  def validate_phone_number_params
    if params["phone_numbers"].empty?
      session[:flash] = "Please enter at least one phone number"
      redirect "/"
    end
  end

  def process_phone_numbers
    params["phone_numbers"].split(" ").inject([]) do |array, phone_number|
      hash = {}
      hash[:phone_number] = phone_number
      hash[:magnet_result] = MagnetLineCheck.new(phone_number).process
      hash[:smart_result] = SmartLineCheck.new(phone_number).process
      array << hash
    end
  end
  