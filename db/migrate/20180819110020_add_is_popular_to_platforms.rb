class AddIsPopularToPlatforms < ActiveRecord::Migration[5.1]
  def change
    add_column :platforms, :is_popular, :boolean, default: false
  end
end
