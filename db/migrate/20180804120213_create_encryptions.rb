class CreateEncryptions < ActiveRecord::Migration[5.1]
  def change
    create_table :encryptions do |t|
      t.string :status
      t.string :cypher_name
      t.references :document, foreign_key: true
      t.references :repository, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
