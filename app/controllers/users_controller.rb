class UsersController < ApplicationController
   def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    @user.last_login = Time.now
    if @user.save
#      render :action => "404error_user"
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
    if @user.update_attributes(params[:user])
      redirect_to dashboard_path
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
