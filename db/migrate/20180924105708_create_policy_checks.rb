class CreatePolicyChecks < ActiveRecord::Migration[5.1]
  def change
    create_table :policy_checks do |t|
      t.string :name
      t.boolean :passed
      t.references :commit_attempt, foreign_key: true
      t.references :policy, foreign_key: true
      t.references :repository, foreign_key: true
      t.references :user, foreign_key: true
      t.references :contributor, foreign_key: true
      t.references :push, foreign_key: true
      t.references :device, foreign_key: true

      t.timestamps
    end
  end
end
