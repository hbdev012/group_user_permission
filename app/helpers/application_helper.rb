module ApplicationHelper
	def active_sub_menu
		if active_tab == controller.name
			return "active"
		else
			return ""
		end	
	end

  # This method is used to check the user have access permission or not
	def allowed_to?(user,action,permission)
		user ||= current_user        
    if action.present? && permission.present? && user.present?
      can? action.to_sym, permission, :permission => { :resource_id => user.id ,:resource_type=>"User" ,:status=>1} 
    else
      false
    end
  end

  # This method is used for checking partial (permissions/permissions) form checkboxes checked/unchecked
  def check_permission(permissions,no_model_permission,action,subject_class,actions_list)
  	count = 0
  	if permissions.present?
  		permissions.each do |permission|
  			if no_model_permission==1
  				if action==permission.action && subject_class==permission.subject_class
  					count = 1
  					break
  				end  					
  			else  				
  				if action==permission.action && permission.actions_list.include?(actions_list.to_sym)
  					count = 1
  					break
  				end
  			end  		
  		end  	
  	end  	
  	if count==1
  		true
  	else
  		false
  	end
  end  
end