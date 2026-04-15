class AddAiColumnsToRuleChecksAndCommitAttempts < ActiveRecord::Migration[7.2]
  def change
    add_column :rule_checks, :ai_suggestion, :text
    add_column :rule_checks, :ai_fix, :text

    add_column :commit_attempts, :commit_message_score, :integer
    add_column :commit_attempts, :commit_message_feedback, :text
  end
end
