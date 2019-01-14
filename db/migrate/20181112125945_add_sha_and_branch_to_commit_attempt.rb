class AddShaAndBranchToCommitAttempt < ActiveRecord::Migration[5.1]
  def change
    add_column :commit_attempts, :sha, :string
    add_column :commit_attempts, :branch_name, :string
  end
end
