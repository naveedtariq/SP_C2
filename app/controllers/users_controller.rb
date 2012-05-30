class UsersController < ApplicationController
  before_filter :require_login, :only => [:inbox, :edit, :update]               # require login for these functions

  def new
    @user = User.new                                                            # create new instance of user
  end

  def create                                                                    # create user
    @user = User.new(params[:user])
    if @user.save
#      render :action => "404error_user"
      UserMailer.sign_up_email(@user).deliver
      @user.last_login = Time.zone.now
      login(params[:user][:email], params[:user][:password])                    # login user
      redirect_back_or_to dashboard_path
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update                                                                    # update user information

    @user = User.find(params[:id])
    @user.attributes = params[:user]
    if @user.save(:validate => false)
      if (params[:contact] == "phone")
        redirect_to dashboard_path
      else
        redirect_to @user
      end
    else
      render :action => "edit"
    end
  end

  def show
    @graph = Koala::Facebook::GraphAPI.new(current_user.oauth_code) if (current_user.present? && current_user.oauth_code.present?)          # graph API use here
    @user = User.find(params[:id])
    @ride_participants = @user.ride_participants.current_rides(SpClock.time).active_rides.not_cancelled_or_abandoned.role_wise      # user current active rides
    @past_rides = @user.ride_participants.past_rides(SpClock.time).active_rides.confirmed_or_owner_participants.paginate(:page => params[:past_rides_page], :per_page => PAST_RIDES_PER_PAGE)    # past rides in which user has confirmed participants and owner
  end

  def inbox
    @user = current_user
    @messages = current_user.owned_messages.rev_ordered
  end
  
  def feedback
    @past_rides = current_user.ride_participants.past_rides(SpClock.time).active_rides.confirmed_or_owner_participants #.paginate(:page => params[:past_rides_page], :per_page => PAST_RIDES_PER_PAGE)    # Retrieve the current user past rides those rides which are confirmed or current user is owner of ride
  end


  def update_phone

  end

  def logged_in                                                                 # login function
#    render :action => "404error_user"
    return render :text => current_user.present?
  end
end
