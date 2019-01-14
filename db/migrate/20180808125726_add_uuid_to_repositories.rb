class AddUuidToRepositories < ActiveRecord::Migration[5.1]
  def change
    add_column :repositories, :uuid, :string
    add_column :repositories, :secret_key, :string

    add_column :documents, :uuid, :string
    add_column :documents, :secret_key, :string
  end
end
