class CreateRuleChecks < ActiveRecord::Migration[5.1]
  def change
    create_table :rule_checks do |t|
      t.string :name
      t.boolean :passed
      t.references :language, foreign_key: true
      t.references :rule, foreign_key: true
      t.references :policy_check, foreign_key: true
      t.references :repository, foreign_key: true
      t.references :user, foreign_key: true
      t.references :contributor, foreign_key: true
      t.references :push, foreign_key: true
      t.references :device, foreign_key: true

      t.timestamps
    end
  end
end
