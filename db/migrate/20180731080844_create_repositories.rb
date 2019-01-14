class CreateRepositories < ActiveRecord::Migration[5.1]
  def change
    create_table :repositories do |t|
      t.string :name
      t.string :slug
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
