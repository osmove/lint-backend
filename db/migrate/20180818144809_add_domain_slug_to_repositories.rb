class AddDomainSlugToRepositories < ActiveRecord::Migration[5.1]
  def change
    add_column :repositories, :domain_slug, :string
    add_index :repositories, :domain_slug, unique: true
  end
end
