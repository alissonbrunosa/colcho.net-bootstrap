class AddColumnSlugToRoom < ActiveRecord::Migration
  def change
    add_column :rooms, :slug, :string
    add_index :rooms, :slug
  end
end
