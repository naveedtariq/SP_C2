class SessionsController < ApplicationController
  #  layout "session"
  def new
    #return render :action => "404error_user", :layout => false
    # @facebook_api_key = FB_CONFIG['api_key']

  end

  def create
    user = login(params[:email], params[:password], params[:remember_me])
    user.last_login = Time.now
    user.save(:validate => false)
    if user
      redirect_back_or_to dashboard_path
      #      end
    else
      flash.now.alert = "Email or password was invalid."
      render "new"
    end
  end
  def facebook_login
    
    @oauth = Koala::Facebook::OAuth.new(APP_CONFIG["api_id"] , APP_CONFIG["secret_key"], facebook_callback_sessions_url)
    return redirect_to   @oauth.url_for_oauth_code
  end
  def facebook_callback
    @oauth = Koala::Facebook::OAuth.new(APP_CONFIG["api_id"] , APP_CONFIG["secret_key"], facebook_callback_sessions_url)
    oauth_code = @oauth.get_access_token(params[:code])
    @graph = Koala::Facebook::GraphAPI.new(oauth_code)
    authentication = current_user.authentications.first
    fb_id = authentication.uid
    #    mutual_friends = @graph.get_connections(fb_id, "mutualfriends/#{1038043578}")
    #    user_info = @graph.get_object(fb_id)
    photo = @graph.get_picture(fb_id)
    #    current_user.update_attributes(:photo_url => photo)
    #    current_user.save
    friends = @graph.get_connections(fb_id, "friends")
    info = @graph.get_object(fb_id)
    current_user.dob = Date.strptime(info["birthday"], "%m/%d/%Y") if info["birthday"].present?
    current_user.city = (info["location"]["name"] rescue "")
    current_user.town = (info["hometown"]["name"] rescue "")
    education = []
    if info["education"].present? && info["education"].is_a?(Array)
      info["education"].each do |school|
        education << (school["school"]["name"] rescue "")
      end
    end
    current_user.school = education.join(", ")
    working_history = []
    if info["work"].present? && info["work"].is_a?(Array)
      info["work"].each do |work|
        working_history << (work["employer"]["name"] rescue "")
      end
    end
    current_user.work = working_history.join(", ")
    current_user.photo_url = photo
    current_user.oauth_code = oauth_code
    current_user.number_of_friends = friends.count
    current_user.last_login = Time.now
    current_user.save(:validate => false)
    friend_list = []
    friends.each do |friend|
      friend_list << "#{friend["id"]}:#{friend["name"]}"
    end
    authentication.friend_list = friend_list.join(",")
    authentication.save!
    session[:return_to_url] = cookies[:return_to_url]
    redirect_back_or_to dashboard_path

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
