class PhoneNumber
  
  attr_accessor :area, :number
  
  def initialize(phone_number)
    @area, @number = phone_number.scan(/\((\d*)\)\s?(\d*)/).flatten
  end
  
  def to_s(with_brackets = true)
    array = []
    array << "(" if with_brackets
    array << @area
    array << ")" if with_brackets
    array << @number
    array.join
  end
  
  def valid?
    !@number.nil?
  end
  
end