class AddOptionsToRules < ActiveRecord::Migration[5.1]
  def change
    add_column :rules, :options, :string
  end
end
