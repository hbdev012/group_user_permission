class ApplicationController < ActionController::Base
  protect_from_forgery
  rescue_from CanCan::AccessDenied do |exception|
  	flash[:error] = exception.message
  	redirect_to_back_or_default
    #redirect_to main_app.root_url#, :alert => exception.message
  end

  # This action is used to check the user login or not . if not here storing call back url and redirect to login path
  def require_user!
  	authenticate_user!
	  if current_user
	  	@user = current_user
	  else	  	
	    store_location
	    redirect_to login_path
	    return false
	  end
	end

	# Store back url in session variable
  def store_location
	  session[:return_to] = if request.get?
	    request.url
	  else
	    request.env['HTTP_REFERER']
	  end
	end

	# Here getting back url either redirect to session url or back or default
	def redirect_back_or_default(default = root_url)
  	redirect_to(session.delete(:return_to) || request.env['HTTP_REFERER'] || default)
	end
	alias_method :redirect_to_back_or_default, :redirect_back_or_default

end
