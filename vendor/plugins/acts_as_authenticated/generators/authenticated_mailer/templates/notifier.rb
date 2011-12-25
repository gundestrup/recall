class <%= class_name %>Notifier < ActionMailer::Base
  def signup_notification(<%= file_name %>)
    setup_email(<%= file_name %>)
    @subject    += 'Please activate your new accounts'
    @body[:url]  = "http://YOURSITE/accounts/activate/#{<%= file_name %>.activation_code}"
  end
  
  def activation(<%= file_name %>)
    setup_email(<%= file_name %>)
    @subject    += 'Your accounts has been activated!'
    @body[:url]  = "http://YOURSITE/"
  end
  
  protected
  def setup_email(<%= file_name %>)
    @recipients  = "#{<%= file_name %>.email}"
    @from        = "ADMINEMAIL"
    @subject     = "[YOURSITE] "
    @sent_on     = Time.now
    @body[:<%= file_name %>] = <%= file_name %>
  end
end
