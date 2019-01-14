class CreateRuleOptionOptions < ActiveRecord::Migration[5.1]
  def change
    create_table :rule_option_options do |t|
      t.references :rule_option, foreign_key: true
      t.string :value

      t.timestamps
    end
  end
end
