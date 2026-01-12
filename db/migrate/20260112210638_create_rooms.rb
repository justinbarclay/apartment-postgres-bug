class CreateRooms < ActiveRecord::Migration[8.1]
  def change
    create_table :rooms do |t|
      t.references :building, null: false, foreign_key: true
      t.string :room_number
      t.integer :occupancy_size

      t.timestamps
    end
  end
end
