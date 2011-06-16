class ApplicationController < ActionController::Base
  include AuthenticatedSystem
  before_filter :adjust_format_for_iphone

  protected

MOBILE_BROWSERS = ["android", "ipod", "opera mini", "blackberry", "palm","hiptop"]

  def adjust_format_for_iphone
    request.format = :iphone if iphone_user_agent?
  end

  def iphone_request?
    return (request.subdomains.first == "iphone" || params[:format] == "iphone")
  end

  def iphone_user_agent?
    if request.env["HTTP_USER_AGENT"] # && request.env["HTTP_USER_AGENT"][/(Mobile\/.+Safari)/]
		agent = request.env["HTTP_USER_AGENT"].downcase
		MOBILE_BROWSERS.each do |m|
			return true if agent.match(m)
    end
    return false
	end
  end

#  def iphone_user_agent?
#    request.env["HTTP_USER_AGENT"] && request.env["HTTP_USER_AGENT"][/(Mobile\/.+Safari)/]
#  end
end
