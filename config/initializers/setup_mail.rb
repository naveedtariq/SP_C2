ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 25,
  :domain               => "www.gmail.com",
  :user_name            => "spnotification00",                             
  :password             => "helloworld123",
  :authentication       => "plain",
  :enable_starttls_auto => true
}

ActionMailer::Base.default_url_options[:host] = "localhost:3000"