class CreateRules < ActiveRecord::Migration[5.1]
  def change
    create_table :rules do |t|
      t.string :name
      t.string :type
      t.string :description
      t.string :status
      t.references :language, foreign_key: true
      t.references :framework, foreign_key: true
      t.references :platform, foreign_key: true
      t.references :rule, :parent, index: true

      t.timestamps
    end
  end
end
