require 'test/unit'
require File.dirname(__FILE__) + '/../lib/line_check'

class LineCheckTest < Test::Unit::TestCase

  def setup
    @valid_number = "(01) 8321234"
    @valid_number_no_space = "(01)8321234"
    @number_with_no_area_code = "8321234"
    @invalid_number = "asdfsfd"
  end
  
  def test_processing_valid_number_with_space
    phone_number = PhoneNumber.new(@valid_number)
    assert_equal "01", phone_number.area
    assert_equal "8321234", phone_number.number
  end
  
  def test_processing_valid_number_without_space
    phone_number = PhoneNumber.new(@valid_number_no_space)
    assert_equal "01", phone_number.area
    assert_equal "8321234", phone_number.number
  end
  
  def test_processing_invalid_number
    phone_number = PhoneNumber.new(@invalid_number)
    assert_nil phone_number.area
    assert_nil phone_number.number
  end
  
  def test_processing_number_with_no_area_code
    phone_number = PhoneNumber.new(@invalid_number)
    assert_nil phone_number.area
    assert_nil phone_number.number
  end
  
  def test_to_s
    phone_number = PhoneNumber.new(@valid_number)
    assert_equal "(01)8321234", phone_number.to_s
  end
  
  def test_valid_with_valid_number
    phone_number = PhoneNumber.new(@valid_number)
    assert phone_number.valid?
  end
  
  def test_valid_with_invalid_number
    phone_number = PhoneNumber.new(@invalid_number)
    assert !phone_number.valid?
  end
  
end
