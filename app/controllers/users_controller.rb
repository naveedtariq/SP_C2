class UsersController < ApplicationController
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
      redirect_to @user
    else
      render :action => "edit"
    end
  end
  def show
    @user = User.find(params[:id])
  end

  def inbox
    @user = User.find(params[:id])
  end

  def logged_in
#    render :action => "404error_user"
    return render :text => current_user.present?
  end
end
