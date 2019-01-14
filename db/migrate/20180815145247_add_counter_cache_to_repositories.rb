class AddCounterCacheToRepositories < ActiveRecord::Migration[5.1]
  def change
    add_column :repositories, :counter_cache, :integer
    add_column :users, :counter_cache, :integer
  end
end
