class WelcomeController < ApplicationController
	before_filter :require_user!
	#authorize_resource :class => false
  def index  	
  end

  def report
  	authorize! :read, :welcome_report
  	render :text=>params and return false
  end

  def mis_report
    authorize! :read, :welcome_mis_report
    render :text=>params and return false
  end
end
