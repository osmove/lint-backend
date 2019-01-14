class CreateChanges < ActiveRecord::Migration[5.1]
  def change
    create_table :changes do |t|
      t.string :operation
      t.references :document, foreign_key: true
      t.references :commit, foreign_key: true

      t.timestamps
    end
  end
end
