class CreateCommitAttempts < ActiveRecord::Migration[5.1]
  def change
    create_table :commit_attempts do |t|
      t.string :message
      t.string :description
      t.references :commit, foreign_key: true
      t.references :user, foreign_key: true
      t.references :contributor, foreign_key: true
      t.references :push, foreign_key: true
      t.references :device, foreign_key: true
      t.references :repository, foreign_key: true

      t.timestamps
    end
  end
end
