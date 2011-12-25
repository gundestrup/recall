# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.
	require 'authenticated_system'       
class ApplicationController < ActionController::Base
    
    include Sitealizer
    include AuthenticatedSystem
    before_filter :use_sitealizer
    $age = Date.today
    $update = "2011-02-13"
  # Pick a unique cookie name to distinguish our session data from others'
  #session :session_key => '_ReCALL_session_id'
  #include AuthenticatedSystem
  #include ExceptionNotifiable
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery #

  layout  'application'  
  before_filter :set_locale

  def set_locale
    locale = params[:locale] || 'da'
    I18n.locale = locale
    I18n.load_path += Dir[ File.join(RAILS_ROOT, 'lib', 'locale', '*.{rb,yml}') ]
  end

  private

  def mobile_device?
      request.user_agent =~ /Mobile|webOS/
  end

    protected

    def log_error(exception)
      super(exception)

      begin
        ErrorMailer.deliver_snapshot(
          exception,
          clean_backtrace(exception),
          session.instance_variable_get("@data"),
          params,
          request.env)
      rescue => e
        logger.error(e)
      end
    end
  
end
