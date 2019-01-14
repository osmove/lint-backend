class CreateIssues < ActiveRecord::Migration[5.1]
  def change
    create_table :issues do |t|
      t.string :title
      t.string :slug
      t.string :origin
      t.references :repository, foreign_key: true
      t.references :user, foreign_key: true
      t.references :language, foreign_key: true
      t.references :framework, foreign_key: true

      t.timestamps
    end
  end
end
