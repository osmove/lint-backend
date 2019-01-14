class CreateCommits < ActiveRecord::Migration[5.1]
  def change
    create_table :commits do |t|
      t.string :message
      t.datetime :date
      t.string :date_raw
      t.string :contributor_raw
      t.string :contributor_name
      t.string :contributor_email
      t.references :repository, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
