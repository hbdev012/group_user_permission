class CreateCurrencies < ActiveRecord::Migration
  def change
    create_table :currencies do |t|
      t.string :name
      t.string :code
      t.integer :created_by
      t.integer :updated_by
      t.timestamps
    end
  end
end
