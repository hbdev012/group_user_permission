class Ability
  include CanCan::Ability

  def initialize(user)

    # Define abilities for the passed in user here. For example:
    
    user ||= User.new # guest user (not logged in)
    permissions = user.permissions.all(:conditions=>['permissions.status = 1'])
    if permissions.present?      
      permissions.each do |permission|                  
        if permission.no_model_permission? && permission.action.present? && permission.subject_class.present?
          can permission.action.to_sym , permission.subject_class.constantize
        else
          if permission.action.present? && permission.actions_list.present?
            permission.actions_list.each do |perm|
              can permission.action.to_sym , perm.to_sym
            end
          end
        end        
      end
    else
      can :access, :welcome
    end

    #can :read, Currency, :permission => { :resource_id => current_user.id ,:resource_type=>"User" }
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user 
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. 
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # A block can be passed just like "can", however if the logic is complex it is recommended
    # to use the "can" method.
    #
    #   cannot :read, Product do |product|
    #     product.invisible?
    #   end    
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
