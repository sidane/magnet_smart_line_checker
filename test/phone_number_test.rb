require 'rubygems'
require 'test/unit'
require File.dirname(__FILE__) + '/../lib/phone_number'

class LineCheckTest < Test::Unit::TestCase

  def setup
    @valid_number = PhoneNumber.new("(01) 8321234")
    @invalid_number = PhoneNumber.new("asdfsfd")
    @valid_number_no_space = PhoneNumber.new("(01)8321234")
    @number_with_no_area_code = PhoneNumber.new("8321234")
  end
  
  def test_processing_valid_number_with_space
    assert_equal "01", @valid_number.area
    assert_equal "8321234", @valid_number.number
  end
  
  def test_processing_valid_number_without_space
    assert_equal "01", @valid_number_no_space.area
    assert_equal "8321234", @valid_number_no_space.number
  end
  
  def test_processing_invalid_number
    assert_nil @invalid_number.area
    assert_nil @invalid_number.number
  end
  
  def test_processing_number_with_no_area_code
    assert_nil @invalid_number.area
    assert_nil @invalid_number.number
  end
  
  def test_to_s
    assert_equal "(01)8321234", @valid_number.to_s
  end
  
  def test_to_s_without_brackets
    assert_equal "018321234", @valid_number.to_s(false)
  end
  
  def test_valid_with_phone_number_including_area_code
    assert @valid_number.valid?
  end
  
  def test_phone_number_is_not_valid_without_area_code
    assert !@number_with_no_area_code.valid?
  end
  
  def test_valid_with_invalid_number
    assert !@invalid_number.valid?
  end
  
end
