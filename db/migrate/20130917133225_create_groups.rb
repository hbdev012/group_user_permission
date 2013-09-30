class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name
      t.integer :created_by
      t.integer :updated_by

      t.timestamps
    end
    add_index(:groups, :name)   
    
    add_column :users ,:group_id ,:integer if User.table_exists?
    
  end
end
