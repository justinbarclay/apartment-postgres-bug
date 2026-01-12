class CreateBuildings < ActiveRecord::Migration[8.1]
  def change
    create_table :buildings do |t|
      t.string :name
      t.string :address

      t.timestamps
    end
  end
end
