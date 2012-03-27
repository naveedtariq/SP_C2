class OauthsController < ApplicationController
  skip_before_filter :require_login

  def oauth
    login_at(params[:provider])
  end
  def callback
    provider = params[:provider]
    if @user = login_from(provider)
      #      fb_id = @user.authentications.first.uid
      #      @oauth = Koala::Facebook::OAuth.new("365401603490972", params[:code], "http://localhost:3000/oauth/access_token")
      #      return redirect_to @oauth.url_for_access_token(params[:code])
      #
      #
      #      @graph = Koala::Facebook::API.new("AAAFMVLDGxJwBAB4UZBnR43j6Od2ZBNkhsvt7VU1DhP5zkxUsNaRLQ658zM6BBLZAyEgsZAkmf8Gx97uZChhuHflqmxa44oY38aY3GsvnwApyylSRMnL6r")
      #      friends=@graph.get_connections(fb_id, "friends")
      #      info=@graph.get_object(fb_id)
      #      return render :text => friends.inspect
    else
      begin
        @user = create_from(provider)
        #        @user.activate!
        reset_session
        auto_login(@user)
        return redirect_to facebook_login_sessions_path

      rescue
      end
    end
    return redirect_to root_path


  end
end


