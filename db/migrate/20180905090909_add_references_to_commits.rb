class AddReferencesToCommits < ActiveRecord::Migration[5.1]
  def change
    add_reference :commits, :push, foreign_key: true
  end
end
