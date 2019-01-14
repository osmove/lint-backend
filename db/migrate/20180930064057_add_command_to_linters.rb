class AddCommandToLinters < ActiveRecord::Migration[5.1]
  def change
    add_column :linters, :command, :text
  end
end
