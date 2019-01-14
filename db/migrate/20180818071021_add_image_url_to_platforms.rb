class AddImageUrlToPlatforms < ActiveRecord::Migration[5.1]
  def change
    add_column :languages, :image_url, :string
    add_column :frameworks, :image_url, :string
    add_column :platforms, :image_url, :string

    add_column :languages, :visible, :boolean, :default => true
    add_column :frameworks, :visible, :boolean, :default => true
    add_column :platforms, :visible, :boolean, :default => true
    
  end
end
