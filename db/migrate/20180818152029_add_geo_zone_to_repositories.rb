class AddGeoZoneToRepositories < ActiveRecord::Migration[5.1]
  def change
    add_column :repositories, :geo_zone, :string
  end
end
