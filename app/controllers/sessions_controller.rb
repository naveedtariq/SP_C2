class SessionsController < ApplicationController
  #  layout "session"
  def new
    #return render :action => "404error_user", :layout => false
    # @facebook_api_key = FB_CONFIG['api_key']
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
  def facebook_login
    @oauth = Koala::Facebook::OAuth.new(FACEBOOK_KEY , FACEBOOK_SECRET, facebook_callback_sessions_url)
    return redirect_to   @oauth.url_for_oauth_code
  end
  def facebook_callback
    @oauth = Koala::Facebook::OAuth.new(FACEBOOK_KEY , FACEBOOK_SECRET, facebook_callback_sessions_url)
    @graph = Koala::Facebook::GraphAPI.new(@oauth.get_access_token(params[:code]))
    fb_id = current_user.authentications.first.uid
    mutual_friends = @graph.get_connections(fb_id, "mutualfriends/#{1038043578}")
    user_info = @graph.get_object(fb_id)
    photo = @graph.get_picture(fb_id)
    current_user.update_attributes(:photo_url => photo)
    current_user.save
#    friends=@graph.get_connections(fb_id, "friends")
#    info=@graph.get_object(fb_id)
   return render :text => current_user.photo_url.inspect
   #redirect_to root_url

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
