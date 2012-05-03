class OauthsController < ApplicationController
  skip_before_filter :require_login # no login require

  def oauth
    cookies[:contact] = params[:contact] # assign contact cookies
    login_at(params[:provider]) # Login with respect to provider such as facebook and twitter
  end

  def callback # call back function after login through facebook
    provider = params[:provider]
    cookies[:return_to_url] = session[:return_to_url] # return url save in cookies
    begin
      if @user = login_from(provider) # login from social network save record in user
      elsif @user = create_from(provider)
        UserMailer.sign_up_email(@user).deliver
        auto_login(@user)
      end
    rescue
    end
    if @user.blank?
      return redirect_to login_path
    else
      return redirect_to facebook_login_sessions_path
    end


  end
end


