class AddCommitToPush < ActiveRecord::Migration[5.1]
  def change
    add_reference :pushes, :commit, foreign_key: true
  end
end
