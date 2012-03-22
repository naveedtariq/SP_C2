class OauthsController < ApplicationController
skip_before_filter :require_login

  def oauth
	 login_at(params[:provider])
  end

  def callback
	provider = params[:provider]
  
      redirect_to root_path, :notice => "Logged in from"

   
  end
end
