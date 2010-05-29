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