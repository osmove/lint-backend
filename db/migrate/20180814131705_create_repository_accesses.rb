class CreateRepositoryAccesses < ActiveRecord::Migration[5.1]
  def change
    create_table :repository_accesses do |t|
      t.string :role
      t.string :status
      t.references :user, foreign_key: true
      t.references :repository, foreign_key: true

      t.timestamps
    end
  end
end
