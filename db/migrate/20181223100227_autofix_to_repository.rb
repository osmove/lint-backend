class AutofixToRepository < ActiveRecord::Migration[5.1]
  def change
    add_column :repositories, :has_autofix, :boolean
  end
end
