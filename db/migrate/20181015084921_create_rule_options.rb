class CreateRuleOptions < ActiveRecord::Migration[5.1]
  def change
    create_table :rule_options do |t|
      t.string :name
      t.string :slug
      t.text :value
      t.string :value_type
      t.string :units
      t.string :condition_value
      t.references :rule, foreign_key: true

      t.timestamps
    end
  end
end
