class UsersController < ApplicationController
   def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
#      render :action => "404error_user"
      login(params[:user][:email], params[:user][:password])
      redirect_to dashboard_path
    else
      render :new
    end
  end
  def logged_in
#    render :action => "404error_user"
    return render :text => current_user.present?
  end
end
