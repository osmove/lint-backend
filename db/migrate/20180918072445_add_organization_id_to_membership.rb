class AddOrganizationIdToMembership < ActiveRecord::Migration[5.1]
  def change
    add_column :memberships, :organization_id, :integer
  end
end
