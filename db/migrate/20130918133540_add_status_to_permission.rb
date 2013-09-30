class AddStatusToPermission < ActiveRecord::Migration
  def change
  	add_column :permissions ,:status ,:boolean ,:default=>true
  end
end
