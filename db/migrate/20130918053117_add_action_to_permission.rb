class AddActionToPermission < ActiveRecord::Migration
  def change
  	add_column :permissions ,:action ,:string
  end
end
