require 'rubygems'
require 'mechanize'

class LineCheck
  
  attr_reader :phone_number, :on_net_url, :off_net_url, :failure_url
  
  def initialize(phone_number)
    @agent = Mechanize.new
    @phone_number = PhoneNumber.new(phone_number)
    # over-ride these instance variables in subclass
    @on_net_url = nil
    @off_net_url = nil
    @failure_url = nil
  end
  
  def process
    return "Phone number invalid. Valid format: (01)8321234" if !@phone_number.valid?
    page_uri = get_line_check_result_uri
    format_result(page_uri)
  end
  
    private
  
    def get_line_check_result_uri
      raise Exception, "Define this method in a subclass of LineCheck"
    end
  
    def format_result(page_uri)
      @on_net_url == page_uri ? "Yes" : "No"
    end
  
end

require File.dirname(__FILE__) + '/phone_number'
require File.dirname(__FILE__) + '/magnet_line_check'
require File.dirname(__FILE__) + '/smart_line_check'