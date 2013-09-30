class User < ActiveRecord::Base
  rolify 

  #This is used for storing histories in versions table
  has_paper_trail

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,:confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,:first_name,:last_name,:group_id
  # attr_accessible :title, :body

  # Using permissions module add individual user wise permissions
  has_many :permissions,:as => :resource, :dependent => :destroy
  belongs_to :group
  belongs_to :resource, :polymorphic => true  

  after_save :update_group_permissions

  # Setup group permissions after adding group into user .
  def update_group_permissions    
    if group_id.present?
      permissions = self.permissions
      # checking if user has permissions or not
      if permissions.present? && self.changed.include?('group_id')
        group_permissions = self.group.permissions
        if group_permissions.present?          
          group_permissions.each do |p|
            if p.no_model_permission?              
              permission = self.permissions.where("no_model_permission = ? AND subject_class = ? AND action = ?",p.no_model_permission,p.subject_class,p.action).first_or_initialize     
            else
              permission = self.permissions.where("no_model_permission = ? AND subject_class IS NULL AND action = ?",p.no_model_permission,p.action).first_or_initialize     
            end            
            permission.actions_list = (permission.actions_list + p.actions_list).uniq            
            permission.status = p.status
            permission.save
          end          
        end
      else
        group_permissions = self.group.permissions
        if group_permissions.present?
          columns = (Permission.column_names) - ["id","resource_id","resource_type",'created_at','updated_at']
          # Creating all group permissions to user
          self.permissions.create( self.group.permissions.all(:select => columns.join(",") ).map(&:attributes) )
        end
      end
    end
  end

  def password_required?
    # If resetting the password
    return true if reset_password_token.present? && reset_password_period_valid?

     # If the person already has a pass, only validate if they are updating pass
    if !encrypted_password.blank?
      password.present? || password_confirmation.present?
    end
  end

  def self.who
    self.find last_change.whodunnit.to_i
    
  end

end
