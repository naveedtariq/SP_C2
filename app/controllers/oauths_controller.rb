class OauthsController < ApplicationController
  skip_before_filter :require_login

  def oauth
    login_at(params[:provider])
  end
  def callback
    provider = params[:provider]
    if @user = login_from(provider)
    else
      begin
        @user = create_from(provider)
        reset_session
        auto_login(@user)

      rescue
      end
    end
    return redirect_to facebook_login_sessions_path



  end
end


