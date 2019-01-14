class CreateDocuments < ActiveRecord::Migration[5.1]
  def change
    create_table :documents do |t|
      t.string :name
      t.string :path
      t.boolean :is_folder
      t.integer :size
      t.string :extension
      t.text :content
      t.references :repository, foreign_key: true
      t.references :document, foreign_key: true

      t.timestamps
    end
  end
end
