class OauthsController < ApplicationController
  skip_before_filter :require_login

  def oauth
    cookies[:contact] = params[:contact]
    login_at(params[:provider])
  end

  def callback

    provider = params[:provider]
    cookies[:return_to_url] = session[:return_to_url]

    begin
      if @user = login_from(provider)
      else
        @user = create_from(provider)
        auto_login(@user)

      end
    rescue
    end
    return redirect_to facebook_login_sessions_path


  end
end


