class AddPictureToRooms < ActiveRecord::Migration
  def change
    add_column :rooms, :picture, :string
    add_index :rooms, :picture
  end
end
