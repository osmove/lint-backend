class CreateBranches < ActiveRecord::Migration[5.1]
  def change
    create_table :branches do |t|
      t.string :name
      t.string :slug
      t.boolean :default
      t.references :repository, foreign_key: true

      t.timestamps
    end
  end
end
