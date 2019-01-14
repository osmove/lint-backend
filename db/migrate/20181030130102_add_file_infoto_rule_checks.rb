class AddFileInfotoRuleChecks < ActiveRecord::Migration[5.1]
  def change
    add_column :rule_checks, :file_name, :string
    add_column :rule_checks, :file_path, :string
    add_reference :rule_checks, :linter, foreign_key: true
  end
end
