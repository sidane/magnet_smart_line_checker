require 'test/unit'
require File.dirname(__FILE__) + '/../lib/line_check'

class LineCheckTest < Test::Unit::TestCase

  def setup
    @line_check = LineCheck.new("(01) 8321234")
  end
  
  def test_raises_exception_when_calling_process
    assert_raise Exception, "Define this method in a subclass of LineCheck" do
      @line_check.process
    end
  end
  
end
