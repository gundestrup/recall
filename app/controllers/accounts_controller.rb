class AccountsController < ApplicationController

  # If you want "remember me" functionality, add this before_filter to Application Controller
  before_filter :login_from_cookie
  before_filter :login_required, :except => [:forgot_password, :reset_password, :change_password, :login, :signup]

  #flash[:error]
  #flash[:notice]
  #:notice, :warning and :error
  
  # say something nice, you goof!  something sweet.

  def account

  end

  def edit
      if current_user.id == params[:id] or current_user.admin?
        @user = User.find(params[:id])
      else
        flash[:notice] = 'Sorry no editin other peoples accounts!'
        redirect_to :action => 'account'
      end
      
  end

  def update
        @user = User.find(self.current_user.id)
        if @user.update_attributes(params[:user])
            flash[:notice] = 'User was successfully updated.'
            redirect_to :action => 'account'
        else
            flash[:error] = 'User update error, try again.'
            render :action => 'edit'
        end
  end	


 def login
    return unless request.post?
    self.current_user = User.authenticate(params[:login], params[:password])
    if logged_in?
      if params[:remember_me] == "1"
        self.current_user.remember_me
        cookies[:auth_token] = { :value => self.current_user.remember_token , :expires => self.current_user.remember_token_expires_at }
      end
          redirect_back_or_default(:controller => '/accounts', :action => 'account')
          flash[:notice] = "Logged in successfully"
          logged = User.find(:first,
                          :conditions => ['id = ?', current_user.id])
                  logged.last_visit = Time.now
                  logged.save
    else
        flash[:error] = "Login error, please try again"        
    end

  end

  def signup    
      @user = User.new(params[:user])
      
        return unless request.post?
          @user.save!
          self.current_user = @user
          redirect_back_or_default(:controller => '/info')
          flash[:notice] = "Thanks for signing up!"
        rescue ActiveRecord::RecordInvalid
          render :action => 'signup'
      #end
  end

  def activate
    if params[:activation_code]
      @user = User.find_by_activation_code(params[:activation_code])
      if @user and @user.activate
        self.current_user = @user
        redirect_back_or_default(:controller => '/info')
        flash[:notice] = "Your accounts has been activated."
      else
        flash[:error] = "Unable to activate the accounts.  Did you provide the correct information?"
      end
    elsif params[:id]
      @user = User.find_by_activation_code(params[:id])
      if @user and @user.activate
        self.current_user = @user
        redirect_back_or_default(:controll => '/info')
        flash[:notice] = "Your accounts has been activated"
      end
    else
      flash.clear
    end
  end

  def logout
    self.current_user.forget_me if logged_in?
    cookies.delete :auth_token
    reset_session
    flash[:notice] = "You have been logged out."
    redirect_back_or_default(:controller => '/info')
  end

    def forgot_password
    return unless request.post?
        if @user = User.find_by_email(params[:email])
          @user.forgot_password
          @user.save
          redirect_back_or_default(:controller => 'info')
          flash[:notice] = "A password reset link has been sent to your email address"
        else
          flash[:notice] = "Could not find a user with that email address"
        end
    end

  def reset_password
    @user = User.find_by_password_reset_code(params[:id])
    raise if @user.nil?
    return if @user unless params[:password]
      if (params[:password] == params[:password_confirmation])
        self.current_user = @user #for the next two lines to work
        current_user.password_confirmation = params[:password_confirmation]
        current_user.password = params[:password]
        @user.reset_password
        flash[:notice] = current_user.save ? "Password reset" : "Password not reset"
      else
        flash[:notice] = "Password mismatch"
      end
    redirect_back_or_default(:controller => '/info')
  rescue
    logger.error "Invalid Reset Code entered"
    flash[:notice] = "Sorry - That is an invalid password reset code. Please check your code and try again. (Perhaps your email client inserted a carriage return?"
    redirect_back_or_default(:controller => '/info')
  end

  def change_password
      return unless request.post?
      @user = self.current_user
      @user.update_attributes(params[:user])
      @user.reset_password
      @user.save!
      flash[:notice] = "Password has been successfully changed."
      redirect_to(:controller => '/info')

      rescue ActiveRecord::RecordInvalid
      render :action => 'change_password'
  end
 

end
