class CreatePlatforms < ActiveRecord::Migration[5.1]
  def change
    create_table :platforms do |t|
      t.string :name
      t.string :image
      t.references :language, foreign_key: true
      t.references :framework, foreign_key: true

      t.timestamps
    end
  end
end
