class AddColumnsToRuleCheck < ActiveRecord::Migration[5.1]
  def change
    add_column :rule_checks, :severity, :string
    add_column :rule_checks, :severity_level, :integer
    add_column :rule_checks, :message, :string
    add_column :rule_checks, :line, :integer
    add_column :rule_checks, :column, :integer
    add_column :rule_checks, :line_end, :integer
    add_column :rule_checks, :column_end, :integer
    add_column :rule_checks, :source, :text
  end
end
