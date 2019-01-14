class AddColumnFixToRule < ActiveRecord::Migration[5.1]
  def change
    add_column :rules, :fix, :boolean, default: false
  end
end
