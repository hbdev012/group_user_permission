class PermissionsController < ApplicationController
	before_filter :require_user!
		
  def index 
    @permissions 	= Permission.all
  end

  def new
    @permission = Permission.new
    @groups = Group.all
  end

  # Gettgin permissions based on resource type and calling partial (permissions/permissions) page.
  def get_permissions
  	@permissions = Permission.where("resource_id = #{params[:resource_id]} AND resource_type = '#{params[:resource_type]}' AND status = 1")  	
  	respond_to do |format|       	
      format.js
    end
  end

  # Here creating permissions (bulk creation) based on resource type (User/Group)
  def bulk_create  	
  	authorize! :manage, :all #checking authorization who are having all permissions

  	if params["permissions"].present?
  		resource_id = params["permissions"]["resource_id"]
  		resource_type = params["permissions"]["resource_type"]
  		if resource_id.present? && resource_type.present?
	  		#Checking model permissions and creating model permissions 
	  		if params["permissions"]["1"].present? 
	  			actions = params["permissions"]["1"]
	  			actions.each do |key,value|
	  				value.each do |sub|
	  					sub_values = sub.split('_')
	  					permission = Permission.where(:resource_id => resource_id, :resource_type => resource_type,:action=>key,:no_model_permission=>1,:subject_class=>sub_values[0]).first_or_initialize		  			
		  				permission[:status] = sub_values[1]
		  				permission[:actions_list] = []
		  				permission[:created_by] = current_user.id if current_user
		  				permission[:updated_by] = current_user.id if current_user	  				
		  				permission.save
	  				end
	  			end  			
	  		end
	  		#Checking controller permissions and creating controller permissions
	  		if params["permissions"]["0"].present? 
	  			actions = params["permissions"]["0"]
	  			actions.each do |key,value|
	  				permission = Permission.where(:resource_id => resource_id, :resource_type => resource_type,:action=>key,:no_model_permission=>false).first_or_initialize	  							
	  				permission[:actions_list] = value.reject(&:empty?).map{|x| x.to_sym }
	  				permission[:created_by] = current_user.id if current_user
	  				permission[:updated_by] = current_user.id if current_user
	  				permission.save
	  			end  			
	  		end
	  		flash[:notice] = "Groups permissions successfully saved"
	  		redirect_to_back_or_default
	  	else
	  		flash[:error] = "permissions not saved , Please fill required fields"
  			redirect_to_back_or_default
	  	end
  	else
  		flash[:error] = "permissions not saved"
  		redirect_to_back_or_default
  	end
  end

  def edit
  end

  private

  def find_resource  	
  end
end
