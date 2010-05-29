require File.dirname(__FILE__) + "/../line_checker"
require 'mocha'
require 'test/unit'
require 'rack/test'

class LineCheckerTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_homepage
    get '/'
    assert last_response.ok?
    assert_match /Line Checker/, last_response.body
  end
  
  def test_process_with_no_phone_number
    post '/process', :phone_numbers => ""
    follow_redirect!
    
    assert_match /Please enter at least one phone number/, last_response.body
    assert_match /<form action="\/process"/, last_response.body
  end
  
  def test_process_with_on_net_phone_number
    MagnetLineCheck.any_instance.
    expects(:get_line_check_result_uri).returns(MagnetLineCheck.new("123").on_net_url)
    SmartLineCheck.any_instance.
    expects(:get_line_check_result_uri).returns(SmartLineCheck.new("123").on_net_url)
    
    post '/process', :phone_numbers => "(01)8323055"
    
    assert_match /Line Checker Results/, last_response.body
    assert_match /\(01\)8323055/, last_response.body
    assert_match /<strong>Magnet:<\/strong> Yes/, last_response.body
    assert_match /<strong>Smart:<\/strong> Yes/, last_response.body
  end
  
  def test_process_with_off_net_phone_number
    MagnetLineCheck.any_instance.
    expects(:get_line_check_result_uri).returns(MagnetLineCheck.new("123").off_net_url)
    SmartLineCheck.any_instance.
    expects(:get_line_check_result_uri).returns(SmartLineCheck.new("123").off_net_url)
    
    post '/process', :phone_numbers => "(01)5551235"
    
    assert_match /Line Checker Results/, last_response.body
    assert_match /\(01\)5551235/, last_response.body
    assert_match /<strong>Magnet:<\/strong> No/, last_response.body
    assert_match /<strong>Smart:<\/strong> No/, last_response.body
  end
  
  def test_process_with_invalid_phone_number    
    post '/process', :phone_numbers => "5551235"
    
    assert_match /Line Checker Results/, last_response.body
    assert_match /Phone number invalid. Valid format: \(01\)8321234/, last_response.body
  end
  
end