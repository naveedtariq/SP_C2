class SessionsController < ApplicationController
  #  layout "session"
  before_filter :require_not_loggedin, :only => [:new, :create]                 # no login require for login page
  #before_filter :require_login, :only => [:facebook_callback]                 # no login require for login page
  def new
  end

  def create
    user = login(params[:email], params[:password], params[:remember_me])       # build a session of a user here
    if user
    user.last_login = Time.zone.now                                                # time of login save
      user.save(:validate => false)
      redirect_back_or_to dashboard_path
      #      end
    else
      flash.now.alert = "Email or password was invalid."
      render "new"
    end
  end

  def facebook_login                                                            # Login through from facebook
    @oauth = Koala::Facebook::OAuth.new(APP_CONFIG["facebook_app_id"], APP_CONFIG["facebook_app_key"], facebook_callback_sessions_url)
    return redirect_to @oauth.url_for_oauth_code
  end

  def facebook_callback                                                         # callback function for facebook
    return redirect_to login_path if current_user.blank?
    @oauth = Koala::Facebook::OAuth.new(APP_CONFIG["facebook_app_id"], APP_CONFIG["facebook_app_key"], facebook_callback_sessions_url)
    oauth_code = @oauth.get_access_token(params[:code])                         # get access token of current user login through facebook
    @graph = Koala::Facebook::GraphAPI.new(oauth_code)                          # use graph api here
    authentication = current_user.authentications.first                         # get user which login through facebbok
    fb_id = authentication.uid                                                  # get user's facebook profile id
    photo = @graph.get_picture(fb_id)                                           # get the user's picture from facebook
    friends = @graph.get_connections(fb_id, "friends")                          # get the user's friend frm facebook

    info = @graph.get_object(fb_id)                                             # get the user's facebook profile information

    current_user.dob = Date.strptime(info["birthday"], "%m/%d/%Y") if info["birthday"].present?       # get user's date of birth from facebook
    (current_user.city = (info["location"]["name"]) rescue "") if current_user.city.blank?            # get user's city name form facebook

    (current_user.town = ((info["hometown"]["name"]) rescue "")) if current_user.town.blank?          # get user's hometown from facebook
    education = []
    if info["education"].present? && info["education"].is_a?(Array)                                   # get education history of user from facebook
      info["education"].each do |school|
        education << (school["school"]["name"] rescue "")                                             # get school name of user from his facebook
      end
    end
    current_user.school = education.join(", ") if current_user.school.blank?
    working_history = []
    if info["work"].present? && info["work"].is_a?(Array)
      info["work"].each do |work|                                                                     # get work history from user from facebook
        working_history << ((work["employer"]["name"]) rescue "")
      end
    end
    current_user.work = working_history.join(", ") if current_user.work.blank?                        # all fetch records save to the user table
    current_user.photo_url = photo
    current_user.oauth_code = oauth_code
    current_user.number_of_friends = friends.count
    current_user.last_login = Time.zone.now
    current_user.save(:validate => false)
    friend_list = []
    friends.each do |friend|                                                                          # fetch user's friend of facebook
      friend_list << "#{friend["id"]}:#{friend["name"]}"
    end
    authentication.friend_list = friend_list.join(",")
    authentication.save!
    session[:return_to_url] = cookies[:return_to_url]
    redirect_back_or_to dashboard_path

  end

  def destroy
    cookies[:contact] = nil                                                                          # session destroy and cookies clear
    logout
    redirect_to root_path
  end

  def temp_redirect                                                                                  # temporary session
    session[:user_id] = User.first && User.first.id
    return redirect_to session[:return_to_url]
  end
  def require_not_loggedin                                                                           # no login required function redirection to root path if user present
    return redirect_back_or_to dashboard_path if current_user.present?
  end
end
