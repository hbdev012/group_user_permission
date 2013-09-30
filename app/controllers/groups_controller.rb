class GroupsController < ApplicationController
	before_filter :require_user!
  load_and_authorize_resource :except =>[:permissions]
  def index
  	@groups = Group.all
  end

  def permissions
    authorize! :manage, :all    
  	@groups = Group.all(:select=>"id,name")  	
  end

  def new
  	@group = Group.new
  end

  def create
  	@group = Group.new(params[:group])
	  respond_to do |format|
	    if @group.save        
	      format.html  { redirect_to(groups_path,
	                    :notice => 'Group was successfully created.') }
	    else
	      format.html  { render :action => "new" }
	    end
	  end
  end

  def edit
  	@group = Group.find(params[:id])
  end

  def update
  	@group = Group.find(params[:id])
	  respond_to do |format|
	    if @group.update_attributes(params[:group])        
	      format.html  { redirect_to(groups_path,
	                    :notice => 'Group was successfully updated.') }
	    else
	      format.html  { render :action => "edit" }
	    end
	  end
  end 

  def destroy
  	@group = Group.find(params[:id])
  	User.update_all({:group_id=>nil},["group_id = #{@group.id}"])
  	@group.destroy
  	respond_to do |format|	    
	    format.html  { redirect_to(groups_path,
	                  :notice => 'Group was successfully Deleted.') }	    
	  end
  end  
end
