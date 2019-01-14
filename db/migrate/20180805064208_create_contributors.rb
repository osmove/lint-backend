class CreateContributors < ActiveRecord::Migration[5.1]
  def change
    create_table :contributors do |t|
      t.string :name
      t.string :email
      t.references :repository, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
