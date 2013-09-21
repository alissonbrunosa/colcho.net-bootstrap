class AddPhotoToUsers < ActiveRecord::Migration
  def change
    add_column :users, :photo, :string
    add_index :users, :photo
  end
end
