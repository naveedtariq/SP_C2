class UsersController < ApplicationController
  before_filter :require_login, :only => [:inbox, :edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
#      render :action => "404error_user"
      @user.last_login = Time.now
      login(params[:user][:email], params[:user][:password])
      redirect_back_or_to dashboard_path
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update

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
    @graph = Koala::Facebook::GraphAPI.new(current_user.oauth_code) if (current_user.present? && current_user.oauth_code.present?)
    @user = User.find(params[:id])
    @ride_participants = @user.ride_participants.current_rides.active_rides.not_cancelled_or_abandoned.role_wise
    @past_rides = @user.ride_participants.past_rides.active_rides.confirmed_or_owner_participants.paginate(:page => params[:past_rides_page], :per_page => PAST_RIDES_PER_PAGE)
  end

  def inbox
    @user = current_user
  end


  def update_phone

  end

  def logged_in
#    render :action => "404error_user"
    return render :text => current_user.present?
  end
end
