class Permission < ActiveRecord::Base

  belongs_to :resource, :polymorphic => true  
  belongs_to :role_permission, :foreign_key => :resource_id, :class_name => "Role"
  belongs_to :user_permission, :foreign_key => :resource_id, :class_name => "User"
  belongs_to :created_name, :class_name => "User" ,:foreign_key => 'created_by'
  belongs_to :updated_name, :class_name => "User" ,:foreign_key => 'updated_by'

  attr_accessible :created_by, :name,:action, :no_model_permission, :subject_class, :subject_id, :actions_list, :updated_by,:resource_id,:resource_type,:status

  serialize :actions_list, Array

  validates :action, presence: true

  def actions_list
    read_attribute(:actions_list) || []
  end

  def no_model_permission=(params)
    params = params || 0
    write_attribute(:no_model_permission, params)
  end

  def action=(params)
    params = params.to_s.downcase if params
    write_attribute(:action, params)
  end
  
  #Here stroing all actions list param values in array format and removed blank values
  def actions_list=(params)
    params = params.collect {|p| p.to_sym unless p.blank? }.compact.uniq if params
    write_attribute(:actions_list, params)
  end

  # Returns true if the actions_list has the given permission
  def has_actions_list?(perm)
    !actions_list.nil? && actions_list.include?(perm.to_sym)
  end
end
