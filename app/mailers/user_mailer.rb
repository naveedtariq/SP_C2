class UserMailer < ActionMailer::Base
  default from: "l070061@gmail.com"

  def ride_modify_email(user)                        # function for send email when ride modify
    @user = user
    mail(:to => user.email, :subject => "Ride Modify")
  end

  def ride_cancel_email(user)                        # function for send email when ride cancel
   @user = user
   mail(:to => user.email, :subject => "Ride Cancelled")
  end

  def ride_join_email(current_user,owner)            # function for send email when user want to join ride
   @user = current_user
   @owner = owner
   mail(:to => owner.email, :subject => "Ride Join")
  end

  def inbox_message_email(current_user,owner,message) # function for send email when message received
   @user = current_user
   @owner = owner
   @message = message
   mail(:to => owner.email, :subject => "Inbox Message")
  end
end
