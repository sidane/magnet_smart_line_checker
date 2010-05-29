class SmartLineCheck < LineCheck
  
  def initialize(phone_number)
    super
    @base_url = "http://www.smarttelecom.ie/line_checker.aspx"
    @on_net_url = "http://www.smarttelecom.ie/linechecker_availability.aspx"
    @off_net_url = "http://www.smarttelecom.ie/offnet_availability.aspx"
    @failure_url = "http://www.smarttelecom.ie/offnet_availability.aspx"
  end
  
    private
    
    def get_line_check_result_uri
      page = @agent.get(@base_url)
      form = page.form('aspnetForm')
      form.send("ctl00$txtPhone=", @phone_number.to_s(false))
      page = @agent.submit(form, form.buttons.first)
      return page.uri.to_s
    end

end