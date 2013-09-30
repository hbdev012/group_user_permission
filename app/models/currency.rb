class Currency < ActiveRecord::Base
	resourcify
  attr_accessible :code, :created_by, :name, :updated_by
  belongs_to :created_name, :class_name => "User" ,:foreign_key => 'created_by'
  belongs_to :updated_name, :class_name => "User" ,:foreign_key => 'updated_by'
end
