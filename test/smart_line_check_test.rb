require 'test/unit'
require 'rubygems'
require 'mocha'
require File.dirname(__FILE__) + '/../lib/line_check'

class SmartLineCheckTest < Test::Unit::TestCase

  def setup
    @line_check = SmartLineCheck.new("(01) 8321234")
  end
  
  def test_on_net_line_check
    @line_check.expects(:get_line_check_result_uri).returns(@line_check.on_net_url)
    assert_equal "Yes", @line_check.process
  end
  
  def test_off_net_line_check
    @line_check.expects(:get_line_check_result_uri).returns(@line_check.off_net_url)
    assert_equal "No", @line_check.process
  end
  
  def test_failure_line_check
    @line_check.expects(:get_line_check_result_uri).returns(@line_check.failure_url)
    assert_equal "No", @line_check.process
  end
  
end
