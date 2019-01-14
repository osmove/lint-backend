class AddPassedToCommitAttempts < ActiveRecord::Migration[5.1]
  def change
    add_column :commit_attempts, :passed, :boolean
  end
end
