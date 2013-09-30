class UsersController < ApplicationController
  before_filter :require_user!
  load_and_authorize_resource :except =>[:permissions]
  def index
  	@users = User.paginate(:page => params[:page], :per_page => Global::PERPAGE)
  end

  def permissions
    authorize! :manage, :all
    @users = User.all(:select=>"concat(first_name,' ',last_name) as name,id")
  end

  def new
  	@user = User.new
    @groups = Group.all
    @action = users_path(@user)
  end

  def create
  	@user = User.new(params[:user])
  	if @user.save
		flash[:notice] = "User has been registered"
		redirect_to users_path
  	else	
  		flash[:error] = "User is not registered"
  		render :action => "new"
  	end
  end

  def edit
  	@user = User.find(params[:id])
    @groups = Group.all
    @action = user_path(@user)
  end

  def update
    @user = User.find(params[:id])
    @groups = Group.all
    if @user.update_attributes(params[:user])
      flash[:notice] = "User has been updated"
      redirect_to users_path
    else  
      flash[:error] = "User is not updated"
      render :action => "edit"
    end
  end

  def show
  	@user = User.find(params[:id])  		
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

end
