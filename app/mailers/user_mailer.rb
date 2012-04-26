class UserMailer < ActionMailer::Base
  default from: "spnotification00@gmail.com"

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

  def sign_up_email(user)                               # function to send email when user sign-up to the site
   @user = user
   mail(:to => user.email, :subject => "Thanks For Signup")
  end

  def post_ride_email(user)                             # function to send email when user post a ride
    @user = user
    mail(:to => user.email, :subject => "Post A Ride")
  end

  def ride_accepted_email(current_user,ride)            # function to send email when owner of ride accept his request to join ride
    @user = current_user
    @ride = ride
    @req_user = User.find(@ride.user_id)
    mail(:to => @req_user.email, :subject => "Ride Accepted")
  end

  def feedback_email(current_user,ride,feedback)        # function to send email when current user give the feedback
    @user = current_user
    @ride = ride
    @feedback = feedback
    @req_ride = Ride.find(ride.id)
    mail(:to => @req_ride.owner.email, :subject => "Feedback Get")
  end

  def owner_change_email(ride)
    @ride = ride
    rider = RideParticipant.find(ride)
    req_ride = rider.ride
    #participants = User.find(:conditions => ["id in (?)",req_ride.ride_participants.confirmed_or_owner_participants.pluck(:user_id)]).pluck(:email)
    mail(:to => ['usman@devsinc.com', 'usman.asif@hotmail.com'], :subject => "New Owner")
  end
end
