class Group < ActiveRecord::Base
  attr_accessible :created_by, :name, :updated_by
  has_many :users
  has_many :permissions,:as => :resource, :dependent => :destroy
  
  def to_s
  	name
  end
end
