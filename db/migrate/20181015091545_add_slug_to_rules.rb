class AddSlugToRules < ActiveRecord::Migration[5.1]
  def change
    add_column :rules, :slug, :string
  end
end
