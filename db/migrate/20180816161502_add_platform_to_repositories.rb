class AddPlatformToRepositories < ActiveRecord::Migration[5.1]
  def change
    add_column :repositories, :platform, :string
    add_reference :repositories, :language, foreign_key: true
    add_reference :repositories, :framework, foreign_key: true
  end
end
