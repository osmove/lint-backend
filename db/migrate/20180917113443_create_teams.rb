class CreateTeams < ActiveRecord::Migration[5.1]
  def change
    create_table :teams do |t|
      t.string :name
      t.string :avatar_url
      t.references :team, foreign_key: true
      t.string :description
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
