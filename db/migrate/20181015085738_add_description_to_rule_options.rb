class AddDescriptionToRuleOptions < ActiveRecord::Migration[5.1]
  def change
    add_column :rule_options, :description, :text
  end
end
