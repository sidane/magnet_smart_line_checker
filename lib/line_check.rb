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

class MagnetLineCheck < LineCheck
  
  # Positive on_net phone number = (01)8325241 :-)
  
  def initialize(phone_number)
    super
    @base_url = "http://www.magnetbusiness.ie/sme/index.htm"
    @on_net_url = "http://www.magnetbusiness.ie/sme/linecheck_broadband.htm"
    @off_net_url = "http://www.magnetbusiness.ie/sme/linecheck_basic.htm"
    @failure_url = "http://www.magnetbusiness.ie/sme/linecheck_none.htm"
  end
  
    private
    
    def get_line_check_result_uri
      page = @agent.get(@base_url)
      form = page.form('form1')
      form.area = @phone_number.area
      form.number = @phone_number.number
      page = @agent.submit(form, form.buttons.first)
      return page.uri.to_s
    end

end

class PhoneNumber
  
  attr_accessor :area, :number
  
  def initialize(phone_number)
    @area, @number = phone_number.scan(/\((\d*)\)\s?(\d*)/).flatten
  end
  
  def to_s
    "(#{@area})#{@number}"
  end
  
  def valid?
    !@area.nil? && !@number.nil? || false
  end
  
end
