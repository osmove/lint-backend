class AddColumnToPolicies < ActiveRecord::Migration[5.1]
  def change
    add_column :policies, :autofix, :boolean, default: false
  end
end
