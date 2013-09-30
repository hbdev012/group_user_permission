class CreatePermissions < ActiveRecord::Migration
  def change
    create_table :permissions do |t|
      t.string :name
      t.references :resource, :polymorphic => true      
      t.boolean :no_model_permission,:default=>false
      t.string :subject_class
      t.integer :subject_id
      t.text :actions_list
      t.integer :created_by
      t.integer :updated_by

      t.timestamps
    end
    add_index(:permissions, :name)
    add_index(:permissions, [ :name, :resource_type, :resource_id ])
    add_index :permissions, :resource_id
  end
end
