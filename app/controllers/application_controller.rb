class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :save_request
  def save_request
#    RequestLogger.create!(:params => request.inspect, :user_agent => request.user_agent, :request_ip => request.remote_ip)
  end
  def not_authenticated
    redirect_to login_url, :alert => "First login to access this page."
  end
  def require_login1
    puts "^"*80
    puts current_user.inspect
    puts "^"*80
    if current_user.blank?
      session[:return_to_url] = request.url 
      return redirect_to "#{login_url}?badaraaaaa", :alert => "First login to access this page."
    end
  end
end
