class AddSlugToPlatforms < ActiveRecord::Migration[5.1]
  def change
    add_column :platforms, :slug, :string
    remove_column :platforms, :image
    add_column :platforms, :image, :text
  end
end
