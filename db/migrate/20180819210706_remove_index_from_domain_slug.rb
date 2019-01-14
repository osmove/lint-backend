class RemoveIndexFromDomainSlug < ActiveRecord::Migration[5.1]
  def change
    remove_index :repositories, :domain_slug
    add_index :repositories, :domain_slug
  end
end
