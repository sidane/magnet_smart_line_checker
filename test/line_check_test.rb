require 'test/unit'
require File.dirname(__FILE__) + '/../lib/line_check'

class LineCheckTest < Test::Unit::TestCase
  
  def test_raises_exception_when_calling_process
    assert_raise Exception, "Define this method in a subclass of LineCheck" do
      LineCheck.new("(01) 8321234").process
    end
  end
  
  def test_returns_error_message_when_phone_number_is_invalid
    assert_equal "Phone number invalid. Valid format: (01)8321234", LineCheck.new("018321234").process
  end
  
end
