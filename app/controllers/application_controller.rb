class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :reject_locked!, if: :devise_controller?

  #Checks the username in the url and returns a boolean
  def isMyPage?
    myPage = false
    #Might redo this to compare two user objects
    if session[:username] == params[:username]
      myPage = true
    end
    return myPage
  end

  # Redirects on successful sign in
  def after_sign_in_path_for(resource)
    user_setup
    main_app.home_path(session[:username])
  end

  # initialization stuff for users, right after a user signs in
  # Its hacky to put this here and in the future when we aim to
  # really fix up the homepage we need to inherit from the devise
  # controller and put this directly after a user signs up.
  def user_setup
    user = current_user
    session[:username] = user.username
  end
  
  #----------------Added all the methods above-------------------
  #--------------------------------------------------------------

  # Devise permitted params
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(
      :username, 
      :email, 
      :password, 
      :password_confirmation) 
    }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(
      :username, 
      :email, 
      :password, 
      :password_confirmation,
      :current_password
      ) 
    }
  end
  
  # Auto-sign out locked users
  def reject_locked!
    if current_user && current_user.locked?
      sign_out current_user
      user_session = nil
      current_user = nil
      flash[:alert] = "Your account is locked."
      flash[:notice] = nil
      redirect_to root_url
    end
  end
  helper_method :reject_locked!
  
  # Only permits admin users
  def require_admin!
    authenticate_user!
    
    if current_user && !current_user.admin?
      redirect_to root_path
    end
  end
  helper_method :require_admin!
  
end
