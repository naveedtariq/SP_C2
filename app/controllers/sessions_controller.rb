class SessionsController < ApplicationController
#  layout "session"
  def new
    #return render :action => "404error_user", :layout => false
    @facebook_api_key = FB_CONFIG['api_key']
  end

  def create
    user = login(params[:email], params[:password], params[:remember_me])
    if user
#      if params[:child_toolbar] == "false"
#        return render :action => "created"
#      else
#          render :action => "404error_user"
        redirect_back_or_to root_url, :notice => "Logged in!"
#      end
    else
      flash.now.alert = "Email or password was invalid."
      render "new"
    end
  end

  def destroy
    logout
    redirect_to login_path, :notice => "Logged out!"
  end
  def temp_redirect
    session[:user_id] = User.first && User.first.id
    return redirect_to session[:return_to_url]
  end
end
