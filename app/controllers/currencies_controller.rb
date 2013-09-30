class CurrenciesController < ApplicationController
	before_filter :authenticate_user!
	load_and_authorize_resource	 
	#The below commented example of Authorizing Controller Action in Nested Resources
	# load_and_authorize_resource :post
 #  load_and_authorize_resource :through => :post

 #  skip_authorize_resource :only => :show  
 #  skip_authorize_resource :post, :only => :show

  def index
  end

  def new
    @currency = Currency.new
  end

  def create
    render :text => params and return false
  end

  def edit
  end
end
