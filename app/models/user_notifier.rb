class UserNotifier < ActionMailer::Base
  def signup_notification(user)
    setup_email(user)
    @subject    += 'Please activate your new accounts'
    @body[:url]  = "http://www.irecall.dk/accounts/activate/#{user.activation_code}"
  end
  
  def activation(user)
    setup_email(user)
    @subject    += 'Your accounts has been activated!'
    @body[:url]  = "http://www.irecall.dk/"
  end

  def forgot_password(user)
    setup_email(user)
    @subject    += 'Request to change your password'
    @body[:url]  = "http://www.irecall.dk/accounts/reset_password/#{user.password_reset_code}"
  end

  def reset_password(user)
    setup_email(user)
    @subject    += 'Your password has been reset'
  end
  
  protected
  def setup_email(user)
    @recipients  = "#{user.email}"
    @from        = "webmaster@mednote.dk"
    @subject     = "Welcome to ReCALL"
    @sent_on     = Time.now
    @body[:user] = user
  end
end
