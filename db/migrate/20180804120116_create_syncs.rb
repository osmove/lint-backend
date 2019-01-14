class CreateSyncs < ActiveRecord::Migration[5.1]
  def change
    create_table :syncs do |t|
      t.references :repository, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
