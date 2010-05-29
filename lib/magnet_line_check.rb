class MagnetLineCheck < LineCheck
  
  # Positive on_net phone number = (01)8323055
  
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