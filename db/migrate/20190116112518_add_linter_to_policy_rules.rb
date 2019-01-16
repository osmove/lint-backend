class AddLinterToPolicyRules < ActiveRecord::Migration[5.1]
  def change
    add_reference :policy_rules, :linter, foreign_key: true
  end
end
